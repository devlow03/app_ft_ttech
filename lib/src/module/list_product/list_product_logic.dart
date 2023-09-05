import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/respository/get_product_by_category_rsp.dart';
import '../../data/respository/get_search_rsp.dart';
import '../../data/services/service.dart';

class ListProductLogic extends GetxController {
  final Services tMartServices;
  ListProductLogic(this.tMartServices);
  TextEditingController keyController = TextEditingController();
  Rxn<GetSearchRsp>getProductRsp = Rxn();

  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getProduct;
  }

  Future<GetSearchRsp?>getProduct({required String name})async{
    // getProductRsp.value = await tMartServices.getSearch(name: name);
    return getProductRsp.value;
  }
}
