import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_icon/cart_icon.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.put(CartLogic());
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        GestureDetector(
          onTap: () async {
            final userUtils = Get.put(UserUtils());
            if (await userUtils.checkSignIn(intoPage: true) == true) {
              await cart.getCart();
              Get.to(const CartPage());
            }
          },
          child: Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
            ),
            child: CartIcon(fromHome: true,),
          ),
        ),
        Obx(() {
          return Visibility(
            visible: cart.getCartRsp.value?.data
                ?.cartDetails?.isNotEmpty ==
                true,
            child: Positioned(
              right: 5,
              bottom: 23,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: XColor.primary),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${cart.getCartRsp.value?.data?.cartDetails?.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
