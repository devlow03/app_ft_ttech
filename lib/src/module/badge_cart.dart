import 'package:app_ft_tmart/src/module/cart/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/xcolor.dart';
import 'cart/cart_view.dart';
class BadgeCart  extends StatelessWidget {
  const BadgeCart ({super.key});

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    return Obx(() {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          IconButton(
            onPressed: () {
              Get.to(
                  CartPage());
            },
            icon:
            Icon(Icons.shopping_cart_outlined,color: Colors.white,)
            ,
          ),
          Visibility(
            visible: logicCart.getCartRsp.value?.data?.cartDetails
                ?.isNotEmpty == true,
            child: Positioned(
              right: 5,
              bottom: 25,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${logicCart.getCartRsp.value?.data
                        ?.cartDetails
                        ?.length}",
                    style: TextStyle(
                        color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
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
