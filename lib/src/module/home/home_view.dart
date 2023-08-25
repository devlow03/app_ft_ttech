import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../data/respository/get_product_by_category_rsp.dart';
import '../../widget/global_image.dart';
import '../../widget/global_product.dart';
import '../../widget/search_widget.dart';
import '../product/product_view.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic(Get.find()));

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: SearchWidget()
          ),
          leading:  IconButton(
              onPressed: (){

              },
              icon:Icon(Icons.menu,color: Colors.white,)),
          elevation: 0.0,
          // title:Text('TMart',
          // style: TextStyle(
          //   fontSize: 20,
          //   color: Colors.white,
          //   fontWeight: FontWeight.w700
          // ),
          // ),
          actions: [
            IconButton(
                onPressed: (){

                }, icon: Icon(Icons.notifications_active,color: Colors.white,)
            ),
            IconButton(
                onPressed: (){

                }, icon: Icon(Icons.shopping_bag_outlined,color: Colors.white,)
            ),
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
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider.builder(

                          itemCount: logic.getBannerRsp.value?.data?.length,
                          options: CarouselOptions(
                              aspectRatio: 25 / 12,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 7),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                logic.activeIndex.value = index;
                              }

                            // // viewportFraction: 1,

                            // // enableInfiniteScroll: true
                          ),
                          itemBuilder: (context, index, realIndex) {
                                return GlobalImage(
                                  imageUrl:logic.getBannerRsp.value?.data?[index]
                                      .urlBannerImg,
                                  width: MediaQuery.of(context).size.width,
                                    boxFit:BoxFit.cover
                                );



                          },

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Positioned(
                          bottom: 10,
                          child: Center(
                            // bottom: 2,
                              child: AnimatedSmoothIndicator(
                                count: logic.getBannerRsp.value?.data?.length??0,
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

                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 10,
                      color: Colors.grey.shade100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Danh mục sản phẩm',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: logic.getCategoryRsp.value
                              ?.category?.length??0,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        .4,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:Colors.grey.shade200),
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          GlobalImage(
                                            imageUrl:logic.getCategoryRsp.value
                                                ?.category?[index].image ?? "",
                                            width: MediaQuery.of(context).size.width*.1,
                                            boxFit:BoxFit.cover
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            logic.getCategoryRsp.value?.category?[index].nameType??"",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 10,
                        color: Colors.grey.shade100,
                      ),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Điện thoại nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),

                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getPhoneRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getPhoneRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getPhoneRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getPhoneRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getPhoneRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),





                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'laptop nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getLaptopRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getLaptopRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getLaptopRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getLaptopRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getLaptopRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),





                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tablet nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getTabletRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getTabletRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getTabletRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getTabletRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getTabletRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),





                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Đồng hồ nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getWatchRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getWatchRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getWatchRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getWatchRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getWatchRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),





                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phụ kiện nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getAccessoryRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getAccessoryRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getPhoneRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getAccessoryRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getAccessoryRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Màn hình nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getScreenRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getScreenRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getScreenRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getScreenRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getScreenRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bàn phím nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getKeyboardRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getKeyboardRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getKeyboardRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getKeyboardRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getKeyboardRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tivi nổi bật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //
                              //     },
                              //     child: Text(
                              //       "Xem thêm>",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           // fontWeight: FontWeight.w700,
                              //           color: Colors.blue.shade700),
                              //     )),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount:  4,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, ind) {
                            return InkWell(
                              onTap: () {
                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                Get.to(ProductPage(
                                  data:  logic.getTvRsp.value?.prodCategory?[ind],
                                ));
                              },
                              child: GlobalProduct(
                                imageLink: logic.getTvRsp.value?.prodCategory?[ind].imgLink,
                                shortDes:   logic.getTvRsp.value?.prodCategory?[ind].shortDes,
                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                price:
                                '${  logic.getTvRsp.value?.prodCategory?[ind].price}',
                                nameProduct:
                                logic.getTvRsp.value?.prodCategory?[ind].name,
                                numStar: '5.0',
                              ),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                        ),




                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 10,
                      color: Colors.grey.shade100,
                    ),
                    const SizedBox(
                      height: 10,
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
