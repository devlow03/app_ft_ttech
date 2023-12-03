import 'package:app_ft_tmart/src/data/repositories/get_product_rq_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_rsp.dart';
import '../../data/services/service.dart';

class FavouritesLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<GetProductRsp>getProductFavoriteRsp = Rxn();
  Rx<int>page = Rx(4);
  
  final ScrollController controller = ScrollController();
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getProductFavorite();
    loadMore();

  }

  Future<GetProductRsp?>getProductFavorite()async{
    getProductFavoriteRsp.value = await tMartServices.getProductFavoriteRsp(
      query: GetProductRqQuery(
        perPage: "${page.value}"
      )
    );
    return getProductFavoriteRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){
        if(page.value<(getProductFavoriteRsp.value?.meta?.total??0)){
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value+=10;
          print(">>>>page: ${page.value}");
          await getProductFavorite();
        }



      }
    });
    
  }

  
}
