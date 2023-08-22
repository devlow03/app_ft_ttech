import 'package:app_ft_tmart/src/data/respository/prod_category_res.dart';
import 'package:app_ft_tmart/src/data/services/tmart_services.dart';
import 'package:app_ft_tmart/src/module/product_detail/product_detail_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/respository/cart_res.dart';
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
                            return Container(
                                child: Image.network(
                                  logic.getBannerRsp.value?.data?[index]
                                      .urlBannerImg ?? "",
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.amber,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Whoops!',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    );
                                  },
                                )
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
                                  activeDotColor: Colors.blue.shade700,
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
                                          Image.network(
                                            logic.getCategoryRsp.value
                                                ?.category?[index].image ?? "",

                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                .1,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return Container(
                                                color: Colors.amber,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Whoops!',
                                                  style: TextStyle(
                                                      fontSize: 30),
                                                ),
                                              );
                                            },
                                            // fit: BoxFit.fill,
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

                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${logic.getCategoryRsp.value?.category?[index].nameType} nổi bật',
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
                            FutureBuilder<ProdCategoryRes?>(
                                future: logic.getProduct(id_category: logic.getCategoryRsp.value?.category?[index].idCategory.toString()??""),
                                builder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      Container(
                                        // height: MediaQuery.of(context).size.height*.5,
                                        margin: const EdgeInsets.all(10),
                                        child: GridView.builder(

                                          // padding: EdgeInsets.symmetric(vertical: 10),
                                          // padding:
                                          // const EdgeInsets.symmetric(
                                          //     horizontal: 10,
                                          //     vertical: 3),
                                          shrinkWrap: true,
                                          itemCount:  snapshot.data?.prodCategory?.length??0,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, ind) {
                                            return InkWell(
                                              onTap: () {
                                                // Get.to(Product_detailPage(data: snapshot.data?.prodCategory?[ind]));
                                                Get.to(ProductPage(
                                                  data: snapshot.data?.prodCategory?[ind],
                                                ));
                                              },
                                              child: GlobalProduct(
                                                imageLink: snapshot.data?.prodCategory?[ind].imgLink,
                                                shortDes:  snapshot.data?.prodCategory?[ind].shortDes,
                                                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                                price:
                                                '${ snapshot.data?.prodCategory?[ind].price}',
                                                nameProduct:
                                                snapshot.data?.prodCategory?[ind].name,
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
                                      ),
                                    ],
                                  );
                                },
                            )
                            ,

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
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
