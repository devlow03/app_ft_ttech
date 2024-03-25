import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/modules/home/home_view.dart';
import 'package:app_ft_tmart/src/modules/news/news_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_view.dart';
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
        'icon': const Icon(Icons.home_outlined),
        'active':const Icon(Icons.home),
        'label': 'Trang chủ',
        'screen': const HomePage(),
      },
      {
        'icon': const Icon(Icons.list_alt_outlined),
        'active':const Icon(Icons.list_alt),
        'label': 'Bảng tin',
        'screen': const NewsPage(),
      },
      {
        'icon':Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: XColor.primary,
            shape: BoxShape.circle
          ),
          child: const Icon(Icons.shopping_cart_outlined,
          color: Colors.white,
          )
        ),
        'label': '',
        'screen': '',
      
      },
      {
        'icon':const Icon(Icons.favorite_outline),
        'active':const Icon(Icons.favorite),
        'label': 'Bộ sưu tập',
        'screen': const FavouritesPage(),
      },
      {
        'icon':const Icon(Icons.person_outline),
        'active':const Icon(Icons.person),
        'label': 'Tài khoản',
        'screen': const ProfilePage(),
      },

    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          selectedLabelStyle: TextStyle(
              color: XColor.primary
          ),

          elevation: 0,
          showSelectedLabels: true,
          onTap: (tab)async{
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