import 'package:app_ft_tmart/src/data/respository/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/module/search/search_view.dart';
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

import '../../data/respository/get_product_rsp.dart';
import '../cart/cart_view.dart';
import '../photo/photo_view.dart';
import 'product_logic.dart';

class ProductPage extends StatelessWidget {
  final String? id;

  const ProductPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductLogic(Get.find()));
    logic.getProductById(id: id ?? "");
    return WillPopScope(
      onWillPop: () async {
        // logic.carouselControl.obs;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
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
                expandedHeight: MediaQuery
                    .of(context)
                    .size
                    .height * .45,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider.builder(
                        carouselController: logic.carouselControl,
                        itemCount:
                        logic.getProductByIdRsp.value?.data?.galleryImagesUrl
                            ?.length ?? 0,
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
                              duration: Duration(milliseconds: 500),
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
                            visible:
                            logic.getProductByIdRsp.value?.data
                                ?.galleryImagesUrl?.isEmpty ==
                                false,
                            replacement: Shimmer.fromColors(
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Colors.grey.shade300,
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(PhotoPage(
                                  data: logic.getProductByIdRsp.value?.data,

                                ));
                              },
                              child: GlobalImage(
                                imageUrl: logic.getProductByIdRsp.value?.data
                                    ?.galleryImagesUrl?[index]
                                    .largeUrl ??
                                    '',
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .6,
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
                        right: 20,
                        bottom: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Row(
                                children: [
                                  Text("${logic.indexSlider.value + 1}/${logic
                                      .getProductByIdRsp.value?.data
                                      ?.galleryImagesUrl?.length ?? 0}")
                                ],
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                ),
                pinned: true,
                stretch: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        // Fluttertoast.showToast(
                        //     msg: "Đã thêm sản phẩm vào yêu thích", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        Get.to(const SearchPage());
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        Get.to(CartPage(), transition: Transition.rightToLeft);
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
                ],
                // bottom: PreferredSize(
                //   preferredSize: const Size.fromHeight(0.0),
                //   child: Container(
                //     height: 28,
                //     alignment: Alignment.center,
                //     decoration: const BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(25),
                //             topRight: Radius.circular(25))),
                //     child: const Text(''),
                //   ),
                // ),
              );
            }),
            SliverToBoxAdapter(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                            visible: logic.getProductByIdRsp.value?.data
                                ?.galleryImagesUrl?.isEmpty == false,
                            replacement: SizedBox(
                              height: 50,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      decoration: BoxDecoration(

                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          .15,
                                      height: 30,

                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                              ),
                            ),
                            child: SizedBox(
                              height: 50,
                              child: ListView.separated(
                                controller: logic.scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,

                                itemCount:
                                logic.getProductByIdRsp.value?.data
                                    ?.galleryImagesUrl?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        logic.indexSlider.value = index;
                                        logic.carouselControl.animateToPage(
                                            logic.indexSlider.value);

                                        print(">>>>>>>>>>>>>>>>>>>${logic
                                            .indexSlider.value}");
                                      },
                                      child: Visibility(
                                        visible: logic.indexSlider.value ==
                                            index,
                                        replacement: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius: BorderRadius.circular(
                                                5),
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 3),
                                            child: GlobalImage(
                                              imageUrl: logic.getProductByIdRsp
                                                  .value?.data
                                                  ?.galleryImagesUrl?[index]
                                                  .smallUrl ??
                                                  '',
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  .1,
                                              height: 30,
                                              // boxFit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: XColor.primary,
                                                width: 2),
                                            borderRadius: BorderRadius.circular(
                                                5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 3),
                                            child: GlobalImage(
                                              imageUrl: logic.getProductByIdRsp
                                                  .value?.data
                                                  ?.galleryImagesUrl?[index]
                                                  .smallUrl ??
                                                  '',
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  .1,
                                              height: 30,

                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Visibility(
                            visible: logic.getProductByIdRsp.value?.data
                                ?.galleryImagesUrl?.isEmpty == false,
                            replacement: Center(
                              child: CircularProgressIndicator(
                                color: XColor.primary,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "Thương hiệu",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            logic.getProductByIdRsp.value?.data
                                                ?.productName ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange.shade300,
                                        ),
                                        const Text('4.5(231)')
                                      ],
                                    )
                                  ],
                                ),


                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      NumberFormat.simpleCurrency(locale: 'VI')
                                          .format(
                                          logic.getProductByIdRsp.value?.data
                                              ?.price ??
                                              0),
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text('Màu sắc: '),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.deepPurple,
                                        ),
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.black,
                                        ),
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.yellow,
                                        ),
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    // Text('Số lượng: '),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(
                                              20)),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text('1'),
                                          ),
                                          const Icon(Icons.add, size: 15),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        const Text('Phiên bản: '),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: XColor.primary),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  8)),
                                          child: Text(
                                            '256GB',
                                            style: TextStyle(
                                                color: XColor.primary),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  8)),
                                          child: const Text(
                                            '128GB',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Thông số kĩ thuật',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  )
                              ),
                              const SizedBox(height: 20,),
                              HtmlWidget(
                                  logic.getProductByIdRsp.value?.data?.detail ??
                                      ""
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Obx(() {
                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: [

                                Visibility(
                                  visible: logic.viewAll.value == false,
                                  replacement: HtmlWidget(
                                    logic.getProductByIdRsp.value?.data
                                        ?.desctiption ??
                                        "",
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * .6,
                                        child: ClipRRect(
                                          child: HtmlWidget(
                                            logic.getProductByIdRsp.value?.data
                                                ?.desctiption ??
                                                "",


                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: AnimatedOpacity(
                                          duration: Duration(seconds: 2),
                                          opacity: 1,
                                          child: Container(
                                            height: 128,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0x00ffffff),
                                                  Colors.white,
                                                  Colors.white,
                                                ],
                                                stops: [
                                                  0,
                                                  0.9,
                                                  1,
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                Center(
                                  child: Visibility(
                                    visible: logic.viewAll.value == false,
                                    replacement: TextButton(
                                        onPressed: () {
                                          logic.viewAll.value = false;
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            const Text("Thu gọn",
                                              style: TextStyle(

                                                  fontSize: 14
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_up,
                                              color: XColor.primary,)
                                          ],
                                        )),
                                    child: TextButton(
                                        onPressed: () {
                                          logic.viewAll.value = true;
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            const Text("Xem thêm",
                                              style: TextStyle(

                                                  fontSize: 14
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_down,
                                              color: XColor.primary,)
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  );
                })
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          // color: Colors.transparent,
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Thêm vào giỏ",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: XColor.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Mua ngay",
                          style: TextStyle(fontSize: 14, color: XColor.primary),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: XColor.primary)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
