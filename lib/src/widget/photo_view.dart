import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/xcolor.dart';
import '../data/respository/get_product_rsp.dart';
import '../module/product/product_logic.dart';
import 'global_image.dart';

class PhotoView extends StatelessWidget {
  final Data? data;
  final int? ind;

  const PhotoView({super.key, required this.data, this.ind});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductLogic(Get.find()));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: Obx(() {
        return Center(
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider.builder(
                  carouselController: logic.carouselControl,
                  itemCount:
                  data?.galleryImagesUrl?.length ?? 0,
                  options: CarouselOptions(
                    aspectRatio: 20 / 14,
                    // autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 7),
                    onPageChanged: (index, reason) {
                      logic.activeIndex.value = index;


                      // print(">>>>>>>>>>>>indexSlider: ${logic.indexSlider.value}");
                    },


                    viewportFraction: 1,
                    // enlargeCenterPage: true,
                    // enableInfiniteScroll: true
                  ),
                  itemBuilder: (context, index, realIndex) {
                    // logic.indexSlider.value = index;

                    return InkWell(
                      onTap: () {
                        Get.to(PhotoView(
                          data: data,
                        ));
                      },
                      child: InkWell(
                        onLongPress: (){
                          Get.dialog(
                              AlertDialog(
                                content: InkWell(
                                    onTap: ()async{
                                      await GallerySaver.saveImage(data?.galleryImagesUrl?[index].largeUrl??'',toDcim: true).then((value) {
                                        Get.back();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.black54,
                                              width: 300,
                                              content: Text('Đã tải ảnh!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 1
                                                ),
                                              ),
                                              elevation: 3.0,
                                              duration: Duration(seconds: 2),
                                              behavior: SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                            )

                                        );
                                      });
                                    },
                                    child: Text('Tải ảnh về máy')),
                              )
                          );
                        },
                        child: GlobalImage(
                          imageUrl: data?.galleryImagesUrl?[index].largeUrl ??
                              '',
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                 Positioned(
                 bottom: 10,
                  child: AnimatedSmoothIndicator(
                    count: data?.galleryImagesUrl?.length??0,
                    activeIndex: logic.activeIndex.value ?? 0,
                    effect: ExpandingDotsEffect(
                      dotWidth: 5,
                      dotHeight: 5,
                      dotColor: Colors.grey,
                      activeDotColor: XColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

