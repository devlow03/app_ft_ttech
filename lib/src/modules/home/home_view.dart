import 'package:app_ft_tmart/src/data/repositories/get_product_rsp.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/home/category/category_view.dart';
import 'package:app_ft_tmart/src/modules/home/product_suggest/product_suggest_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../widget/global_image.dart';
import '../../widget/global_product.dart';
import '../../widget/search_widget.dart';

import '../cart/cart_logic.dart';
import '../notification/notification_view.dart';
import '../search/list_product/list_product_view.dart';
import '../product_detail/product_detail_view.dart';
import 'badge_notify/badge_notification.dart';
import 'banner/banner_view.dart';
import 'home_logic.dart';
import 'product_by_category/product_by_category_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            backgroundColor: Colors.white,
            leading: null,
            title: Expanded(child: SearchWidget()),
            centerTitle: false,
            elevation: 0.0,
            actions: [
              BadgeNofication(),

            ],
          ),
          body: RefreshIndicator(
            color: Colors.black,
            strokeWidth: 3,
            onRefresh: () async {
              logic.refresh();

            },
            child:ListView(
              controller: logic.controller,
              children: [
                const BannerPage(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CategoryPage(),
                    ProductByCategoryPage(),
                    SizedBox(height: 20,),
                    ProductSuggestPage()

                  ],
                ),


                const SizedBox(
                  height: 30,
                ),
              ],
            )

            // body: Text('a'),
          )),
    );
  }
}
