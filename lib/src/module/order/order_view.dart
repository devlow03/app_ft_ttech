import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_logic.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderLogic());

    return Container();
  }
}
