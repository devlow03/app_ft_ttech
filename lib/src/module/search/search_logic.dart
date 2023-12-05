import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        List<String>? category,
        List<String>? brand,
        List<String>? price}) async {


      getSearchRsp.value = null;
      getSearchRsp.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: (category?.length ?? 0) != 0 ? category : null,
              perPage: page.value.toString(),
              productName: keyController.text,
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
}