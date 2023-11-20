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

  Future<GetProductRsp?>getSearch({required String name,List<String>? category,List<String>? brand, List<String>? price})async{

    getSearchRsp.value = await tMartServices.getProductRsp(query:
    GetProductRqQuery(
        categoryId: (category?.length??0)!=0?category:null,
        perPage: '6',
        productName: name,
        manufacturerId: (brand?.length??0)!=0?brand:null,
        price:(price?.length??0)!=0?price:null
    )
    );
    getSearchRsp.refresh();
    return getSearchRsp.value;
  }


}
