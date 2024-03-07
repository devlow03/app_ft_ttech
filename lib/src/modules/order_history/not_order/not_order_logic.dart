import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/home_logic.dart';

class NotOrderLogic extends GetxController{
  final ScrollController controller = ScrollController();
  final logic = Get.put(HomeLogic());
  

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadMore();

  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){
        if(logic.page.value<(logic.getProductRsp.value?.meta?.total??0)){
          
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          logic.page.value+=10;
          print(">>>>page: ${logic.page.value}");
          await logic.getProduct();
        }



      }
    });
    
  }

  Future<bool>onWillPop()async{
    logic.page.value=10;
    return true;
    
  }
}