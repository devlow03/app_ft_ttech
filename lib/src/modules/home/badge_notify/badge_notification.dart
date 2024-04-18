import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../cart/cart_view.dart';

class BadgeNotification extends StatelessWidget {
  const BadgeNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());
    logic.getNotifications();
    return Obx(() {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.notifications_outlined),
          ),
          Visibility(
            visible: logic.dataNotification
                .isNotEmpty == true,
            child: Positioned(
              right: 5,
              bottom: 26,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: XColor.primary),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${logic.dataNotification.length}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11
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
