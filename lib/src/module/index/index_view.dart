import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/module/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/module/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/module/home/home_view.dart';
import 'package:app_ft_tmart/src/module/news/news_view.dart';
import 'package:app_ft_tmart/src/module/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/cart_view.dart';
import 'index_logic.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IndexLogic());
    final logicCart = Get.put(CartLogic());
    List<Map<String, dynamic>> bottomNavigationBarItems = [
      {
        'icon': Icon(Icons.home),
        'label': 'Trang chủ',
        'screen': HomePage(),
      },
      {
        'icon': Icon(Icons.list_alt),
        'label': 'Bảng tin',
        'screen': NewsPage(),
      },
      {
        'icon': Obx(() {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: XColor.primary,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.shopping_cart_outlined,
                    color: Colors.white,
                  )
              ),
              Visibility(
                visible:
                logicCart.getCartRsp.value?.data?.cartDetails?.isNotEmpty ==
                    true,
                child: Positioned(
                  right: 10,
                  bottom: 25,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "${logicCart.getCartRsp.value?.data?.cartDetails
                            ?.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
        'label': '',
        'screen': '',
      },
      {
        'icon': Icon(Icons.favorite),
        'label': 'Bộ sưu tập',
        'screen': FavouritesPage(),
      },
      {
        'icon': Icon(Icons.person),
        'label': 'Tài khoản',
        'screen': ProfilePage(),
      },
    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          selectedLabelStyle: TextStyle(color: XColor.primary),

          elevation: 0,
          showSelectedLabels: true,
          onTap: (tab) async {
            logic.tabSelect(tab);
          },
          currentIndex: logic.tabIndex.value,

          // showSelectedLabels: true,
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
