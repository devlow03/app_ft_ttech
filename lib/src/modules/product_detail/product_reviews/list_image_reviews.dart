import 'package:app_ft_tmart/src/modules/product_detail/comment_details/comment_details.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImageReviews extends StatelessWidget {
  const ListImageReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return SizedBox(
        height: 80,
        child: Stack(
          alignment: Alignment.center,
          children: [

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: (logic.imageComments.length ?? 0)>=4?4:(logic.imageComments.length ?? 0),
              itemBuilder: (context, index) => Visibility(
                visible: index == 3 && (logic.imageComments.length ?? 0)>4,
                replacement: InkWell(
                onTap: (){

                  Get.to( CommentDetails(index: index,));

                },
                  child: GlobalImage(
                    imageUrl:
                        "${logic.imageComments[index]["imageUrl"][0]}",
                    width: MediaQuery.of(context).size.width * .2,
                    height: 30,
                    boxFit: BoxFit.cover,
                  ),
                ),
                child:GlobalImage(
                  color: Colors.black.withOpacity(0.5), // Màu tối lại
                  colorBlendMode: BlendMode.darken,
                  imageUrl:
                      "${logic.imageComments[index]["imageUrl"][0]}",
                  width: MediaQuery.of(context).size.width * .2,
                  height: 30,
                  boxFit: BoxFit.cover,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 12,
              ),
            ),
            Visibility(
              visible: (logic.imageComments.length ?? 0)>4,
              child: Positioned(
                  right: 20,
                  bottom: 30,
                  child: Text("+ ${(logic.getCommentRsp.value?.data?.length??0) - 4} ảnh",style: const TextStyle(color: Colors.white),)


              ),
            )
          ],
        ),
      );
    });
  }
}
