import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/create_review/create_review_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/all_product_reviews/all_product_reviews.dart';
import 'package:app_ft_tmart/src/modules/product_detail/all_product_reviews/linear_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_image_reviews.dart';

class ProductReviewsPage extends StatelessWidget {
  const ProductReviewsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return Visibility(
        visible: logic.getCommentRsp.value?.data?.isNotEmpty == true,
        replacement: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đánh giá sản phẩm',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

                    Text('Chưa có đánh giá',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey)),
                  ],
                ),
                ElevatedButton(
                    onPressed: ()=>Get.to(const CreateReviewPage()),
                    child: const Text('Tạo đánh giá',style: TextStyle(
                        color: Colors.white
                    ),)
                ),
              ],
            ),
          ),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: ()=>Get.to(const CreateReviewPage()),
                    child: const Text('Tạo đánh giá',style: TextStyle(
                        color: Colors.white
                    ),)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Đánh giá sản phẩm',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Visibility(
                      visible: (logic.getCommentRsp.value?.data?.length??0)>2,
                      child: TextButton(
                        onPressed: (){
                          logic.isAllReviews.value = true;
                            Get.to(const AllProductReview(),
                                transition: Transition.rightToLeft);

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Xem tất cả",
                              style: TextStyle(fontSize: 14,color: XColor.primary),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: XColor.primary,
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
                Divider(color: Colors.grey.shade300,height: 0.5,),
                const SizedBox(height: 10,),
                const Text('Hình ảnh từ người mua',
                    style:
                    TextStyle(fontSize: 14)),
                const SizedBox(height: 10,),

                const ListImageReviews(),
                const SizedBox(height: 10,),
                Divider(color: Colors.grey.shade300,height: 0.5,),
                const ProductComment(),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: (logic.getCommentRsp.value?.data?.length??0)>2,
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          logic.isAllReviews.value = true;
                          Get.to(const AllProductReview(),
                              transition: Transition.rightToLeft);

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Xem tất cả",
                              style: TextStyle(fontSize: 14,color: XColor.primary),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: XColor.primary,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
