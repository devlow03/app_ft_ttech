import 'package:app_ft_tmart/src/data/repositories/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_icon/cart_icon.dart';
import 'package:app_ft_tmart/src/modules/product_detail/bottom/bottom_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/description/description.dart';
import 'package:app_ft_tmart/src/modules/product_detail/info_detai/info_detail.dart';
import 'package:app_ft_tmart/src/modules/product_detail/mini_image_list/mini_image_list.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/produc_reviews.dart';
import 'package:app_ft_tmart/src/modules/product_detail/same_type/same_type.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:app_ft_tmart/src/widget/global_html.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';

import '../../data/repositories/get_product_rsp.dart';
import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';
import '../photo/photo_view.dart';
import 'image_slider/image_slider.dart';
import 'info/info.dart';
import 'product_detail_logic.dart';

class ProductDetailPage extends StatelessWidget {


  const ProductDetailPage({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(ProductDetailLogic(Get.find()));
    // logic.productId.value = id;
    

    return WillPopScope(
      onWillPop: () async {
        logic.quantity.value = 1;
        logic.getProductByIdRsp.value = null;
        logic.indexSlider.value=0;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        body: RefreshIndicator(
        color: XColor.primary,
          onRefresh: () async {
            logic.refresh();

          },
          child: CustomScrollView(
            slivers: [
              Obx(() {
                return SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark),
                  expandedHeight: MediaQuery.of(context).size.height * .5,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: ImageSlider(),
                    stretchModes: [
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                    ],
                  ),
                  pinned: true,
                  stretch: true,
                  actions: [
                    IconButton(
                        onPressed: (){
                          if(logic.getProductByIdRsp.value?.data?.favorite ==true){
                            logic.deleteFavorite();
                          }
                          else{
                            logic.postAddFavorite();
                          }
                        },
                        icon: Visibility(
                          visible:logic.isFavorite.value==true,
                          replacement: const Icon(Icons.favorite_border),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )),
                    CartIcon(),

                  ],
                );
              }),
              SliverToBoxAdapter(child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const MiniImageList(),
                    Visibility(
                      visible:
                          logic.getProductByIdRsp.value?.data.isNull == false,
                      child: const Column(
                        children: [
                          Info(),
                          SizedBox(
                            height: 10,
                          ),
                          InfoDetail(),
                          SizedBox(
                            height: 10,
                          ),
                          DescriptionView(),
                          SizedBox(height: 10,),
                          ProductReviewsPage(),

                          SameType()
                        ],
                      ),
                    ),
                  ],
                );
              }))
            ],
          ),
        ),
        bottomNavigationBar: const BottomDetail(),
      ),
    );
  }
}
