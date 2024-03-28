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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: ()=>Get.to(const NotificationPage()),
              child: Image.asset('assets/images/icons/bell.png',width: 25,height: 25,)
            ),
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
