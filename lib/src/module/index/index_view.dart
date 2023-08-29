import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/module/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/module/home/home_view.dart';
import 'package:app_ft_tmart/src/module/news/news_view.dart';
import 'package:app_ft_tmart/src/module/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index_logic.dart';
class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IndexLogic());

    List<Map<String, dynamic>> bottomNavigationBarItems = [
      {
        'icon': Icon(Icons.home_outlined),
        'label': 'Trang chủ',
        'screen': HomePage(),
      },
      {
        'icon': Icon(Icons.list_alt_outlined),
        'label': 'Bảng tin',
        'screen': NewsPage(),
      },
      {
        'icon':Icon(Icons.favorite_border_outlined),
        'label': 'Yêu thích',
        'screen': FavouritesPage(),
      },
      {
        'icon':Icon(Icons.person_outline_outlined),
        'label': 'Tài khoản',
        'screen': ProfilePage(),
      },

    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          // selectedLabelStyle: TextStyle(fontSize: 0),
          backgroundColor: Colors.white,
          selectedItemColor: XColor.primary,
          elevation: 0.0,
          showSelectedLabels: true,
          onTap: logic.tabSelect,
          currentIndex: logic.tabIndex.value,
          items: bottomNavigationBarItems.map((e) {
            return BottomNavigationBarItem(
              icon: e['icon'],
              // activeIcon: e['active'],
              label: e['label'],

            );
          }).toList(),
        ),
        body: bottomNavigationBarItems[logic.tabIndex.value]['screen'],
      );
    });
  }
}