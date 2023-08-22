import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_product_logic.dart';

class List_productPage extends StatelessWidget {
  const List_productPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(List_productLogic());

    return Container();
  }
}
