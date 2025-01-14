import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/repositories/post_cart_rqst.dart';
import 'package:app_ft_tmart/src/data/repositories/post_update_cart_detail_rqst.dart';
import 'package:app_ft_tmart/src/modules/cart/voucher/voucher_logic.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/get_cart_rsp.dart';
import '../../data/services/service.dart';
import '../../utils/utils.dart';
import '../order/order_logic.dart';

class CartLogic extends GetxController {
  final Services tMartServices = Get.find();
  CartLogic();
  Rxn<GetCartRsp> getCartRsp = Rxn();
  Rx<int> quantity = Rx(1);
  Rxn<String> voucherValue = Rxn();
  Rxn<String> voucherTitle = Rxn('');
  final logic = Get.put(OrderLogic());
  Rxn<bool> onClearCart = Rxn(false);
  Rxn<String>voucherCode = Rxn();
  // final logicVoucher = Get.put(VoucherLogic(Get.find()));
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getCart();
    if (getCartRsp.value?.data?.cartDetails?.isNotEmpty == true ||
        getCartRsp.value?.data != null) {
      onClearCart.value = false;
    } else {
      onClearCart.value = true;
    }
    // await getVoucher();
  }

  @override
  Future<void> refresh() async {
    // TODO: implement refresh
    super.refresh();
    await getCart();
  }

  Future<void>postAddCart({required String productId, required String quantity })async{
    final userUtils = Get.put(UserUtils());
    await userUtils.checkSignIn(intoPage: true);
    await tMartServices.postAddCart(body: PostCartRqst(
        // guestSession: "64FF1EABC08F21694441131",
          productId: productId,
          quantity: quantity
      ));
      await getCart();
      Fluttertoast.showToast(msg: "Đã thêm vào giỏ hàng");



    




  }
  Future<GetCartRsp?> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")!='') {
      getCartRsp.value =
      await tMartServices.getCartRsp();
    }

    // await logic.postCreateShipping(action: "p");
    return getCartRsp.value;
  }

  Future<void> updateCartDetail(
      {required String idCart, required int quantity}) async {
    await tMartServices.postUpdateCartDetailRsp(
        idCart: idCart, body: PostUpdateCartDetailRqst(quantity: quantity));
    await getCart();
  }

  Future<void> deleteCart({required String idCart}) async {
    Get.dialog(AlertDialog(
      content: const Text('Bạn có muốn xóa sản phẩm này ?'),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade200)),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Không',
              style: TextStyle(color: Colors.black),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: XColor.primary,
            ),
            onPressed: () async {
              Get.back();
              Utils.loading(() async {
                await tMartServices.deleteCartDetails(idCart: idCart);
                await refresh();
                if (getCartRsp.value?.data?.cartDetails?.isEmpty == true) {
                  onClearCart.value = true;
                  Get.back();
                } else {
                  onClearCart.value = false;
                  Get.back();
                }
              });
            },
            child: const Text('Đồng ý',style: TextStyle(color: Colors.white),))
      ],
    ));
  }



  Future<void> inCreaseOrDecreaseQuantity(
      {required int index, required String type}) async {
    switch (type) {
      case '-':
        int? quantity = int.parse(
                ((getCartRsp.value?.data?.cartDetails?[index].quantity)
                    .toString())) -
            1;

        if (quantity >= 1) {
          await updateCartDetail(
              idCart:
                  getCartRsp.value?.data?.cartDetails?[index].id.toString() ??
                      "",
              quantity: quantity);
          await getCart();
        } else {
          await deleteCart(
              idCart:
                  getCartRsp.value?.data?.cartDetails?[index].id.toString() ??
                      "");
        }
        break;
      case '+':
        int? quantity = int.parse(((
            getCartRsp
            .value
            ?.data
            ?.cartDetails?[index]
            .quantity)
            .toString())) +
            1;

        if (quantity >= 1) {
          await updateCartDetail(
              idCart: getCartRsp
                  .value
                  ?.data
                  ?.cartDetails?[index]
                  .id
                  .toString() ??
                  "",
              quantity: quantity);

        }
        break;
    }
  }
}
