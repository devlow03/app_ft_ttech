import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../photo/photo_view.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            carouselController: logic.carouselControl,
            itemCount:
                logic.getProductByIdRsp.value?.data?.galleryImagesUrl?.length ??
                    0,
            options: CarouselOptions(
              aspectRatio: 25 / 25,
              // autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              onPageChanged: (index, reason) {
                logic.indexSlider.value = index;
                int? itemsPerPage = 5;
                double targetPosition = index * itemsPerPage * 10;
                logic.scrollController.animateTo(
                  targetPosition,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );

                // print(">>>>>>>>>>>>indexSlider: ${logic.indexSlider.value}");
              },

              viewportFraction: 1,
              // enlargeCenterPage: true,
              // enableInfiniteScroll: true
            ),
            itemBuilder: (context, index, realIndex) {
              // logic.indexSlider.value = index;

              return Visibility(
                visible: logic.getProductByIdRsp.value?.data?.galleryImagesUrl
                        ?.isEmpty ==
                    false,
                replacement: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(PhotoPage(
                      data: logic.getProductByIdRsp.value?.data,
                    ));
                  },
                  child: GlobalImage(
                    imageUrl: logic.getProductByIdRsp.value?.data
                            ?.galleryImagesUrl?[index].largeUrl ??
                        '',
                    width: MediaQuery.of(context).size.width * .6,
                    boxFit: BoxFit.contain,
                    // height: MediaQuery
                    //     .of(context)
                    //     .size
                    //     .height*.4,
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: logic
                    .getProductByIdRsp.value?.data?.galleryImagesUrl?.isEmpty ==
                false,
            child: Positioned(
              // right: 20,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Text(
                            "${logic.indexSlider.value + 1}/${logic.getProductByIdRsp.value?.data?.galleryImagesUrl?.length ?? 0}")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
