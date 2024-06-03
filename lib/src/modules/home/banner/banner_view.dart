import 'package:app_ft_tmart/src/modules/home/home_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
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
      bool isNotEmpty = logic.getBannerRsp.value?.data?.isEmpty ==
          false;
      return Column(
        children: [
          Stack(
            // alignment: Alignment.bottomCenter,
            children: [
             
              Center(
                child: Container(
                  margin:  const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)
                  ),
                  child: CarouselSlider.builder(
                    itemCount: isNotEmpty?(logic.getBannerRsp.value?.data
                        ?.length ??
                        0):1,
                    options: CarouselOptions(
                        aspectRatio: 21 / 10,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 7),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          logic.activeIndex.value = index;
                        }),
                    itemBuilder: (context, index, realIndex) {
                      return Visibility(
                        visible: isNotEmpty,
                        replacement: SizedBox(
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
                                BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.put(ProductDetailLogic(Get.find())).getProductById(logic
                                .getBannerRsp
                                .value
                                ?.data?[index]
                                .details?.first.link.toString()??"");

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                        ),
                      );
                    },
                  ),
                ),
              ),



            ],
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
