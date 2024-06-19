import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_logic.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';

class AllProductByCategoryLogic extends GetxController {
  final Services tMartServices = Get.find();
  final logic = Get.put(FilterLogic());
  Rxn<GetProductRsp> getProductByCategory = Rxn();
  Rx<int> page = Rx(6);
  Rxn<bool> isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int> indexPage = Rx(0);
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Rxn<int> idCategory = Rxn();
  Rxn<int> idBrand = Rxn();
  Rxn<String>keyword = Rxn();

  // Rxn<String> viewDefault = Rxn("desc");
  Rxn<String> sortPrice = Rxn("asc");
  Rxn<bool> latestSort = Rxn(false);

  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getProductCategory();

    loadMore();
  }

  @override
  void dispose() {
    // TODO: implement onReady
    super.dispose();
    // keyController.dispose();
  }

  Future<GetProductRsp?> getProductCategory({
    String? name,
    List<String>? category,
    List<String>? brand,
    List<String>? price,
    String? view,
    bool? latest,
    String? rangePrice,
  }) async {
      getProductByCategory.value = null;
      getProductByCategory.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              latest: latest,
              arrangePrice: rangePrice,
              views:null,
              categoryId: idCategory.value!=null?[idCategory.value.toString()]:logic.selectedCategoryTypes.isNotEmpty==true?logic.selectedCategoryTypes:category?.isNotEmpty==true?category:null,
              perPage: page.value.toString(),
              productName: keyword.value,
              manufacturerId: idBrand.value!=null?[idBrand.value.toString()]:logic.selectedBrandTypes.isNotEmpty==true?logic.selectedBrandTypes:brand?.isNotEmpty==true?brand:null,
              price: price ?? (logic.selectedPriceRange.isNotEmpty==true?logic.selectedPriceRange:null),
    ));

    // getProductByCategory.refresh();

    return getProductByCategory.value;
  }

  Future<void> loadMore() async {
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (page.value < (getProductByCategory.value?.meta?.total ?? 0)) {
          isLoading.value = true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value += 10;

            getProductByCategory.value = await tMartServices.getProductRsp(
                query: GetProductRqQuery(
                  latest: logic.selectLatest.value,
                    arrangePrice: logic.sortPrice.value,
                    views: null,
                    categoryId: idCategory.value!=null?[idCategory.value.toString()]:logic.selectedCategoryTypes.isNotEmpty==true?logic.selectedCategoryTypes:null,
                    perPage: page.value.toString(),
                    productName: keyword.value,
                    manufacturerId: idBrand.value!=null?[idBrand.value.toString()]:logic.selectedBrandTypes.isNotEmpty==true?logic.selectedBrandTypes:null,
                    price: logic.selectedPriceRange.isNotEmpty==true
                        ? logic.selectedPriceRange
                        : null),

            );

        }
      }
    });
    isLoading.value = false;
  }

  Future<bool> onWillPop() async {
    getProductByCategory.value = null;
    keyword.value = null;
    logic.selectedBrandTypes.clear();
    logic.selectedCategoryTypes.clear();
    logic.selectedPriceRange.clear();
    page.value = 10;
    return true;
  }
}
