import 'package:app_ft_tmart/src/module/favourites/favourites_view.dart';
import 'package:app_ft_tmart/src/module/news/news_view.dart';
import 'package:app_ft_tmart/src/module/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/xcolor.dart';
import '../home/home_view.dart';
import 'index_logic.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    NewsPage(),
    FavouritesPage(),
    ProfilePage(),
    // ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IndexLogic());


    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              // tabBorderRadius: 8,
              backgroundColor: Colors.white,
              rippleColor: Colors.blue,
              hoverColor: Colors.blue,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: XColor.primary,
              color: Colors.white,
              // tabActiveBorder: Border.fromBorderSide(BorderSide(
              //   color: Colors.blue.shade700
              // )),
              tabs:  [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Trang chủ',
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: Icons.list_alt,
                  text: 'Tin tức',
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: Icons.favorite_border_outlined,
                  text: 'Yêu thích',
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: Icons.person_outlined,
                  text: 'Tài khoản',
                  iconColor: Colors.black,
                ),

              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
