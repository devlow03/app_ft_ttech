import 'package:app_ft_tmart/src/modules/home/home_logic.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_image.dart';
import '../../product_detail/product_detail_view.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Obx(() {
      return Column(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: XColor.primary.shade400,
                      // borderRadius: const BorderRadius.only(
                      //     bottomRight: Radius.circular(20),
                      //     bottomLeft: Radius.circular(20))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Visibility(
                        visible: logic.getBannerRsp.value?.data?.isEmpty ==
                            false,
                        replacement: CarouselSlider.builder(
                          itemCount: 1,
                          options: CarouselOptions(
                              aspectRatio: 25 / 11,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 7),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                // logic.activeIndex.value = index;
                              }),
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        child: CarouselSlider.builder(
                          itemCount: logic.getBannerRsp.value?.data
                              ?.length ??
                              0,
                          options: CarouselOptions(
                              aspectRatio: 25 / 11,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 7),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                logic.activeIndex.value = index;
                              }),
                          itemBuilder: (context, index, realIndex) {
                            return InkWell(
                              onTap: () {
                                Get.to(ProductDetailPage(id: logic
                                    .getBannerRsp
                                    .value
                                    ?.data?[index]
                                    .details?.first.link));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GlobalImage(
                                    imageUrl: logic
                                        .getBannerRsp
                                        .value
                                        ?.data?[index]
                                        .details?.first.image,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .3,
                                    boxFit: BoxFit.fill
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
          const SizedBox(height: 10,),
          Center(
            // bottom: 2,
              child: AnimatedSmoothIndicator(
                count: logic.getBannerRsp.value?.data
                    ?.length ??
                    0,
                activeIndex: logic.activeIndex.value ?? 0,
                effect: ExpandingDotsEffect(
                  dotWidth: 5,
                  dotHeight: 5,
                  dotColor: Colors.grey,
                  activeDotColor: XColor.primary,
                ),
              )),

        ],
      );
    });
  }
}
