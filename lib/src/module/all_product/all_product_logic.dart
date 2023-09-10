import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/respository/get_product_rsp.dart';
import '../../data/services/service.dart';

class AllProductLogic extends GetxController {
  final Services tMartServices;
  AllProductLogic(this.tMartServices);
  Rxn<GetProductRsp>getProductRsp = Rxn();
  Rx<int>totalItem = Rx(0);
  Rx<int>page = Rx(6);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getProduct(page: page.value);
    totalItem.value = getProductRsp.value?.data?.length??0;
    if(indexPage.value<=totalItem.value){
      loadMore();
      isLoading.value=false;

    }
    return;
  }

  void refresh()async{
    super.refresh();
    await getProduct(page: page.value);
  }
  Future<GetProductRsp?>getProduct({required int page})async{
    getProductRsp.value = await tMartServices.getProductRsp(page: page);
    return getProductRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){
        isLoading.value=true;
        print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value+=6;
          await getProduct(page: page.value);



      }
    });
    isLoading.value=false;
  }

}
