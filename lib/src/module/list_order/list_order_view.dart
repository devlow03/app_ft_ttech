import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_order_logic.dart';

class List_orderPage extends StatelessWidget {
  const List_orderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(List_orderLogic());

    return Container();
  }
}
