import 'package:app_ft_tmart/src/data/repositories/get_product_by_category_rsp.dart';
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

import '../../data/repositories/get_product_rsp.dart';
import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';
import '../list_product/list_product_view.dart';
import '../photo/photo_view.dart';
import 'product_logic.dart';

class ProductPage extends StatelessWidget {
  final String? id;

  const ProductPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(ProductLogic(Get.find()));
    logic.getProduct(id);

    return WillPopScope(
      onWillPop: () async {
        logic.quantity.value = 1;
        logic.getProductByIdRsp.value = null;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        body: RefreshIndicator(
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
                  expandedHeight: MediaQuery.of(context).size.height * .45,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider.builder(
                          carouselController: logic.carouselControl,
                          itemCount: logic.getProductByIdRsp.value?.data
                                  ?.galleryImagesUrl?.length ??
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
                              visible: logic.getProductByIdRsp.value?.data
                                      ?.galleryImagesUrl?.isEmpty ==
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
                          visible: logic.getProductByIdRsp.value?.data
                                  ?.galleryImagesUrl?.isEmpty ==
                              false,
                          child: Positioned(
                            // right: 20,
                            bottom: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
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
                    Obx(() {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          IconButton(
                            onPressed: () async{
                              await logicCart.getCart();
                              Get.to(const CartPage());
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                          ),
                          Visibility(
                            visible: logicCart.getCartRsp.value?.data
                                    ?.cartDetails?.isNotEmpty ==
                                true,
                            child: Positioned(
                              right: 5,
                              bottom: 25,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: XColor.primary),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "${logicCart.getCartRsp.value?.data?.cartDetails?.length}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })
                  ],
                );
              }),
              SliverToBoxAdapter(child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: logic.getProductByIdRsp.value?.data
                                  ?.galleryImagesUrl?.isEmpty ==
                              false,
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
                                    width:
                                        MediaQuery.of(context).size.width * .15,
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
                              itemCount: logic.getProductByIdRsp.value?.data
                                      ?.galleryImagesUrl?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      logic.indexSlider.value = index;
                                      logic.carouselControl.animateToPage(
                                          logic.indexSlider.value);

                                      print(
                                          ">>>>>>>>>>>>>>>>>>>${logic.indexSlider.value}");
                                    },
                                    child: Visibility(
                                      visible: logic.indexSlider.value == index,
                                      replacement: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade200),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          child: GlobalImage(
                                            imageUrl: logic
                                                    .getProductByIdRsp
                                                    .value
                                                    ?.data
                                                    ?.galleryImagesUrl?[index]
                                                    .smallUrl ??
                                                '',
                                            width: MediaQuery.of(context)
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
                                              color: XColor.primary, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          child: GlobalImage(
                                            imageUrl: logic
                                                    .getProductByIdRsp
                                                    .value
                                                    ?.data
                                                    ?.galleryImagesUrl?[index]
                                                    .smallUrl ??
                                                '',
                                            width: MediaQuery.of(context)
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
                    Visibility(
                      visible:
                          logic.getProductByIdRsp.value?.data.isNull == false,
                      replacement: Center(
                        child: CircularProgressIndicator(
                          color: XColor.primary,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              logic
                                                      .getProductByIdRsp
                                                      .value
                                                      ?.data
                                                      ?.manufacturerName ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              logic.getProductByIdRsp.value
                                                      ?.data?.productName ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'VI')
                                            .format(logic.getProductByIdRsp
                                                    .value?.data?.price ??
                                                0),
                                        style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            const Text("Số lượng: "),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        logic.quantity.value >=
                                                            2,
                                                    replacement: IconButton(
                                                        icon: Icon(
                                                          Icons.remove,
                                                          size: 15,
                                                          color: Colors
                                                              .grey.shade200,
                                                        ),
                                                        onPressed: null),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.remove,
                                                          size: 15),
                                                      onPressed: () {
                                                        logic.quantity.value--;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1),
                                                    child: Text(logic
                                                        .quantity.value
                                                        .toString()),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.add,
                                                        size: 15),
                                                    onPressed: () {
                                                      logic.quantity.value++;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 30,
                                  // ),
                                  // Row(
                                  //   // mainAxisAlignment: MainAxisAlignment
                                  //   //     .spaceBetween,
                                  //   children: [
                                  //     Text("Màu sắc: "),
                                  //     const SizedBox(width: 5,),
                                  //     Icon(
                                  //       Icons.circle, color: Colors.black,),
                                  //     const SizedBox(width: 5,),
                                  //     Icon(Icons.circle, color: Colors.grey,),
                                  //     const SizedBox(width: 5,),
                                  //     Icon(Icons.circle,
                                  //       color: Colors.yellowAccent,),
                                  //     const SizedBox(width: 5,),
                                  //     Icon(Icons.circle,
                                  //       color: Colors.pinkAccent,),
                                  //
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   // mainAxisAlignment: MainAxisAlignment
                                  //   //     .spaceBetween,
                                  //   children: [
                                  //     Text("Phiên bản: "),
                                  //     const SizedBox(width: 5,),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width*.15,
                                  //       height: 30,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black
                                  //           ),
                                  //           borderRadius: BorderRadius.circular(5)
                                  //       ),
                                  //       child: Center(child: Text('64GB')),
                                  //     ),
                                  //     const SizedBox(width: 10,),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width*.15,
                                  //       height: 30,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: XColor.primary
                                  //           ),
                                  //           borderRadius: BorderRadius.circular(5)
                                  //       ),
                                  //       child: Center(child: Text('128GB')),
                                  //     ),
                                  //     const SizedBox(width: 10,),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width*.15,
                                  //       height: 30,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black
                                  //           ),
                                  //           borderRadius: BorderRadius.circular(5)
                                  //       ),
                                  //       child: Center(child: Text('256GB')),
                                  //     ),
                                  //     const SizedBox(width: 10,),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width*.15,
                                  //       height: 30,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black
                                  //           ),
                                  //           borderRadius: BorderRadius.circular(5)
                                  //       ),
                                  //       child: Center(child: Text('512GB')),
                                  //     ),
                                  //
                                  //
                                  //     // Row(
                                  //     //   mainAxisAlignment: MainAxisAlignment
                                  //     //       .start,
                                  //     //   children: [
                                  //     //     const Text('Phiên bản: '),
                                  //     //     const SizedBox(
                                  //     //       width: 2,
                                  //     //     ),
                                  //     //     Container(
                                  //     //       padding: const EdgeInsets.symmetric(
                                  //     //           horizontal: 10, vertical: 5),
                                  //     //       decoration: BoxDecoration(
                                  //     //           border: Border.all(
                                  //     //               color: XColor.primary),
                                  //     //           borderRadius: BorderRadius
                                  //     //               .circular(
                                  //     //               5)),
                                  //     //       child: Text(
                                  //     //         '256GB',
                                  //     //         style: TextStyle(
                                  //     //             color: XColor.primary),
                                  //     //       ),
                                  //     //     ),
                                  //     //     const SizedBox(width: 5),
                                  //     //     Container(
                                  //     //       padding: const EdgeInsets.symmetric(
                                  //     //           horizontal: 10, vertical: 5),
                                  //     //       decoration: BoxDecoration(
                                  //     //           border: Border.all(
                                  //     //               color: Colors.black),
                                  //     //           borderRadius: BorderRadius
                                  //     //               .circular(
                                  //     //               8)),
                                  //     //       child: const Text(
                                  //     //         '128GB',
                                  //     //       ),
                                  //     //     ),
                                  //     //   ],
                                  //     // )
                                  //   ],
                                  // ),
                                ],
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
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Thông số kĩ thuật',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  HtmlWidget(logic.getProductByIdRsp.value?.data
                                          ?.detail ??
                                      ""),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .6,
                                            child: ClipRRect(
                                              child: HtmlWidget(
                                                logic.getProductByIdRsp.value
                                                        ?.data?.desctiption ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            left: 0,
                                            bottom: 0,
                                            child: AnimatedOpacity(
                                              duration:
                                                  const Duration(seconds: 2),
                                              opacity: 1,
                                              child: Container(
                                                height: 128,
                                                decoration: const BoxDecoration(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Thu gọn",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: XColor.primary,
                                                )
                                              ],
                                            )),
                                        child: TextButton(
                                            onPressed: () {
                                              logic.viewAll.value = true;
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Xem thêm",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: XColor.primary,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Các sản phẩm khác của ${logic.getProductByIdRsp.value?.data?.manufacturerName}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: XColor.primary),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(ListProductPage(
                                              name: logic
                                                      .getProductByBrandRsp
                                                      .value
                                                      ?.data
                                                      ?.first
                                                      .manufacturerName ??
                                                  "",
                                            ));
                                          },
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Xem thêm',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() => Visibility(
                                        visible: logic.getProductByBrandRsp.value?.data
                                                ?.isNotEmpty ==
                                            true ,
                                        replacement: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .4,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 3,
                                              itemBuilder: (context, ind) {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 2),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .25,
                                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        // border: Border.all(color: Colors.red),
                                                        border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                        ),
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // const SizedBox(height: 5,),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade100,
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .1,
                                                                  height: 190,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        5),
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Shimmer
                                                                    .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 30,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    // boxFit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        2),
                                                            child: Column(
                                                              children: [
                                                                Shimmer
                                                                    .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 20,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    // boxFit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                  width: 2,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .4,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:  (logic.getProductByBrandRsp
                                                            .value?.data?.length??0)>=10?10:logic.getProductByBrandRsp
                                                            .value?.data?.length??0,
                                              itemBuilder: (context, ind) {
                                                return Visibility(
                                                  visible: logic.getProductByBrandRsp
                                                            .value?.data?[ind].id!=logic.getProductByIdRsp.value?.data?.id,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      Get.back();
                                                      Get.to(ProductPage(
                                                        id: logic.getProductByBrandRsp
                                                            .value?.data?[ind].id
                                                            .toString(),
                                                      ));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 2),
                                                      child: GlobalProduct(
                                                        imageLink: logic
                                                            .getProductByBrandRsp
                                                            .value
                                                            ?.data?[ind]
                                                            .thumpnailUrl,
                                                        defaultPrice:
                                                            '${logic.getProductByBrandRsp.value?.data?[ind].defaultPrice}',
                                                        price:
                                                            '${logic.getProductByBrandRsp.value?.data?[ind].price}',
                                                        nameProduct: logic
                                                            .getProductByBrandRsp
                                                            .value
                                                            ?.data?[ind]
                                                            .productName,
                                                        numStar: '5.0',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                  width: 2,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sản phẩm cùng loại',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: XColor.primary),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(ListProductPage(
                                              name: logic
                                                      .getProductRsp
                                                      .value
                                                      ?.data
                                                      ?.first
                                                      .categoryName ??
                                                  "",
                                            ));
                                          },
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Xem thêm',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() => Visibility(
                                        visible: logic.getProductRsp.value?.data
                                                ?.isNotEmpty ==
                                            true ,
                                        replacement: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .4,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 3,
                                              itemBuilder: (context, ind) {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 2),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .25,
                                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        // border: Border.all(color: Colors.red),
                                                        border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                        ),
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // const SizedBox(height: 5,),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .grey
                                                                    .shade300,
                                                                highlightColor:
                                                                    Colors.grey
                                                                        .shade100,
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .1,
                                                                  height: 190,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        5),
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Shimmer
                                                                    .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 30,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    // boxFit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        2),
                                                            child: Column(
                                                              children: [
                                                                Shimmer
                                                                    .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 20,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    // boxFit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                  width: 2,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .4,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 10,
                                              itemBuilder: (context, ind) {
                                                return Visibility(
                                                  visible: logic.getProductRsp
                                                            .value?.data?[ind].id!=logic.getProductByIdRsp.value?.data?.id,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      Get.back();
                                                      Get.to(ProductPage(
                                                        id: logic.getProductRsp
                                                            .value?.data?[ind].id
                                                            .toString(),
                                                      ));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 2),
                                                      child: GlobalProduct(
                                                        imageLink: logic
                                                            .getProductRsp
                                                            .value
                                                            ?.data?[ind]
                                                            .thumpnailUrl,
                                                        defaultPrice:
                                                            '${logic.getProductRsp.value?.data?[ind].defaultPrice}',
                                                        price:
                                                            '${logic.getProductRsp.value?.data?[ind].price}',
                                                        nameProduct: logic
                                                            .getProductRsp
                                                            .value
                                                            ?.data?[ind]
                                                            .productName,
                                                        numStar: '5.0',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                  width: 2,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
              )
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          return Visibility(
            visible:
                logic.getProductByIdRsp.value?.data?.thumpnailUrl?.isNotEmpty ==
                    true,
            child: BottomAppBar(
              height: 150,
              // color: Colors.transparent,
              elevation: 0.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tổng tiền: "),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              NumberFormat.simpleCurrency(locale: 'VI').format(
                                  ((logic.getProductByIdRsp.value?.data
                                              ?.price ??
                                          0) *
                                      (logic.quantity.value))),
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                await logic.postAddCart(
                                    productId: logic
                                            .getProductByIdRsp.value?.data?.id
                                            .toString() ??
                                        "",
                                    quantity:
                                        logic.quantity.value.toString() ?? "");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: XColor.primary),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Thêm vào giỏ hàng',
                                  style: TextStyle(color: XColor.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                await logic.buyNow(
                                    productId: logic
                                            .getProductByIdRsp.value?.data?.id
                                            .toString() ??
                                        "",
                                    quantity:
                                        logic.quantity.value.toString() ?? "");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: XColor.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Mua ngay",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
