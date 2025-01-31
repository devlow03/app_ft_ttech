import 'package:app_ft_tmart/src/core/realtime_database.dart';
import 'package:app_ft_tmart/src/data/repositories/get_order_by_id_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_repurchase_rqst.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/profile/order_history/order_history_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderDetailLogic extends GetxController {
  final Services tMartServices = Get.find();

  RxList<String> productId = <String>[].obs;
  RxList<String> productQuantity = <String>[].obs;
  Rxn<GetOrderByIdRsp> getOrderByIdRsp = Rxn();

  Future<void> cancelOrder(String? id, String? productName, String? thumbnail,
      String? orderNumber, BuildContext context) async {
    final logic = Get.put(OrderHistoryLogic());
    Utils.loading(() async {
      await tMartServices.cancelOrder(id: id ?? "");

      Get.back();
      await logic.getOrder().then((value) {
        Get.back();
        logic.tabIndex.value = 4;
      });
    });
  }

  Future<void> rePurchase() async {
    await tMartServices.postRepurchase(
        body: PostRepurchaseRqst(
            productId: productId, quantity: productQuantity));
    Fluttertoast.showToast(msg: "Đã thêm sản phẩm vào giỏ hàng");
    Get.to(const CartPage());
  }

  Future<void> addToList(String? id, String? quantity) async {
    productId.add(id ?? "");
    productQuantity.add(quantity ?? "");
  }

  Future<GetOrderByIdRsp?> getOrderById({required String id}) async {
    getOrderByIdRsp.value = await tMartServices.getOrderByIdRsp(id: id);
    return getOrderByIdRsp.value;
  }
}
