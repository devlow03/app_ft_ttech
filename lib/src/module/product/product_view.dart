import 'package:app_ft_tmart/src/data/respository/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/module/search/search_view.dart';
import 'package:app_ft_tmart/src/widget/global_html.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';

import 'product_logic.dart';

class ProductPage extends StatelessWidget {
  final num? id;

  const ProductPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductLogic(Get.find()));
    logic.getProduct(id: id??0);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,)

            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark
            ),
            expandedHeight: MediaQuery
                .of(context)
                .size
                .height * .45,
            flexibleSpace: FlexibleSpaceBar(

              background: Obx(() {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      carouselController: logic.carouselControl,
                      itemCount: logic.getTikiProductRsp.value?.images
                          ?.length ??
                          0,
                      options: CarouselOptions(
                        aspectRatio: 25 / 25,
                        // autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        onPageChanged: (index, reason) {
                          logic.activeIndex.value = index;
                          logic.indexSlider.value = index;
                          // print(">>>>>>>>>>>>indexSlider: ${logic.indexSlider.value}");
                        },


                        viewportFraction: 1,
                        // enlargeCenterPage: true,
                        // enableInfiniteScroll: true
                      ),

                      itemBuilder: (context, index, realIndex) {
                        // logic.indexSlider.value = index;

                        return Visibility(
                          visible: logic.getTikiProductRsp.value?.images?.isEmpty==false,
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
                          child: GlobalImage(
                              imageUrl: logic.getTikiProductRsp.value?.images?[index]
                                  .baseUrl ?? '',
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                            boxFit: BoxFit.cover,
                            // height: MediaQuery
                            //     .of(context)
                            //     .size
                            //     .height,


                          ),
                        );
                      },

                    ),
                    Positioned(
                      bottom: 50,
                      child: Center(
                        // bottom: 2,
                          child: Column(
                            children: [
                              AnimatedSmoothIndicator(
                                count: 4,
                                activeIndex: logic.activeIndex.value ?? 0,
                                effect: ExpandingDotsEffect(
                                  dotWidth: 5,
                                  dotHeight: 5,
                                  dotColor: Colors.grey,
                                  activeDotColor: XColor.primary,
                                ),
                              ),
                              const SizedBox(height: 20,),

                            ],
                          )),
                    ),

                  ],
                );
              }),
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
                  icon: const Icon(
                    Icons.favorite_border)

              ),
              IconButton(
                  onPressed: () {
                    Get.to(SearchPage());
                  },
                  icon: const Icon(Icons.search)

              ),
              IconButton(
                  onPressed: () {
                    // Get.to(CartPage(),transition: Transition.rightToLeft);
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined)
              ),
            ],

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,


                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    )
                ),
                child: Text(''),

              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {

              return Visibility(
                visible: logic.getTikiProductRsp.value?.images?.isEmpty==false,
                replacement: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Shimmer.fromColors(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      height: MediaQuery.of(context).size.height,
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,

                          itemCount: logic.getTikiProductRsp.value?.images
                              ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  logic.carouselControl.animateToPage(
                                      index);
                                  logic.indexSlider.value = index;
                                  print(index);
                                },
                                child: Visibility(
                                  visible: logic.indexSlider.value ==
                                      index,
                                  replacement: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        5),
                                    child: GlobalImage(
                                      imageUrl: logic.getTikiProductRsp.value?.images?[index]
                                          .mediumUrl ?? '',
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .15,
                                      height: 30,
                                      boxFit: BoxFit.cover,

                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: XColor.primary),
                                      borderRadius: BorderRadius
                                          .circular(5),
                                    ),
                                    child: GlobalImage(
                                      imageUrl: logic.getTikiProductRsp.value?.images?[index]
                                          .mediumUrl ?? '',
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .15,
                                      height: 30,
                                      boxFit: BoxFit.cover,

                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 10,);
                          },
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(logic.getTikiProductRsp.value?.brand?.name??"",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(logic.getTikiProductRsp.value?.name??"",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange.shade300,),
                              Text('4.5(231)')
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      // Center(child: Text('Mô tả sản phẩm')),
                      Html(
                          data: logic.getTikiProductRsp.value?.shortDescription??"",

                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade100,
                            child: TextButton(
                                onPressed: (){
                                  Get.to(GlobalHtml(html: logic.getTikiProductRsp.value?.description??""));
                                },
                                child: Text("Xem mô tả chi tiết")
                            ),
                          ),
                        ),
                      ),
                      // Text(logic.getTikiProductRsp.value?.description??"",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w300,
                      //
                      //   ),
                      //   maxLines: 7,
                      // ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Giá:'),
                              const SizedBox(width: 3,),
                              Text(
                                NumberFormat.simpleCurrency(locale: 'VI').format(logic.getTikiProductRsp.value?.price??0),
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500

                                ),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Màu sắc: '),
                              const SizedBox(width: 5),
                              Icon(Icons.circle, color: Colors.deepPurple,),
                              Icon(Icons.circle, color: Colors.black,),
                              Icon(Icons.circle, color: Colors.yellow,),
                              Icon(Icons.circle, color: Colors.grey,)
                            ],
                          ),


                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text('Số lượng: '),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [

                                const SizedBox(width: 3,),
                                Icon(Icons.remove, size: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text('1'),
                                ),
                                Icon(Icons.add, size: 15),

                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Phiên bản: '),
                              const SizedBox(width: 2,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,
                                    vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: XColor.primary
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text('256GB',
                                  style: TextStyle(color: XColor.primary),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(

                                padding: EdgeInsets.symmetric(horizontal: 10,
                                    vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                    ),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text('128GB',
                                ),
                              ),


                            ],
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              );
            }),

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
                    onPressed: () async {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Thêm vào giỏ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: XColor.primary,
                      padding: EdgeInsets.symmetric(
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
                    onPressed: () async {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Mua ngay",
                        style: TextStyle(
                            fontSize: 14,
                            color: XColor.primary
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,

                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: XColor.primary
                        )
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
