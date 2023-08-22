import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_logic.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());

    return Container();
  }
}
