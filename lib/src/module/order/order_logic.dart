import 'package:app_ft_tmart/src/data/repositories/post_confirm_order_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_vnpay_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:app_ft_tmart/src/module/order/payments/payments_logic.dart';
import 'package:app_ft_tmart/src/widget/global_html.dart';
import 'package:app_ft_tmart/src/widget/global_webview.dart';
import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/repositories/post_confirm_order_rqst_bodies.dart';
import '../../data/repositories/post_create_vnpay_rsp.dart';
import '../cart/cart_logic.dart';
import '../order_history/order_history_view.dart';

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
          createVnPay();
        }
        else{
          Get.offAll(IndexPage());
          Fluttertoast.showToast(msg: "Đặt hàng thành công",
            backgroundColor: Colors.green
        );
        }
        // Get.back();
        
        
      });
  }

  Future<void>createVnPay()async{
    postVnpayRsp.value=await tMartServices.createVnPay(body: PostCreateVnpayRqstBodies(
      orderId: postOrderRsp.value?.data?.orderId,
    ));
    Get.to(GlobalWebview(
      tittleWeb: "Thanh toán VNPAY",
      linkWeb: "${postVnpayRsp.value?.data}",));
  }

  
}
