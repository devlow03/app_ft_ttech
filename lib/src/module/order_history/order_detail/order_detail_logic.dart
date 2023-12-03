import 'package:app_ft_tmart/src/data/repositories/get_order_by_id_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_repurchase_rqst.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:app_ft_tmart/src/module/order_history/order_history_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/realtime_database.dart';
import '../../../data/services/service.dart';

class OrderDetailLogic extends GetxController {
  final Services tMartServices = Get.find();
  final realTimeDataBase = Get.put(RealTimeDataBase(Get.find()));
  RxList<String> productId = <String>[].obs;
  RxList<String> productQuantity = <String>[].obs;
  Rxn<GetOrderByIdRsp> getOrderByIdRsp = Rxn();

  Future<void> cancelOrder(
      String? id, String? productName, String? thumbnail, String? orderNumber) async {
    final logic = Get.put(OrderHistoryLogic());
    Utils.loading(() async {
      await tMartServices.cancelOrder(id: id ?? "");
      Fluttertoast.showToast(msg: "Bạn đã hủy đơn hàng");
      await realTimeDataBase.addData(
          
          orderId: int.parse(id ?? ""),
          title: "Đã hủy đơn hàng $orderNumber thành công",
          content: "${productName}",
          image: "${thumbnail}");
      await logic.getOrder();
      Get.back();
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

  Future<GetOrderByIdRsp?>getOrderById({required String id})async{
    getOrderByIdRsp.value = await tMartServices.getOrderByIdRsp(id: id);
    return getOrderByIdRsp.value;
  }
}
