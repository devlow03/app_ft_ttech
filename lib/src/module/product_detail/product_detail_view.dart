import 'package:app_ft_tmart/src/data/respository/prod_category_res.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'product_detail_logic.dart';
import 'package:intl/intl.dart';

class Product_detailPage extends StatelessWidget {
  final ProdCategory? data;
  const Product_detailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(Product_detailLogic(Get.find()));
    logic.getSliderProd(id: data?.id.toString()??"");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade100,
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          //don't delete
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8.0),
            child: IconButton(
                onPressed: () async {

                },
                icon: Icon(Icons.shopping_bag_outlined,color: Colors.black,)),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.black,
        strokeWidth: 3,
        onRefresh: () async {

        },
        child: Obx(() {
          return ListView(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: CarouselSlider.builder(
                      itemCount: logic.getSliderProdRsp.value?.slider?.length ??
                          0,
                      options: CarouselOptions(
                        aspectRatio: 20 / 16,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        onPageChanged: (index, reason) {
                          logic.activeIndex.value = index;
                        },

                        viewportFraction: 1,
                        // enlargeCenterPage: true,
                        // enableInfiniteScroll: true
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Image.network(
                            logic.getSliderProdRsp.value?.slider?[index]
                                .linkImg ?? '',
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          // border:Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                            '${logic.activeIndex.value + 1}/${logic
                                .getSliderProdRsp.value?.slider?.length ?? 0}'),
                      )),
                ],
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(data?.name ?? ''.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.3),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                NumberFormat.simpleCurrency(locale: 'vi')
                                    .format(double.parse(
                                    data?.price.toString()??"")),
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    height: 2,
                                    fontSize: 18,
                                    letterSpacing: 1.3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/star.png',
                                    height: 20,
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('4.6 (120 reviews) | Đã bán 72')
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .9,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            'Thông tin sản phẩm',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         data.descript ?? '',
                          //         style: TextStyle(),
                          //         maxLines: maxText,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // maxText == 8
                          //     ? InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       maxText = widget.descript?.length ?? 0;
                          //     });
                          //   },
                          //   child: Container(
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           'Xem thêm',
                          //           style: TextStyle(
                          //               fontSize: 16, letterSpacing: 1),
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Icon(Icons.keyboard_arrow_down)
                          //       ],
                          //     ),
                          //   ),
                          // )
                          //     : InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       maxText = 8;
                          //     });
                          //   },
                          //   child: Container(
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           'Thu gọn',
                          //           style: TextStyle(
                          //               fontSize: 16, letterSpacing: 1),
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Icon(Icons.keyboard_arrow_up)
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 7,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Bình luận'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),


                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 7,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 10,
                      color: Colors.grey.shade100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * .95,
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               "Sản phẩm tương tự",
                    //               style: TextStyle(
                    //                   fontSize: 16, fontWeight: FontWeight.w700),
                    //             ),
                    //             InkWell(
                    //                 onTap: () {
                    //                   Get.to(AllProductsScreen(
                    //                     id_category: widget.idCategory,
                    //                   ));
                    //                 },
                    //                 child: Text(
                    //                   "Xem thêm >>",
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Colors.blue.shade700),
                    //                 )),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(20),
                    //       topRight: Radius.circular(20)
                    //   ),
                    //   child:
                    // ),
                  ],
                ),
              ),
              // FutureBuilder<ProdCategoryRes?>(
              //     future: getCategoryProduct(widget.idCategory),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return SizedBox(
              //           height: 280,
              //           child: ListView.separated(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: 4,
              //             itemBuilder: (context, int index) {
              //               return AspectRatio(
              //                 aspectRatio: 3 / 4.5,
              //                 child: InkWell(
              //                   onTap: () {
              //                     Get.back();
              //                     Get.to(ProductDetailScreen(
              //                       idCategory: widget.idCategory,
              //                       id: snapshot.data?.prodCategory?[index].id.toString(),
              //                       name: snapshot.data?.prodCategory?[index].name,
              //                       price: snapshot.data?.prodCategory?[index].price.toString(),
              //                       descript: snapshot.data?.prodCategory?[index].descript,
              //                       image: snapshot.data?.prodCategory?[index].imgLink,
              //                     ));
              //                   },
              //                   child: Padding(
              //                     padding:
              //                     const EdgeInsets.symmetric(horizontal: 10),
              //                     child: GlobalProduct(
              //                       imageLink: snapshot
              //                           .data?.prodCategory?[index].imgLink,
              //                       shortDes: snapshot
              //                           .data?.prodCategory?[index].shortDes,
              //                       // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
              //                       price:
              //                       '${snapshot.data?.prodCategory?[index].price ?? ''}',
              //                       nameProduct:
              //                       '${snapshot.data?.prodCategory?[index].name}',
              //                       numStar: '5.0',
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             },
              //             separatorBuilder: (BuildContext context, int index) {
              //               return SizedBox(
              //                 width: 3,
              //               );
              //             },
              //           ),
              //         );
              //       }
              //       return SizedBox(
              //         height: 280,
              //         child: ListView.separated(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: 4,
              //           itemBuilder: (context, int index) {
              //             return AspectRatio(
              //               aspectRatio: 3 / 4.5,
              //               child: Container(
              //                 // padding: EdgeInsets.symmetric(vertical: 5),
              //                 width: MediaQuery.of(context).size.width * .3,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   // border: Border.all(color: Colors.red),
              //                   border: Border.all(
              //                     color: Colors.grey.shade300,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //                 child: Column(
              //                   // mainAxisAlignment: MainAxisAlignment.,
              //                   crossAxisAlignment: CrossAxisAlignment.stretch,
              //                   children: [
              //                     Shimmer.fromColors(
              //                       baseColor: Colors.grey.shade300,
              //                       highlightColor: Colors.grey.shade100,
              //                       child: Container(
              //                         width:
              //                         MediaQuery.of(context).size.width * .3,
              //                         height: 150,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.only(
              //                               topLeft: Radius.circular(10),
              //                               topRight: Radius.circular(10)),
              //                           color: Colors.white,
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 20,
              //                     ),
              //                     Padding(
              //                         padding: const EdgeInsets.symmetric(
              //                             horizontal: 10),
              //                         child: Shimmer.fromColors(
              //                           baseColor: Colors.grey.shade300,
              //                           highlightColor: Colors.grey.shade100,
              //                           child: Container(
              //                             width:
              //                             MediaQuery.of(context).size.width *
              //                                 .3,
              //                             height: 12,
              //                             color: Colors.white,
              //                           ),
              //                         )),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Center(
              //                         child: Shimmer.fromColors(
              //                           baseColor: Colors.grey.shade300,
              //                           highlightColor: Colors.grey.shade100,
              //                           child: Container(
              //                             width:
              //                             MediaQuery.of(context).size.width * .3,
              //                             height: 12,
              //                             color: Colors.white,
              //                           ),
              //                         )),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Column(
              //                       // mainAxisAlignment: MainAxisAlignment.end,
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                             children: [
              //                               Row(
              //                                 mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                                 children: [
              //                                   Shimmer.fromColors(
              //                                     baseColor: Colors.grey.shade300,
              //                                     highlightColor:
              //                                     Colors.grey.shade100,
              //                                     child: Container(
              //                                       width: MediaQuery.of(context)
              //                                           .size
              //                                           .width *
              //                                           .3,
              //                                       height: 12,
              //                                       color: Colors.white,
              //                                     ),
              //                                   )
              //                                 ],
              //                               ),
              //
              //                             ],
              //                           ),
              //                         )
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //           separatorBuilder: (BuildContext context, int index) {
              //             return SizedBox(
              //               width: 3,
              //             );
              //           },
              //         ),
              //       );
              //     }),
              SizedBox(height: 50,),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.transparent,
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                          )),
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
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Mua ngay",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
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
