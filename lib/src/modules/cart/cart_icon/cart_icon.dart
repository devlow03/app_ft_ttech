import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CartIcon extends StatelessWidget {
   CartIcon({super.key, this.fromHome});
  bool? fromHome = false;

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());
    final userUtils = Get.put(UserUtils());
    return Obx(() {
      return Visibility(
        visible: fromHome!=true,
        replacement: const PhosphorIcon(PhosphorIconsBold.shoppingCartSimple),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            IconButton(
              onPressed: () async {
                if(await userUtils.checkSignIn(intoPage: true)==true){
                  await logic.getCart();
                  Get.to(const CartPage());
                }

              },
              icon: const PhosphorIcon(PhosphorIconsBold.shoppingCartSimple),
            ),
            Visibility(
              visible: logic.getCartRsp.value?.data
                  ?.cartDetails?.isNotEmpty ==
                  true,
              child: Positioned(
                right: 5,
                bottom: 25,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: XColor.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${logic.getCartRsp.value?.data?.cartDetails?.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
