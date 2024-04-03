import 'package:app_ft_tmart/src/data/repositories/post_confirm_order_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_vnpay_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/order/payments/payments_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/order_history/order_history_view.dart';
import 'package:app_ft_tmart/src/widget/global_html.dart';
import 'package:app_ft_tmart/src/widget/global_webview.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../core/realtime_database.dart';
import '../../data/repositories/post_confirm_order_rqst_bodies.dart';
import '../../data/repositories/post_create_vnpay_rsp.dart';
import '../cart/cart_logic.dart';


class OrderLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<PostCreateShippingOrderRsp>postShippingRsp = Rxn();
  TextEditingController cityControl = TextEditingController();
  TextEditingController disControl = TextEditingController();
  TextEditingController wardControl = TextEditingController();
  Rxn<int>totalFee = Rxn(0);
  Rxn<PostConfirmOrderRsp>postOrderRsp = Rxn();
  Rxn<PostCreateVnpayRsp>postVnpayRsp = Rxn();
  // final logicCart = Get.put(CartLogic());
  final realTimeDataBase = Get.put(RealTimeDataBase(Get.find()));
  


  @override
  void onReady()async{

     totalFee.value = 0;
     await postCreateShipping(action: "p");

  }

  
  

  Future<void>postCreateShipping({required String action})async{
    postShippingRsp.value = await tMartServices.postCreateShippingOrder(
      body: PostCreateShippingOrder(
        action: action
      )
    );
    if( postShippingRsp.value?.data?.totalFee!=null){
      totalFee.value = postShippingRsp.value?.data?.totalFee;
    }else{
      totalFee.value = 0;
    }



  }

   Future<void>postConfirmOrder({required num cartId, required String address, required String payment})async{

     Utils.loading(()async{
       await postCreateShipping(action: "c");
        
        postOrderRsp.value = await tMartServices.postConfirmOrder(
            body: PostConfirmOrderRqstBodies(
                cartId: cartId,
                billingAddress: address,
                shippingCompanyId: postShippingRsp.value?.data?.id.toString(),
                payment: payment

            )
        );
        
        if(payment=="vnpay"){
          Get.back();
          createVnPay();
        }
        else{
          Get.back();
          final logicCart = Get.put(CartLogic());
          logicCart.onReady();
          await realTimeDataBase.addData(
            orderId: postOrderRsp.value?.data?.orderId??0,
            title: "Đặt hàng thành công",
             content: "${logicCart.getCartRsp.value?.data?.cartDetails?.first.productName}",
              image: "${logicCart.getCartRsp.value?.data?.cartDetails?.first.thumpnailUrl}"
          );
          Get.back();
          Get.to(const OrderHistoryPage());
         
        }
     });
  }
  Future<void>createVnPay()async{
    
    postVnpayRsp.value=await tMartServices.createVnPay(body: PostCreateVnpayRqstBodies(
      orderId: postOrderRsp.value?.data?.orderId,
    ));
    Get.back();
    Get.to(GlobalWebview(
      intoOrder: true,
      tittleWeb: "Thanh toán VNPAY",
      linkWeb: "${postVnpayRsp.value?.data}",));
  }

  
}
