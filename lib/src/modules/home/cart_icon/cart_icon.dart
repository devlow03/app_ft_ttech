import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.put(CartLogic());
    return Obx(() {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          InkWell(
            onTap: () async {
        await cart.getCart();
        Get.to(const CartPage(),transition: Transition.rightToLeft);
      },
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100
              ),
              child: Icon(Icons.shopping_cart_outlined),
              ),
          ),
          
          Visibility(
            visible: cart.getCartRsp.value?.data
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
                    "${cart.getCartRsp.value?.data?.cartDetails?.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
