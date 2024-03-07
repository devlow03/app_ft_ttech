import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_logic.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../cart/cart_view.dart';
class BadgeNofication  extends StatelessWidget {
  const BadgeNofication ({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());
    logic.getNotifications();
    return Stack(
        alignment: Alignment.centerRight,
        children: [
          IconButton(
            onPressed: () {
              Get.to(NotificationPage());
            },
            icon:
            Icon(Icons.notifications,color: Colors.white,size: 28,)
            ,
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
                    color: Colors.red),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    "${logic.dataNotification.length}",
                    style: TextStyle(
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
  }
}
