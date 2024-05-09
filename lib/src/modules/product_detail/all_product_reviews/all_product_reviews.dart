import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/bottom/bottom_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/list_image_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:app_ft_tmart/src/modules/product_detail/all_product_reviews/linear_rating.dart';

import '../product_rating/product_rating.dart';
import 'linear_rating.dart';
class AllProductReview extends StatelessWidget {
  const AllProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            logic.isAllReviews.value=false;
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Đánh giá",style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),),

      actions: [


      Obx(() {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            IconButton(
              onPressed: () async {
                await logicCart.getCart();
                Get.to(const CartPage());
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            Visibility(
              visible: logicCart.getCartRsp.value?.data
                  ?.cartDetails?.isNotEmpty ==
                  true,
              child: Positioned(
                right: 5,
                bottom: 25,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: XColor.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${logicCart.getCartRsp.value?.data?.cartDetails?.length}",
                      style: const TextStyle(color: Colors.white),
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

            },
            icon: const Icon(Icons.tune,color: Colors.black,)
        ),
        ],
      ),
      body: RefreshIndicator(
        color: XColor.primary,

        onRefresh: ()=>logic.getComment(),
        child: ListView(
          controller: logic.scrollControllerAllReview,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const LinearRatingView(),
                  const SizedBox(height: 20,),
                  const ProductComment(),
                  Obx(() => Visibility(
                        visible: logic.perPage.value <
                            (logic.getCommentRsp.value?.meta
                                ?.total ??
                                0),
                        replacement: const Center(),
                        child: const Center(
                            child: SpinKitCircle(size: 40,
                              color: Colors.grey,
                            )
                        ),
                      ))

                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomDetail(),
    );
  }
}
