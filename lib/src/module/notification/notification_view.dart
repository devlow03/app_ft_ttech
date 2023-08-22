import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_logic.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());

    return Container();
  }
}
