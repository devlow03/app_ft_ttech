import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/respository/get_product_by_category_rsp.dart';
import '../../data/respository/get_product_rsp.dart';
import '../../data/respository/get_search_rsp.dart';
import '../../data/services/service.dart';

class ListProductLogic extends GetxController {
  final Services tMartServices;
  ListProductLogic(this.tMartServices);
  TextEditingController keyController = TextEditingController();
  Rxn<GetProductRsp>getSearchRsp = Rxn();
  Rx<int>page = Rx(6);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);

  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    loadMore();
  }

  Future<GetProductRsp?>getSearch({required String name, required int page})async{
    getSearchRsp.value = await tMartServices.getSearchRsp(name: name,page: page);
    return getSearchRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){
        isLoading.value=true;
        print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
        page.value+=6;
        await getSearch(page: page.value, name: keyController.text);



      }
    });
    isLoading.value=false;
  }
}
