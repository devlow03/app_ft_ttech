import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/modules/home/badge_notify/badge_notification.dart';
import 'package:app_ft_tmart/src/modules/home/home_view.dart';
import 'package:app_ft_tmart/src/modules/news/news_view.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'index_logic.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IndexLogic());
    final cart = Get.put(CartLogic());
    List<Map<String, dynamic>> bottomNavigationBarItems = [
      {
        'icon':  PhosphorIcon(PhosphorIcons.house(PhosphorIconsStyle.bold)),
        'active':  PhosphorIcon(PhosphorIcons.house(PhosphorIconsStyle.fill)),
        'label': 'Trang chủ',
        'screen': const HomePage(),
      },
      {
        'icon': PhosphorIcon(PhosphorIcons.article(PhosphorIconsStyle.bold)),
        'active':PhosphorIcon(PhosphorIcons.article(PhosphorIconsStyle.fill)),
        'label': 'Bảng tin',
        'screen': const NewsPage(),
      },

      {
        'icon': const Icon(Icons.favorite_outline),
        'active': const Icon(Icons.favorite),
        'label': 'Yêu thích',
        'screen': const FavouritesPage(),
      },

      {
        'icon': PhosphorIcon(PhosphorIcons.user(PhosphorIconsStyle.bold)),
        'active':PhosphorIcon(PhosphorIcons.user(PhosphorIconsStyle.fill)),
        'label': 'Tài khoản',
        'screen':  ProfilePage(),
      },

    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          selectedLabelStyle: TextStyle(
              color: XColor.primary,
            fontSize: 0

          ),
          // selectedFontSize: 0,
          elevation: 0,
          // showSelectedLabels: false,
          onTap: (tab) async {
            logic.tabSelect(tab);
          },
          currentIndex: logic.tabIndex.value,

          // showSelectedLabels: true,
          items: bottomNavigationBarItems.map((e) {
            return BottomNavigationBarItem(
              icon: e['icon'],
              activeIcon: e['active'],
              label: e['label'],

            );
          }).toList(),
        ),
        body: bottomNavigationBarItems[logic.tabIndex.value]['screen'],
      );
    });
  }
}