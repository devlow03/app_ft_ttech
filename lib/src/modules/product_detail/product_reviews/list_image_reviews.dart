import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImageReviews extends StatelessWidget {
  const ListImageReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: logic.getCommentRsp.value?.data?.length??0,
              itemBuilder: (context, index) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GlobalImage(
                      imageUrl:"${logic.getCommentRsp.value?.data?[index].imageUrl?.first}",
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .2,
                      height: 30,
                      boxFit: BoxFit.cover,

                    ),

                  ),
              separatorBuilder: (context, index) => const SizedBox(width: 10,),
            ),
          ),

        ],
      );
    });
  }
}
