import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/services/service.dart';

class SearchLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<GetProductRsp>getSearchRsp = Rxn();
  TextEditingController keyController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getSearchRsp.value = null;
  }

  Future<GetProductRsp?>getSearch({List<String>? category,List<String>? brand, List<String>? price})async{
    if(keyController.text!="" ){
      getSearchRsp.value = null;
      getSearchRsp.value = await tMartServices.getProductRsp(query:
      GetProductRqQuery(
          categoryId: (category?.length??0)!=0?category:null,
          perPage:"5",
          productName: keyController.text,
          manufacturerId: (brand?.length??0)!=0?brand:null,
          price:(price?.length??0)!=0?price:null
      )
      );
    }
    return getSearchRsp.value;
  }


}
