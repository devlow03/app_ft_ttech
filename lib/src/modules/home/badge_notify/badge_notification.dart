import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../cart/cart_view.dart';

class BadgeNotification extends StatelessWidget {
  const BadgeNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());
    // logic.getNotifications();
    return Obx(() {
      return Positioned(
        bottom: 8,
        child: Visibility(
          visible: logic.notificationLength.value!=0,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: XColor.primary),
            child: Text(
              "${logic.notificationLength.value}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  
              ),
            ),
          ),
        ),
      );
    });
  }
}
