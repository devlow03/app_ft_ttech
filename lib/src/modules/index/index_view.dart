import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/modules/home/home_view.dart';
import 'package:app_ft_tmart/src/modules/news/news_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'index_logic.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IndexLogic());
    final cart = Get.put(CartLogic());
    List<Map<String, dynamic>> bottomNavigationBarItems = [
      {
        'icon': const Icon(Icons.explore_outlined),
        'active': const Icon(Icons.explore),
        'label': 'Trang chủ',
        'screen': const HomePage(),
      },
      {
        'icon': const Icon(Icons.list_alt_outlined),
        'active': const Icon(Icons.list_alt),
        'label': 'Bảng tin',
        'screen': const NewsPage(),
      },
      {
        'icon': Obx(() {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              Icon(Icons.shopping_bag_outlined),
              Visibility(
                visible: cart.getCartRsp.value?.data?.cartDetails?.isNotEmpty ==
                    true,
                child: Positioned(
                  right: 1,
                  bottom: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: XColor.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "${cart.getCartRsp.value?.data?.cartDetails?.length}",
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
        }),


        'label': 'Giỏ hàng',
        'screen': '',

      },
      {
        'icon': const Icon(Icons.favorite_outline),
        'active': const Icon(Icons.favorite),
        'label': 'Yêu thích',
        'screen': const FavouritesPage(),
      },
      {
        'icon': const Icon(Icons.account_circle_outlined),
        'active': const Icon(Icons.account_circle),
        'label': 'Tài khoản',
        'screen': const ProfilePage(),
      },

    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 28,
          selectedLabelStyle: TextStyle(
              color: XColor.primary,
            fontSize: 13

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