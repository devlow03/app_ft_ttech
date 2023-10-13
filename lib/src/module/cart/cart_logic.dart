import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/repositories/post_update_cart_detail_rqst.dart';
import 'package:app_ft_tmart/src/module/cart/voucher/voucher_logic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_cart_rsp.dart';
import '../../data/services/service.dart';
import '../../widget/utils.dart';

class CartLogic extends GetxController {
  final Services tMartServices;
  CartLogic(this.tMartServices);
  Rxn<GetCartRsp>getCartRsp = Rxn();
  Rx<int>quantity = Rx(1);
  Rxn<String>voucherValue = Rxn();
  Rxn<String>voucherTitle = Rxn();
  // final logicVoucher = Get.put(VoucherLogic(Get.find()));
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getCart();
    getVoucher();

  }

  @override
  void refresh() async{
    // TODO: implement refresh
    super.refresh();
    await getCart();
  }
  Future<GetCartRsp?>getCart()async{
    getCartRsp.value = await tMartServices.getCartRsp(session: "64FF1EABC08F21694441131");
    return getCartRsp.value;
  }

  Future<void>updateCartDetail({required String idCart,required int quantity })async{
    Utils.loading(()async{
      await tMartServices.postUpdateCartDetailRsp(idCart: idCart, body: PostUpdateCartDetailRqst(
          quantity: quantity
      ));
      await getCart();
    });
  }
  Future<void>deleteCart({required String idCart})async{
    Get.dialog(
        AlertDialog(
          content: Text('Bạn có muốn xóa sản phẩm này ?'),
          actions: [
            ElevatedButton(
                style:ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(
                        color: Colors.grey.shade200
                    )
                ),
                onPressed: (){
                  Get.back();
                },
                child: Text('Không',
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
            ),
            ElevatedButton(
                style:ElevatedButton.styleFrom(
                  primary: XColor.primary,

                ),
                onPressed: ()async{
                  Get.back();
                  Utils.loading(()async{
                    await tMartServices.deleteCartDetails(idCart: idCart);
                    await getCart();
                  });


                },
                child: Text('Đồng ý')
            )
          ],
        ));
  }

  void getVoucher(){
    try{
      for(int i=0;i<=(getCartRsp.value?.data?.info?.length??0);i++){
        if(getCartRsp.value?.data?.info?[i].code == "voucher"){
          voucherValue.value = (getCartRsp.value?.data?.info?[i].text).toString();
          voucherTitle.value = (getCartRsp.value?.data?.info?[i].title).toString();
        }

      }

    }catch(e){
      print(e);
    }
  }

}
