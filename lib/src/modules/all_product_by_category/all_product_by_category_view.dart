
import 'package:app_ft_tmart/src/modules/filter/filter_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';

import 'all_product_by_category_logic.dart';

class AllProductByCategoryPage extends StatelessWidget {
  final int? id;
  final String? categoryName;
  final int? idBrand;

  const AllProductByCategoryPage({Key? key, this.id, this.categoryName, this.idBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AllProductByCategoryLogic());
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    final logicCart = Get.put(CartLogic());
    logic.idCategory.value = id;
    logic.idBrand.value = idBrand;

    return Scaffold(
      key: key,
      appBar: AppBar(
        // backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.grey.shade200,
          leading: IconButton(
            onPressed: () {

              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,),

          ),
          title: Text(categoryName??"",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          // centerTitle: true,

          actions:[
            IconButton(
              onPressed: () {
                Get.to(
                    const SearchPage());
              },
              icon:
              const Icon(Icons.search,color: Colors.white,)
              ,
            ),
            Obx(() {
              return Stack(
                alignment: Alignment.centerRight,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(
                          const CartPage());
                    },
                    icon:
                    const Icon(Icons.shopping_cart_outlined,color: Colors.white,)
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
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
            IconButton(
                onPressed: (){
                  Get.to(FilterPage(isCategory: true,),transition: Transition.rightToLeft);
                },
                icon: const Icon(Icons.tune,color: Colors.white,)
            )

          ]
      ),

      body: Obx(() {

        if(logic.getProductByCategory.value?.data?.isEmpty==true){

          return const Center(
            child: Text("Sản phẩm không tồn tại",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          );



        }
        return Visibility(
          replacement: const LinearProgressIndicator(

            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          visible: logic.getProductByCategory.value?.data?.isNotEmpty==true,
          child: ListView(
            controller: logic.controller,
            children: [
              const SizedBox(height: 10,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: logic.getProductByCategory.value?.data?.length??0,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, ind) {
                        logic.indexPage.value=ind;
                        return InkWell(
                          onTap: () {
                            Get.to(ProductDetailPage(
                              id: logic.getProductByCategory.value?.data?[ind].id.toString(),

                            ));
                          },
                          child: GlobalProduct(
                            imageLink:logic.getProductByCategory.value?.data?[ind].thumpnailUrl,
                            defaultPrice: '${logic.getProductByCategory.value?.data?[ind].defaultPrice}',
                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                            price:
                            '${ logic.getProductByCategory.value?.data?[ind].price}',
                            nameProduct:
                            logic.getProductByCategory.value?.data?[ind].productName,
                            numStar: '5.0',
                          ),
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
                    visible: (logic.getProductByCategory.value?.meta?.perPage ?? 0) <
                        (logic.getProductByCategory.value?.meta?.total ?? 0),
                    replacement: const Center(),
                    child: const Center(
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
        );
      }),
    );
  }
}