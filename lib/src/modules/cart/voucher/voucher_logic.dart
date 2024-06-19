import 'package:app_ft_tmart/src/data/repositories/post_add_voucher.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/repositories/get_voucher_rsp.dart';
import '../cart_logic.dart';

class VoucherLogic extends GetxController {
  final Services tMartServices;
  VoucherLogic(this.tMartServices);
  Rxn<GetVoucherRsp>getVoucherRsp= Rxn();
  TextEditingController voucherCodeController = TextEditingController();


  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getVoucher();



  }

  Future<GetVoucherRsp?>getVoucher()async{
    getVoucherRsp.value = await tMartServices.getVoucherRsp();
    return getVoucherRsp.value;
  }
  final logicCart = Get.put(CartLogic());
  Future<void>addVoucher({required int cartId, required String voucherCode})async{
    Utils.loading(()async{
       await tMartServices.postAddVoucher(
      body: PostAddVoucher(
        cartId: cartId,
        voucherCode: voucherCode
      )
    );
    await logicCart.getCart();
    // logicCart.getVoucher();
    Get.back();
    Get.back();
    Fluttertoast.showToast(msg: "Áp dụng voucher thành công");
    });
    

  }
  Future<void>deleteVoucher({required int cartId})async{
    await tMartServices.deleteVoucher(cartId: cartId);
    await logicCart.getCart();
    // logicCart.getVoucher();
    logicCart.voucherTitle.value=null;
    logicCart.voucherValue.value=null;
    Get.back();


  }
}
