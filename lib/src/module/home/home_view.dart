import 'package:app_ft_tmart/src/data/respository/get_product_rsp.dart';
import 'package:app_ft_tmart/src/module/all_product/all_product_view.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../widget/global_image.dart';
import '../../widget/global_product.dart';
import '../../widget/search_widget.dart';
import '../cart/cart_logic.dart';
import '../list_product/list_product_view.dart';
import '../product/product_view.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic(Get.find(), Get.find()));
    final logicCart = Get.put(CartLogic(Get.find()));
    // final logicProd = Get.put(ProductLogic(Get.find()));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                children: [
                  const Expanded(child: SearchWidget()),
                  Obx(() {
                    return Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                                CartPage());
                          },
                          icon:
                          Icon(Icons.shopping_cart_outlined)
                          ,
                        ),
                        Visibility(
                          visible: logicCart.getCartRsp.value?.data?.cartDetails
                              ?.isNotEmpty == true,
                          child: Positioned(
                            right: 5,
                            bottom: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: XColor.primary
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${logicCart.getCartRsp.value?.data
                                      ?.cartDetails
                                      ?.length}",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })
                ],
              )),
          title: Image.asset("assets/images/tmart.png",
            width: MediaQuery
                .of(context)
                .size
                .width * .15,
            height: 100,
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
          actions: [

            // IconButton(
            //     onPressed: () {},
            //     icon:  Icon(
            //       Icons.menu_outlined,
            //       color: Colors.black
            //     )),
          ],
        ),
        body: RefreshIndicator(
          color: Colors.black,
          strokeWidth: 3,
          onRefresh: () async {
            logic.refresh();
            logicCart.getCart();
          },
          child: Obx(() {
            return ListView(
              controller: logic.controller,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.grey.shade50,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Visibility(
                            visible: logic.getBannerRsp.value?.data?.isEmpty ==
                                false,
                            replacement: CarouselSlider.builder(
                              itemCount: 1,
                              options: CarouselOptions(
                                  aspectRatio: 25 / 8,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    // logic.activeIndex.value = index;
                                  }),
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
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
                                  ),
                                );
                              },
                            ),
                            child: CarouselSlider.builder(
                              itemCount: logic.getBannerRsp.value?.data
                                  ?.length ??
                                  0,
                              options: CarouselOptions(
                                  aspectRatio: 25 / 9,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    logic.activeIndex.value = index;
                                  }),
                              itemBuilder: (context, index, realIndex) {
                                return Visibility(
                                  visible: logic
                                      .getBannerRsp
                                      .value
                                      ?.data?[index]
                                      .details?.first.link != null,
                                  replacement: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(ProductPage(id: logic
                                          .getBannerRsp
                                          .value
                                          ?.data?[index]
                                          .details?.first.link));
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Positioned(
                            bottom: 10,
                            child: Center(
                              // bottom: 2,
                                child: AnimatedSmoothIndicator(
                                  count: logic.getBannerRsp.value?.data
                                      ?.length ??
                                      0,
                                  activeIndex: logic.activeIndex.value ?? 0,
                                  effect: ScrollingDotsEffect(
                                    dotWidth: 5,
                                    dotHeight: 5,
                                    dotColor: Colors.grey,
                                    activeDotColor: XColor.primary,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: Colors.grey.shade200,),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,
                              horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                               Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Danh mục sản phẩm',
                                  style: TextStyle(
                                    color: XColor.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Visibility(
                                visible: logic.getCategoryRsp.value?.data
                                    ?.isEmpty ==
                                    false,
                                replacement: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              .25,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                              Colors.grey.shade100,
                                              child: Container(
                                                width: 10,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 20,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: logic.getCategoryRsp.value
                                          ?.data?.length ??
                                          0,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(ListProductPage(
                                              id: logic
                                                  .getCategoryRsp
                                                  .value
                                                  ?.data?[index]
                                                  .id
                                                  .toString() ??
                                                  "",
                                              name: logic.getCategoryRsp.value
                                                  ?.data?[index].name,
                                            ));
                                          },
                                          child: Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .25,
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.grey.shade200),
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5, vertical: 5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    logic.iconCategory[index],
                                                    color: XColor.primary,
                                                    size: 20,),
                                                  const SizedBox(width: 10,),
                                                  Text(logic.getCategoryRsp
                                                      .value?.data?[index]
                                                      .name ?? "",
                                                    style: TextStyle(
                                                        fontSize: 12
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 15,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 10,
                    //     color: Colors.grey.shade100,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                                    'Điện thoại bán chạy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      color: XColor.primary
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          ListProductPage(name: "Điện thoại",));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 12,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: logic.getPhoneRsp.value?.data
                                  ?.isNotEmpty == true,
                              replacement: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                .25,
                                            // padding: EdgeInsets.symmetric(vertical: 20),
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // border: Border.all(color: Colors.red),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                // const SizedBox(height: 5,),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                      Colors.grey.shade300,
                                                      highlightColor:
                                                      Colors.grey.shade100,
                                                      child: Container(
                                                        width: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width *
                                                            .1,
                                                        height: 190,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors
                                                              .grey,
                                                          borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                  10),
                                                              topRight: Radius
                                                                  .circular(
                                                                  10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 30,
                                                          width: MediaQuery
                                                              .of(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2),
                                                  child: Column(
                                                    children: [
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 20,
                                                          width: MediaQuery
                                                              .of(
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, ind) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(ProductPage(
                                              id: logic.getPhoneRsp.value
                                                  ?.data?[ind].id.toString(),
                                            categoryId: logic.getPhoneRsp.value
                                                ?.data?[ind].categoryId.toString(),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GlobalProduct(
                                            imageLink: logic.getPhoneRsp.value
                                                ?.data?[ind].thumpnailUrl,
                                            defaultPrice: '${logic.getPhoneRsp
                                                .value?.data?[ind]
                                                .defaultPrice}',
                                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                            price:
                                            '${logic.getPhoneRsp.value
                                                ?.data?[ind].price}',
                                            nameProduct: logic.getPhoneRsp.value
                                                ?.data?[ind].productName,
                                            numStar: '5.0',

                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                                    'Laptop bán chạy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: XColor.primary
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          ListProductPage(name: "Laptop",));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 12,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: logic.getLaptopRsp.value?.data
                                  ?.isNotEmpty == true,
                              replacement: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                .25,
                                            // padding: EdgeInsets.symmetric(vertical: 20),
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // border: Border.all(color: Colors.red),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                // const SizedBox(height: 5,),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                      Colors.grey.shade300,
                                                      highlightColor:
                                                      Colors.grey.shade100,
                                                      child: Container(
                                                        width: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width *
                                                            .1,
                                                        height: 190,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors
                                                              .grey,
                                                          borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                  10),
                                                              topRight: Radius
                                                                  .circular(
                                                                  10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 30,
                                                          width: MediaQuery
                                                              .of(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2),
                                                  child: Column(
                                                    children: [
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 20,
                                                          width: MediaQuery
                                                              .of(
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, ind) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(ProductPage(
                                              id: logic.getLaptopRsp.value
                                                  ?.data?[ind].id.toString(),
                                              categoryId: logic.getLaptopRsp.value
                                                  ?.data?[ind].categoryId.toString(),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GlobalProduct(
                                            imageLink: logic.getLaptopRsp.value
                                                ?.data?[ind].thumpnailUrl,

                                            defaultPrice: '${logic.getLaptopRsp
                                                .value?.data?[ind]
                                                .defaultPrice}',
                                            price:
                                            '${logic.getLaptopRsp.value
                                                ?.data?[ind].price}',
                                            nameProduct: logic.getLaptopRsp
                                                .value?.data?[ind].productName,
                                            numStar: '5.0',

                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                                    'Tablet bán chạy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: XColor.primary
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          ListProductPage(name: "Tablet",));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 12,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: logic.getTabletRsp.value?.data
                                  ?.isNotEmpty == true,
                              replacement: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                .25,
                                            // padding: EdgeInsets.symmetric(vertical: 20),
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // border: Border.all(color: Colors.red),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                // const SizedBox(height: 5,),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                      Colors.grey.shade300,
                                                      highlightColor:
                                                      Colors.grey.shade100,
                                                      child: Container(
                                                        width: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width *
                                                            .1,
                                                        height: 190,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors
                                                              .grey,
                                                          borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                  10),
                                                              topRight: Radius
                                                                  .circular(
                                                                  10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 30,
                                                          width: MediaQuery
                                                              .of(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2),
                                                  child: Column(
                                                    children: [
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 20,
                                                          width: MediaQuery
                                                              .of(
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, ind) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(ProductPage(
                                              id: logic.getTabletRsp.value
                                                  ?.data?[ind].id.toString(),
                                            categoryId: logic.getTabletRsp.value
                                                ?.data?[ind].categoryId.toString(),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GlobalProduct(
                                            imageLink: logic.getTabletRsp.value
                                                ?.data?[ind].thumpnailUrl,

                                            defaultPrice: '${logic.getTabletRsp
                                                .value?.data?[ind]
                                                .defaultPrice}',
                                            price:
                                            '${logic.getTabletRsp.value
                                                ?.data?[ind].price}',
                                            nameProduct: logic.getTabletRsp
                                                .value?.data?[ind].productName,
                                            numStar: '5.0',

                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                                    'Đồng hồ bán chạy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: XColor.primary
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          ListProductPage(name: "Đồng hồ",));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 12,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: logic.getWatchRsp.value?.data
                                  ?.isNotEmpty == true,
                              replacement: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                .25,
                                            // padding: EdgeInsets.symmetric(vertical: 20),
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // border: Border.all(color: Colors.red),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                // const SizedBox(height: 5,),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                      Colors.grey.shade300,
                                                      highlightColor:
                                                      Colors.grey.shade100,
                                                      child: Container(
                                                        width: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width *
                                                            .1,
                                                        height: 190,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors
                                                              .grey,
                                                          borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                  10),
                                                              topRight: Radius
                                                                  .circular(
                                                                  10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 30,
                                                          width: MediaQuery
                                                              .of(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2),
                                                  child: Column(
                                                    children: [
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey,
                                                          height: 20,
                                                          width: MediaQuery
                                                              .of(
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, ind) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(ProductPage(
                                              id: logic.getWatchRsp.value
                                                  ?.data?[ind].id.toString(),
                                            categoryId: logic.getWatchRsp.value
                                                ?.data?[ind].categoryId.toString(),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GlobalProduct(
                                            imageLink: logic.getWatchRsp.value
                                                ?.data?[ind].thumpnailUrl,

                                            defaultPrice: '${logic.getWatchRsp
                                                .value?.data?[ind]
                                                .defaultPrice}',
                                            price:
                                            '${logic.getWatchRsp.value
                                                ?.data?[ind].price}',
                                            nameProduct: logic.getWatchRsp.value
                                                ?.data?[ind].productName,
                                            numStar: '5.0',

                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: logic.getProductRsp.value?.data?.isNotEmpty==true,
                      replacement: Center(
                        child: CircularProgressIndicator(
                          color: XColor.primary,
                        ),
                      ),
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Gợi ý hôm nay',
                                    style: TextStyle(
                                      color: XColor.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: logic.getProductRsp.value?.data
                                        ?.length ?? 0,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, ind) {
                                      logic.indexPage.value = ind;
                                      return InkWell(
                                        onTap: () {
                                          Get.to(ProductPage(
                                            id: logic.getProductRsp.value
                                                ?.data?[ind].id.toString(),
                                            categoryId: logic.getProductRsp.value
                                                ?.data?[ind].categoryId.toString(),
                                          ));
                                        },
                                        child: GlobalProduct(
                                          imageLink: logic.getProductRsp.value
                                              ?.data?[ind].thumpnailUrl,
                                          defaultPrice: '${logic.getProductRsp
                                              .value?.data?[ind].defaultPrice}',
                                          // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                          price:
                                          '${ logic.getProductRsp.value
                                              ?.data?[ind].price}',
                                          nameProduct:
                                          logic.getProductRsp.value?.data?[ind]
                                              .productName,
                                          numStar: '5.0',
                                        ),
                                      );
                                      // else{
                                      //   // logic.loadMore();
                                      //
                                      //   return Padding(
                                      //     padding: const EdgeInsets.symmetric(horizontal: 50),
                                      //     child: Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.center,
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //         CircularProgressIndicator(),
                                      //         TextButton(
                                      //             onPressed:(){
                                      //               logic.loadMore();
                                      //             },
                                      //             child: Text("load")
                                      //         )
                                      //       ],
                                      //     ),
                                      //   );
                                      //
                                      // }
                                    },
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(

                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 3 / 5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                Visibility(
                                  visible: logic.page.value <
                                      (logic.getProductRsp.value?.meta?.total ??
                                          0),
                                  replacement: Center(),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: XColor.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                // TextButton(
                                //     onPressed: (){
                                //       print(">>>>>>>>>>>>>>>>>>>${logic.isLoading.value}");
                                //     },
                                //     child: Text('a')
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),


                const SizedBox(
                  height: 30,
                ),
              ],
            );
          }),

          // body: Text('a'),
        ));
  }
}
