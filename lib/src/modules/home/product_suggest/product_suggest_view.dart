import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../product_detail/product_detail_view.dart';
import '../home_logic.dart';

class ProductSuggestPage extends StatelessWidget {
  const ProductSuggestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Obx(() {
      return Visibility(
        visible: logic.getProductRsp.value?.data?.isNotEmpty == true,
        // replacement: Center(
        //   child: CircularProgressIndicator(
        //     color: XColor.primary,
        //   ),
        // ),
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
                      'Có thể bạn cũng thích',
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
                        horizontal: 5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: logic.getProductRsp.value?.data
                          ?.length ?? 0,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, ind) {
                        logic.indexPage.value = ind;
                        return GlobalProduct(
                          productId: logic.getProductRsp.value?.data?[ind].id.toString()??"",
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

                        );

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
                        (logic.getProductRsp.value?.meta?.total ??
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
