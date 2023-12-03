import 'package:app_ft_tmart/src/data/repositories/get_order_rqst.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_order_rsp.dart';
import '../../data/repositories/post_create_vnpay_rqst_bodies.dart';
import '../../data/repositories/post_create_vnpay_rsp.dart';
import '../../widget/global_webview.dart';

class OrderHistoryLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<GetOrderRsp>getOrderRsp = Rxn();
  Rxn<int>tabIndex = Rxn(0);
  final List<Map<String, String>> tabOrder = [
    {
      "name":"Đang xử lí",
      "value":"pending"
    },

    {
      "name":"Chờ lấy hàng",
      "value":"pending_pickup"
    },

    {
      "name":"Chờ giao hàng",
      "value":"pending_delivery"
    },

    {
      "name":"Đã giao hàng",
      "value":"delivered"
    },

    {
      "name":"Đã hủy",
      "value":"cancelled"
    },

    {
      "name":"Trả hàng",
      "value":"returned"
    }


  ];
  Rx<int>page = Rx(10);
  Rxn<PostCreateVnpayRsp>postVnpayRsp = Rxn();
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    
     await getOrderRsp();
  }

  Future<GetOrderRsp?>getOrder()async{
   
      
      getOrderRsp.value = await tMartServices.getOrderRsp(query: GetOrderRqst(
      perPage: page.value.toString(),
      statusCode: "${tabIndex.value!=null?(tabOrder[tabIndex.value??0]["value"]):(tabOrder[0]["value"])}"
      
    ));
    print(">>>>>>>>>>>>>>>>>>>index: ${tabOrder[tabIndex.value??0]["value"]}");
    getOrderRsp.refresh();
   
      
    return getOrderRsp.value;
  }

  Future<void>createVnPay(int id)async{
    postVnpayRsp.value=await tMartServices.createVnPay(body: PostCreateVnpayRqstBodies(
      orderId: id,
    ));
    Get.to(GlobalWebview(
      intoOrder: true,
      tittleWeb: "Thanh toán VNPAY",
      linkWeb: "${postVnpayRsp.value?.data}",));
  }

  
}
