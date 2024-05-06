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
  TextEditingController keyController = TextEditingController();
  Rxn<int>idCategory = Rxn();
  Rxn<int>idBrand = Rxn();

  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getProductCategory();
    print(">>>>>>>>>>>>>>2:${keyController.text}");
    loadMore();
  }

  @override
  void dispose() {
    // TODO: implement onReady
    super.dispose();
    // keyController.dispose();
  }

  Future<GetProductRsp?> getProductCategory(
      {String? name,
        List<String>? category,
        List<String>? brand,
        List<String>? price}) async {

    if(idCategory.value !=null){
      getProductByCategory.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: [idCategory.toString()],
              perPage: page.value.toString(),
              productName: keyController.text,
              manufacturerId: (brand?.length ?? 0) != 0 ? brand : null,
              price: (price?.length ?? 0) != 0 ? price : null));
    }
   else if(idBrand.value!=null){
      getProductByCategory.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: (category?.length ?? 0) != 0 ? category : null,
              perPage: page.value.toString(),
              productName: keyController.text,
              manufacturerId: [idBrand.toString()],
              price: (price?.length ?? 0) != 0 ? price : null));

    }
   else{
      getProductByCategory.value = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: (category?.length ?? 0) != 0 ? category : null,
              perPage: page.value.toString(),
              productName: keyController.text,
              manufacturerId: (brand?.length ?? 0) != 0 ? brand : null,
              price: (price?.length ?? 0) != 0 ? price : null));
    }
    getProductByCategory.refresh();

    return getProductByCategory.value;
  }

  Future<void> loadMore() async {
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (page.value < (getProductByCategory.value?.meta?.total ?? 0)) {
          isLoading.value = true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value += 10;
         if(idCategory.value!=null){
           getProductByCategory.value = await tMartServices.getProductRsp(
               query: GetProductRqQuery(
                   categoryId: [idCategory.toString()],
                   perPage: page.value.toString(),
                   productName: keyController.text,
                   manufacturerId: (logic.selectedBrandTypes.length ?? 0) != 0 ? logic.selectedBrandTypes: null,
                   price: (logic.selectedPriceRange.length ?? 0) != 0 ? logic.selectedPriceRange : null));
         }
         else if(idBrand.value!=null){
           getProductByCategory.value = await tMartServices.getProductRsp(
               query: GetProductRqQuery(
                   categoryId: (logic.selectedCategoryTypes.length ?? 0) != 0 ? logic.selectedCategoryTypes: null,
                   perPage: page.value.toString(),
                   productName: keyController.text,
                   manufacturerId: [idBrand.toString()],
                   price: (logic.selectedPriceRange.length ?? 0) != 0 ? logic.selectedPriceRange : null));

         }
        }
      }
    });
    isLoading.value = false;
  }

  Future<bool> onWillPop() async {
    getProductByCategory.value = null;
    keyController.clear();
    logic.selectedBrandTypes.clear();
    logic.selectedCategoryTypes.clear();
    logic.selectedPriceRange.clear();
    page.value = 10;
    return true;
    
  }
}
