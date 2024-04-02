import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/product_detail/all_product_reviews/all_product_reviews.dart';
import 'package:app_ft_tmart/src/modules/product_detail/all_product_reviews/linear_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_image_reviews.dart';
class ProductReviewsPage extends StatelessWidget {
  const ProductReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Đánh giá sản phẩm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                TextButton(
                    onPressed: ()=>Get.to(AllProductReview(),transition: Transition.rightToLeft),
                    child: Text('Xem tất cả',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,color: XColor.primary)),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(

              children: [
                Text(
                  '4.9',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )),
                const SizedBox(width: 10,),
                ProductRating(itemCount: 5,isReview: true,),
                const SizedBox(width: 5,),
                Text("(30 đánh giá)"),
              ],
            ),
            // ProductRating(),
            const SizedBox(height: 10,),
            const ListImageReviews(),
            const ProductComment(),
            const SizedBox(height: 10,),
            Center(
              child: TextButton(
                  onPressed: () {
                    Get.to(const AllProductReview(),transition: Transition.rightToLeft);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Xem tất cả",
                        style: TextStyle(fontSize: 14),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: XColor.primary,
                      )
                    ],
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
