import 'package:app_ft_tmart/src/data/repositories/get_product_rsp.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:app_ft_tmart/src/module/home/category/category_view.dart';
import 'package:app_ft_tmart/src/module/home/product_suggest/product_suggest_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../widget/global_image.dart';
import '../../widget/global_product.dart';
import '../../widget/search_widget.dart';
import '../badge_cart.dart';
import '../cart/cart_logic.dart';
import '../list_product/list_product_view.dart';
import '../product/product_view.dart';
import 'banner/banner_view.dart';
import 'home_logic.dart';
import 'product_by_category/product_by_category_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    final logicCart = Get.put(CartLogic());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: XColor.primary.shade400,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                children: [
                  const Expanded(child: SearchWidget()),
                  const BadgeCart(),
                  IconButton(
                    onPressed: () {

                    },
                    icon:
                    Icon(Icons.notifications_none_outlined,size: 25,color: Colors.white,)
                    ,
                  ),
                ],
              )),
          title: Text("TMART",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          elevation: 0.0,
          actions: [


          ],
        ),
        body: RefreshIndicator(
          color: Colors.black,
          strokeWidth: 3,
          onRefresh: () async {
            logic.refresh();
            logicCart.getCart();
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
        ));
  }
}
