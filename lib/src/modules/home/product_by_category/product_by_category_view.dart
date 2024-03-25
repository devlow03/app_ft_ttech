import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../search/list_product/list_product_view.dart';
import '../../product_detail/product_detail_view.dart';
import '../home_logic.dart';

class ProductByCategoryPage extends StatelessWidget {
  const ProductByCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Obx(() {
      return Visibility(
        visible: logic.getProductByCategoryRsp.value?.data?.isNotEmpty == true,
        replacement: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, ind) {

                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 2),
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

                              color: Colors.grey.shade200,
                            ),
                            child: Shimmer.fromColors(
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

                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ));
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
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 3 / 5,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Visibility(
                  visible: logic.page.value <
                      (logic.getProductByCategoryRsp.value?.meta?.total ??
                          0),
                  replacement: Center(),
                  child: Center(
                      child: SpinKitCircle(size: 40,
                        color: Colors.grey,
                      )
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
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: logic.getProductByCategoryRsp.value?.data
                          ?.length ?? 0,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, ind) {
                        logic.indexPage.value = ind;
                        return InkWell(
                          onTap: () {
                            Get.to(ProductDetailPage(
                              id: logic.getProductByCategoryRsp.value
                                  ?.data?[ind].id.toString(),

                            ));
                          },
                          child: GlobalProduct(
                            imageLink: logic.getProductByCategoryRsp.value
                                ?.data?[ind].thumpnailUrl,
                            defaultPrice: '${logic.getProductByCategoryRsp
                                .value?.data?[ind].defaultPrice}',
                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                            price:
                            '${ logic.getProductByCategoryRsp.value
                                ?.data?[ind].price}',
                            nameProduct:
                            logic.getProductByCategoryRsp.value?.data?[ind]
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
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 3 / 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Visibility(
                    visible: logic.page.value <
                        (logic.getProductByCategoryRsp.value?.meta?.total ??
                            0),
                    replacement: Center(),
                    child: Center(
                        child: SpinKitCircle(size: 40,
                          color: Colors.grey,
                        )
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
      );
    });
  }
}
