import 'package:app_ft_tmart/src/data/repositories/get_search_suggestion.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_search_suggestions/google_search_suggestions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/services/service.dart';
import 'list_product/filter/filter_logic.dart';

class SearchLogic extends GetxController {
  final Services tMartServices = Get.find();
  final logic = Get.put(FilterLogic());

  Rxn<GetProductRsp> getSearchRsp = Rxn();
  Rx<int> page = Rx(6);
  Rxn<bool> isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int> indexPage = Rx(0);
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TextEditingController keyController = TextEditingController();
  Rxn<GetSearchSuggestion> getSearchSuggestionRsp = Rxn();

  void onReady() async {
    // TODO: implement onReady
    super.onReady();

    loadMore();
  }

  @override
  void dispose() {
    // TODO: implement onReady
    super.dispose();
    // keyController.dispose();
  }

  Future<GetProductRsp?> getSearch(
      {
        String? name,
        List<String>? category,
        List<String>? brand,
        List<String>? price}) async {


      getSearchRsp.value = null;
      getSearchRsp.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: (category?.length ?? 0) != 0 ? category : null,
              perPage: page.value.toString(),
              productName: name??keyController.text,
              manufacturerId: (brand?.length ?? 0) != 0 ? brand : null,
              price: (price?.length ?? 0) != 0 ? price : null));

    return getSearchRsp.value;
  }

  Future<void> loadMore() async {
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (page.value < (getSearchRsp.value?.meta?.total ?? 0)) {
          isLoading.value = true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value += 10;
          getSearchRsp.value = await tMartServices.getProductRsp(
              query: GetProductRqQuery(
                categoryId: logic.selectedCategoryTypes.isNotEmpty == true
                    ? (logic.selectedCategoryTypes)
                    : null,
                perPage: page.value.toString(),
                productName: keyController.text,
                manufacturerId: logic.selectedBrandTypes.isNotEmpty == true
                    ? (logic.selectedBrandTypes)
                    : null,
                price: logic.selectedPriceRange.isNotEmpty == true
                    ? (logic.selectedPriceRange)
                    : null,
              ));
        }
      }
    });
    isLoading.value = false;
  }

  Future<bool> onWillPop() async {
    getSearchRsp.value = null;
    keyController.clear();
    logic.selectedBrandTypes.clear();
    logic.selectedCategoryTypes.clear();
    logic.selectedPriceRange.clear();
    page.value = 10;
    return true;
    return true;
  }

  Future<GetSearchSuggestion?>getSearchSuggest()async{
    final Dio dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(
        printOnSuccess: true
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final response = await dio.get("https://tiki.vn/api/v2/search/suggestion?trackity_id=f4e8ab84-2c07-6368-78fb-460295c8c98f&q=${keyController.text}");


    if (response.data is Map<String, dynamic>) {
      getSearchSuggestionRsp.value = GetSearchSuggestion.fromJson(response.data as Map<String, dynamic>);

      return getSearchSuggestionRsp.value;
    } else {

      return null;
    }
  }
}