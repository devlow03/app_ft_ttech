import 'package:app_ft_tmart/src/data/repositories/get_product_rsp.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/home/category/category_view.dart';
import 'package:app_ft_tmart/src/modules/home/product_suggest/product_suggest_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_detail/profile_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_view.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

import 'cart_widget/cart_widget.dart';
import 'home_logic.dart';
import 'product_by_category/product_by_category_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    final profile = Get.put(ProfileLogic());
    final profileDetail = Get.put(ProfileDetailLogic());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Scaffold(
          backgroundColor: Colors.white,

          body:RefreshIndicator(
        color: XColor.primary,

                strokeWidth: 3,
                onRefresh: () async {
                  logic.refresh();
                },
            child: CustomScrollView(
              controller: logic.controller,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: null,
                  title: Obx(() {

                    return Visibility(
                      visible: logic.isSignIn.value,
                      replacement: RichText(
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "👋 Xin Chào! \n",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5
                                  )
                              ),
                              TextSpan(
                                  text: "Chào mừng bạn đến với TMart",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    height: 1.5
                                  )
                              )
                            ]
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "👋 Xin Chào! \n",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5
                                  )
                              ),
                              TextSpan(
                                  text: profile.getUserProfileRsp.value?.data
                                      ?.fullName ?? "",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      height: 1.5
                                  )
                              )
                            ]
                        ),
                      ),
                    );
                  }),
                  centerTitle: false,
                  elevation: 0.0,
                  actions: [
                    // BadgeNofication(),
                    Obx(() =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: ()async{
                              // await logic.userUtils.checkSignIn();
                              bool isLogin = await logic.userUtils.checkSignIn(intoPage: false);
                              print(">>>>>>>>>>>>>>>>>>>>$isLogin");
                              if(isLogin){
                                await profile.getUserProfile();
                                Get.to(ProfilePage());
                              }
                            },
                            child: Visibility(
                              visible: logic.isSignIn.value,
                              replacement: const CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage("assets/images/avatar.png")
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                    "${profile.getUserProfileRsp.value?.data
                                        ?.avatar != null ? (profile.getUserProfileRsp
                                        .value?.data?.avatar) : (profileDetail
                                        .networkImage.value)}"),
                              ),
                            ),
                          ),
                        )),

                  ],
                  pinned: false,
                  stretch: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15,horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: SearchWidget(
                                onTap: () => Get.to(const SearchPage()),
                                readOnly: true,
                              ),
                            ),

                            const Expanded(
                                flex: 2,
                                child: CartWidget())

                          ],
                        ),
                        const BannerPage(),
                        const CategoryPage(),

                      ],
                    ),
                  ),
                ),
                const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    sliver: ProductByCategoryPage()),
                Obx(() {
                  return SliverToBoxAdapter(
                      child: Visibility(
                        visible: logic.page.value <
                            (logic.getProductByCategoryRsp.value?.meta
                                ?.total ??
                                0),
                        replacement: const Center(),
                        child: const Center(
                            child: SpinKitCircle(size: 40,
                              color: Colors.grey,
                            )
                        ),
                      )
                  );
                })
              ],

            ),
          )



        // RefreshIndicator(

        //     color: Colors.black,
        //     strokeWidth: 3,
        //     onRefresh: () async {
        //       logic.refresh();
        //     },
        //     child: ListView(
        //       controller: logic.controller,
        //       children: [
        //         const BannerPage(),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             const CategoryPage(),
        //             const ProductByCategoryPage(),
        //             const SizedBox(height: 10,),
        //             Obx(() {
        //               return Visibility(
        //                 visible: logic.page.value <
        //                     (logic.getProductByCategoryRsp.value?.meta
        //                         ?.total ??
        //                         0),
        //                 replacement: Center(),
        //                 child: Center(
        //                     child: SpinKitCircle(size: 40,
        //                       color: Colors.grey,
        //                     )
        //                 ),
        //               );
        //             }),
        //
        //             // // SizedBox(height: 20,),
        //             // ProductSuggestPage()
        //
        //           ],
        //         ),
        //
        //
        //         const SizedBox(
        //           height: 30,
        //         ),
        //       ],
        //     )
        //
        //   // body: Text('a'),
        // )

      ),
    );
  }
}
