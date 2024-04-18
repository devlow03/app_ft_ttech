import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImageComments extends StatelessWidget {
  final int index;

  const ListImageComments({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (logic.getCommentRsp.value?.data?[index].imageUrl?.length ??
            0),
        itemBuilder: (context, ind) {
          final data = logic.getCommentRsp.value?.data?[index].imageUrl?[ind];
          return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network("$data",
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .2,
              height: 50,
              fit: BoxFit.cover,

            ),
          );
        },
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          childAspectRatio: 10/ 8,
        ),
      );
    });
  }
}