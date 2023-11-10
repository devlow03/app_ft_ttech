import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order.dart';
import 'package:app_ft_tmart/src/data/repositories/post_create_shipping_order_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/repositories/post_confirm_order_rqst_bodies.dart';
import '../cart/cart_logic.dart';

class OrderLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<PostCreateShippingOrderRsp>postShippingRsp = Rxn();
  TextEditingController cityControl = TextEditingController();
  TextEditingController disControl = TextEditingController();
  TextEditingController wardControl = TextEditingController();
  Rxn<int>totalFee = Rxn(0);
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

  Future postConfirmOrder({required num cartId, required String address})async{

      Utils.loading(()async{
        await postCreateShipping(action: "c");
        await tMartServices.postConfirmOrder(
            body: PostConfirmOrderRqstBodies(
                cartId: cartId??0,
                billingAddress: address,
                shippingCompanyId: "1",
                paymentUid: "1"


            )
        );

        Get.offAll(IndexPage());
        Fluttertoast.showToast(msg: "Đặt hàng thành công",
          backgroundColor: Colors.green
        );


      });

  }
}
