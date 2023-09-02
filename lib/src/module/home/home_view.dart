import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../widget/global_image.dart';
import '../../widget/global_product.dart';
import '../../widget/search_widget.dart';
import '../list_product/list_product_view.dart';
import '../product/product_view.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic(Get.find(), Get.find()));
    // final logicProd = Get.put(ProductLogic(Get.find()));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: XColor.primary,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                children: [
                  const Expanded(child: SearchWidget()),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      )),
                ],
              )),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'TMART',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'OpenSans',
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_outlined,
                  color: Colors.white,
                )),
          ],
        ),
        body: RefreshIndicator(
          color: Colors.black,
          strokeWidth: 3,
          onRefresh: () async {
            logic.refresh();
          },
          child: Obx(() {
            return ListView(
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
                            visible: logic.getTikiBannerRsp.value?.data?.first
                                    .banners?.isEmpty ==
                                false,
                            replacement: CarouselSlider.builder(
                              itemCount: 1,
                              options: CarouselOptions(
                                  aspectRatio: 25 / 12,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    logic.activeIndex.value = index;
                                  }),
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
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
                              itemCount: logic.getTikiBannerRsp.value?.data
                                      ?.first.banners?.length ??
                                  0,
                              options: CarouselOptions(
                                  aspectRatio: 25 / 12,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    logic.activeIndex.value = index;
                                  }),
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: GlobalImage(
                                      imageUrl: logic
                                          .getTikiBannerRsp
                                          .value
                                          ?.data
                                          ?.first
                                          .banners?[index]
                                          .imageUrl,
                                      width: MediaQuery.of(context).size.width,
                                      boxFit: BoxFit.fill,
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
                              count: logic.getTikiBannerRsp.value?.data?.first
                                      .banners?.length ??
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.grey.shade200,),
                        color: XColor.container,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                'Danh mục sản phẩm',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Visibility(
                              visible: logic.getCategoryRsp.value?.category
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
                                            MediaQuery.of(context).size.width *
                                                .15,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            color: Colors.blueGrey.shade100,
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
                                            ?.category?.length ??
                                        0,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(List_productPage(
                                            id: logic
                                                    .getCategoryRsp
                                                    .value
                                                    ?.category?[index]
                                                    .idCategory
                                                    .toString() ??
                                                "",
                                            name: logic.getCategoryRsp.value
                                                ?.category?[index].nameType,
                                          ));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .15,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: GlobalImage(
                                              imageUrl: logic
                                                      .getCategoryRsp
                                                      .value
                                                      ?.category?[index]
                                                      .image ??
                                                  "",
                                              width: 10,
                                              height: 40,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                        color: Colors.grey.shade100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: XColor.container,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Sản phẩm bán chạy',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: logic.getTikiTopSellerRsp.value?.tabs
                                      ?.isEmpty ==
                                  false,
                              replacement: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white)),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: logic.getTikiTopSellerRsp.value
                                            ?.tabs?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          logic.tabIndex.value = index;
                                          print(logic.tabIndex.value);
                                        },
                                        child: Visibility(
                                          visible:
                                              logic.tabIndex.value == index,
                                          replacement: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: Text(
                                                  logic
                                                          .getTikiTopSellerRsp
                                                          .value
                                                          ?.tabs?[index]
                                                          .title ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: XColor.primary,
                                                      width: 2)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: Text(
                                                  logic
                                                          .getTikiTopSellerRsp
                                                          .value
                                                          ?.tabs?[index]
                                                          .title ??
                                                      "",
                                                  style: TextStyle(
                                                      color: XColor.primary,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: logic.getTikiTopSellerRsp.value?.tabs
                                      ?.isEmpty ==
                                  false,
                              replacement: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .25,
                                            // padding: EdgeInsets.symmetric(vertical: 20),
                                            width: MediaQuery.of(context)
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
                                              color: Colors.white,
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
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .1,
                                                        height: 190,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
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
                                                              .grey.shade300,
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
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          color: Colors
                                                              .grey.shade300,
                                                          height: 10,
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 2,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .35,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: logic
                                            .getTikiTopSellerRsp
                                            .value
                                            ?.tabs?[logic.tabIndex.value ?? 0]
                                            .items
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, ind) {
                                      return InkWell(
                                        onTap: () async {
                                          Get.to(ProductPage(
                                              id: logic
                                                  .getTikiTopSellerRsp
                                                  .value
                                                  ?.tabs?[
                                                      logic.tabIndex.value ?? 0]
                                                  .items?[ind]
                                                  .id));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GlobalProduct(
                                            imageLink: logic
                                                .getTikiTopSellerRsp
                                                .value
                                                ?.tabs?[
                                                    logic.tabIndex.value ?? 0]
                                                .items?[ind]
                                                .thumbnailUrl,

                                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                            price:
                                                '${logic.getTikiTopSellerRsp.value?.tabs?[logic.tabIndex.value ?? 0].items?[ind].price}',
                                            nameProduct: logic
                                                .getTikiTopSellerRsp
                                                .value
                                                ?.tabs?[
                                                    logic.tabIndex.value ?? 0]
                                                .items?[ind]
                                                .name,
                                            numStar: '5.0',
                                            badgesLink: logic
                                                .getTikiTopSellerRsp
                                                .value
                                                ?.tabs?[
                                                    logic.tabIndex.value ?? 0]
                                                .items?[ind]
                                                .badgesNew?[0]
                                                .icon,
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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                        color: Colors.grey.shade100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: Colors.grey.shade200,),
                          color: XColor.container,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Bạn có thể thích',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 30,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic.getMayBeYouLikeRsp.value
                                          ?.tabs?.length ??
                                      0,
                                  itemBuilder: (context, index1) {
                                    return InkWell(
                                      onTap: () {
                                        logic.tabLike.value = index1;
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: XColor.primary)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Text(
                                              logic.getMayBeYouLikeRsp.value
                                                      ?.tabs?[index1].title ??
                                                  "",
                                              style: TextStyle(
                                                  color: XColor.primary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      width: 5,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .35,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic
                                          .getMayBeYouLikeRsp
                                          .value
                                          ?.tabs?[logic.tabLike.value ?? 0]
                                          .items
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, ind1) {
                                    return InkWell(
                                      onTap: () async {
                                        Get.to(ProductPage(
                                            id: logic
                                                .getMayBeYouLikeRsp
                                                .value
                                                ?.tabs?[
                                                    logic.tabLike.value ?? 0]
                                                .items?[ind1]
                                                .id));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GlobalProduct(
                                          imageLink: logic
                                              .getMayBeYouLikeRsp
                                              .value
                                              ?.tabs?[logic.tabLike.value ?? 0]
                                              .items?[ind1]
                                              .thumbnailUrl,

                                          // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                          price:
                                              '${logic.getMayBeYouLikeRsp.value?.tabs?[logic.tabLike.value ?? 0].items?[ind1].price}',
                                          nameProduct: logic
                                              .getMayBeYouLikeRsp
                                              .value
                                              ?.tabs?[logic.tabLike.value ?? 0]
                                              .items?[ind1]
                                              .name,
                                          numStar: '5.0',
                                          badgesLink: logic
                                              .getMayBeYouLikeRsp
                                              .value
                                              ?.tabs?[logic.tabLike.value ?? 0]
                                              .items?[ind1]
                                              .badgesNew?[1]
                                              .icon,
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
