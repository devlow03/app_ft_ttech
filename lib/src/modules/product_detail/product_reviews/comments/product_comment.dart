import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/list_image_comments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductComment extends StatelessWidget {
  final int? itemCount;

  const ProductComment({super.key, this.itemCount, });

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));

    return Obx(() {

      return Container(
        padding: logic.isAllReviews.value?EdgeInsets.all(20):null,
        decoration: logic.isAllReviews.value?BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ):null,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: logic.isAllReviews.value?logic.getCommentRsp.value?.data?.length??0:2,
          itemBuilder: (context, index) {
            final data = logic.getCommentRsp.value?.data?[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(data?.userAvatar??""),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data?.user??"",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight
                                .bold),
                          ),
                          ProductRating(
                            isReview: true,
                            initialRating: data?.rating?.toDouble(),
                            minRating: data?.rating?.toDouble(),
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          data?.createdAt??"",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight
                              .w400,color: Colors.grey),
                        ),
                      ),
                       const SizedBox(height: 10,),
                       Text(
                        data?.text??"",
                        style: TextStyle(
                            fontSize: 14, color: Colors.black, ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       ListImageComments(index: index,),

                    ],
                  ),
                )

              ],
            );
          },

          separatorBuilder: (context, index) =>
          const SizedBox(
            height: 20,
          ),
        ),
      );
    });
  }
}
