import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/xcolor.dart';
import '../../data/repositories/get_product_by_id_rsp.dart';
import '../../widget/global_image.dart';
import '../product/product_logic.dart';
import 'photo_logic.dart';


class PhotoPage extends StatelessWidget {
  final Data? data;
  const PhotoPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PhotoLogic());

    final logicPro = Get.put(ProductLogic(Get.find()));
    // logicPro.activeIndex.value=ind??0;
    return WillPopScope(
      onWillPop: ()async{
        logicPro.carouselControl.animateToPage(logicPro.indexSlider.value);
        return true;
      },
      child: Scaffold(
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
                    // carouselController: logicPro.carouselControl,
                    itemCount:
                    data?.galleryImagesUrl?.length ?? 0,
                    options: CarouselOptions(
                      aspectRatio: 20 / 14,
                      // autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 7),
                      onPageChanged: (index, reason) {
                        logicPro.indexSlider.value=index;



                        // print(">>>>>>>>>>>>indexSlider: ${logicPro.indexSlider.value}");
                      },


                      viewportFraction: 1,
                      // enlargeCenterPage: true,
                      // enableInfiniteScroll: true
                    ),
                    itemBuilder: (context, index, realIndex) {
                      // logicPro.indexSlider.value = index;

                      return InkWell(
                        // onLongPress: (){
                        //   Get.dialog(
                        //       AlertDialog(
                        //         content: InkWell(
                        //             onTap: ()async{
                        //               await GallerySaver.saveImage(data?.galleryImagesUrl?[logicPro.indexSlider.value].largeUrl??'',toDcim: true).then((value) {
                        //                 Get.back();
                        //                 ScaffoldMessenger.of(context).showSnackBar(
                        //                     SnackBar(
                        //                       backgroundColor: Colors.black54,
                        //                       width: 300,
                        //                       content: Text('Đã tải ảnh!',
                        //                         textAlign: TextAlign.center,
                        //                         style: TextStyle(
                        //                             color: Colors.white,
                        //                             letterSpacing: 1
                        //                         ),
                        //                       ),
                        //                       elevation: 3.0,
                        //                       duration: Duration(seconds: 2),
                        //                       behavior: SnackBarBehavior.floating,
                        //                       shape: RoundedRectangleBorder(
                        //                           borderRadius: BorderRadius.circular(20)
                        //                       ),
                        //                     )
                        //
                        //                 );
                        //               });
                        //             },
                        //             child: Text('Tải ảnh về máy')),
                        //       )
                        //   );
                        // },
                        child: GlobalImage(
                          imageUrl: data?.galleryImagesUrl?[logicPro.indexSlider.value].largeUrl ??
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
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    child: AnimatedSmoothIndicator(
                      count: data?.galleryImagesUrl?.length??0,
                      activeIndex: logicPro.indexSlider.value ?? 0,
                      effect: ScrollingDotsEffect(
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
      ),
    );
  }
}
