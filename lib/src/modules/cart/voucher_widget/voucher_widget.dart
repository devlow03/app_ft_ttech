import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../voucher/voucher_view.dart';

class VoucherWidget extends StatelessWidget {
  const VoucherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());
    return Obx(() {
      return Container(
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        // padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: XColor.primary, width: 1),
            borderRadius: BorderRadius.circular(8)
        ),
        child: ListTile(
          onTap: () =>
              Get.bottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  SizedBox(
                    height:
                    MediaQuery
                        .of(context)
                        .size
                        .height * .6,
                    child: VoucherPage(
                        cartId: int.parse((logic
                            .getCartRsp.value?.data?.id
                            .toString() ??
                            ""))),
                  )),
          leading: Image.asset(
            "assets/images/icons/coupon.png", width: 30, height: 30,),
          title: Text(logic.voucherCode.value ?? "Chọn mã giảm giá",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
          trailing: Text(logic.voucherTitle.value??""),
        ),
      );
    });
  }
}
