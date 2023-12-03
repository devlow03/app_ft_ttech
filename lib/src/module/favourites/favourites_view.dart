import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../../widget/global_product.dart';
import '../product/product_view.dart';
import 'favourites_logic.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FavouritesLogic());

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Sản phẩm yêu thích",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
        body: Visibility(
          visible: logic.getProductFavoriteRsp.value?.data?.isNotEmpty == true,
          replacement: Center(
            child: CircularProgressIndicator(
              color: XColor.primary,
            ),
          ),
          child: RefreshIndicator(
            onRefresh: ()async{
              logic.onReady();
            },
            child: ListView(
              controller: logic.controller,
              children: [
                const SizedBox(height: 10,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: logic.getProductFavoriteRsp.value?.data
                            ?.length ?? 0,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, ind) {
                          
                          return InkWell(
                            onTap: () {
                              Get.to(ProductPage(
                                id: logic.getProductFavoriteRsp.value
                                    ?.data?[ind].id.toString(),
                
                              ));
                            },
                            child: GlobalProduct(
                              imageLink: logic.getProductFavoriteRsp.value
                                  ?.data?[ind].thumpnailUrl,
                              defaultPrice: '${logic.getProductFavoriteRsp
                                  .value?.data?[ind].defaultPrice}',
                              // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                              price:
                              '${ logic.getProductFavoriteRsp.value
                                  ?.data?[ind].price}',
                              nameProduct:
                              logic.getProductFavoriteRsp.value?.data?[ind]
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
                          (logic.getProductFavoriteRsp.value?.meta?.total ??
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
        ),
      );
    });
  }
}
