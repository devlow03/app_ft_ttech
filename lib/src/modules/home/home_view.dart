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
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Scaffold(
            appBar: (logic.positionPixel.value ?? 0) >= 300
                ? AppBar(
                    backgroundColor: Colors.grey.shade50,
                    title: const SearchAndCart(),
              elevation: 1,
                  )
                : null,
            backgroundColor: Colors.grey.shade50,
            body: RefreshIndicator(
              color: XColor.primary,
              strokeWidth: 3,
              onRefresh: () async {
                logic.refresh();
              },
              child: CustomScrollView(
                controller: logic.controller,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.grey.shade50,
                    leading: null,
                    title: Row(

                      children: [
                        CircleAvatarAppBar(
                            logic: logic,
                            profile: profile,
                            profileDetail: profileDetail),
                        const SizedBox(width: 15,),
                        TitleAppBar(logic: logic, profile: profile),
                      ],
                    ),
                    centerTitle: false,
                    elevation: 0.0,
                    actions: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PhosphorIcon(PhosphorIconsBold.bell)
                      )

                    ],
                    pinned: false,
                    stretch: true,
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          SearchAndCart(),
                          BannerPage(),
                          CategoryPage(),
                          
                        ],
                      ),
                    ),
                  ),
                  const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      sliver: ProductByCategoryPage()),
                  SliverToBoxAdapter(
                      child: Visibility(
                    visible: logic.page.value <
                        (logic.getProductByCategoryRsp.value?.meta?.total ?? 0),
                    replacement: const Center(),
                    child: const Center(
                        child: SpinKitCircle(
                      size: 40,
                      color: Colors.grey,
                    )),
                  ))
                ],
              ),
            )),
      );
    });
  }
}

class CircleAvatarAppBar extends StatelessWidget {
  const CircleAvatarAppBar({
    super.key,
    required this.logic,
    required this.profile,
    required this.profileDetail,
  });

  final HomeLogic logic;
  final ProfileLogic profile;
  final ProfileDetailLogic profileDetail;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
      visible: logic.isSignIn.value,
      replacement: const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage("assets/images/avatar.png")),
      child: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(
            "${profile.getUserProfileRsp.value?.data?.avatar != null ? (profile.getUserProfileRsp.value?.data?.avatar) : (profileDetail.networkImage.value)}"),
      ),
    ));
  }
}

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    super.key,
    required this.logic,
    required this.profile,
  });

  final HomeLogic logic;
  final ProfileLogic profile;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: logic.isSignIn.value,
        replacement: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "Xin Chào 👋 \n",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5)),
            TextSpan(
                text: "Chào mừng bạn đến với TMart",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    height: 1.5))
          ]),
        ),
        child: RichText(
          text: TextSpan(children: [
            const TextSpan(
                text: "Xin Chào 👋 \n",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5)),
            TextSpan(
                text: profile.getUserProfileRsp.value?.data?.fullName ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    height: 1.5))
          ]),
        ),
      );
    });
  }
}

class SearchAndCart extends StatelessWidget {
  const SearchAndCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: SearchWidget(
            onTap: () => Get.to(const SearchPage()),
            readOnly: true,
          ),
        ),
        const Expanded(flex: 2, child: CartWidget())
      ],
    );
  }
}
