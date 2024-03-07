// import 'package:app_ft_tmart/src/module/home/home_logic.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProductSuggestLogic extends GetxController{
//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//     loadMore();
//   }
//   final ScrollController controller = ScrollController();
//   Rx<int>page = Rx(10);
//   final logic = Get.put(HomeLogic());
//   Future<void>loadMore()async {
//     controller.addListener(() async{
//       if(controller.position.maxScrollExtent == controller.offset){
//         if(page.value<(logic.getProductRsp.value?.meta?.total??0)){
//           logic.isLoading.value=true;
//           print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
//           page.value+=10;
//           print(">>>>page: ${page.value}");
//           await logic.getProduct();
//         }



//       }
//     });
//     logic.isLoading.value=false;
//   }
// }