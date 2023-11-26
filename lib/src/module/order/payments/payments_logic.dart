import 'package:app_ft_tmart/src/module/cart/cart_logic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../order_logic.dart';

class PaymentsLogic extends GetxController{
  final List<Map<String, dynamic>> paymentList = [
    {
      "title":"Thanh toán khi nhận hàng",
      "thumbnail":"assets/images/cod.png",
      "value":"cod"
    },
    {
      "title":"Ví VNPAY",
      "thumbnail":"assets/images/vnpay.png",
      "value":"vnpay"
    }
  ];
  Rxn<Map<String,dynamic>> selectPayment = Rxn();
  final logicCart = Get.put(CartLogic());

  Future selectPayments(Map<String, dynamic>? value)async{
    selectPayment.value = value;
    Get.back();
    logicCart.getCart();
    Fluttertoast.showToast(msg: "Đã chọn phương thức thanh toán");
  }
}