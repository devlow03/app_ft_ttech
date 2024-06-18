import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/comment_details/comment_details.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AllImageReview extends StatelessWidget {
  const AllImageReview({super.key});

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            logic.isAllReviews.value = false;
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Hình ảnh từ người mua",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                  visible: logicCart
                          .getCartRsp.value?.data?.cartDetails?.isNotEmpty ==
                      true,
                  child: Positioned(
                    right: 5,
                    bottom: 25,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: XColor.primary),
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
        ],
      ),
      body: ListView(
         controller: logic.scrollControllerAllReview,
        children: [
          Obx(() => GridView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 4.5,
              ),
              itemCount: logic.imageComments.length,
              itemBuilder: (context, index) {
                return cardImageReview(
                    context: context, logic: logic, index: index);
              })),
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
    );
  }

  Widget cardImageReview(
      {required BuildContext context,
      required ProductDetailLogic logic,
      required int index}) {
    final data = logic.imageComments[index];
    List imageUrl = data["imageUrl"] as List;
    return InkWell(
      onTap: ()async{
        await logic.getComment();
              Get.to( CommentDetails(index: index,));
      },
      child: Container(
        
        width: MediaQuery.of(context).size.width * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: Colors.red),
            // border: Border.all(
            //   color: Colors.grey.shade200,
            // ),
            color: Colors.white,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              child: GlobalImage(
                imageUrl: imageUrl.first,
                width: MediaQuery.of(context).size.width * .4,
                height: 150,
                boxFit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                data["content"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              ProductRating(
                isReview: true,
                initialRating: data["rating"].toDouble(),
                minRating: data["rating"].toDouble(),
              ),
              const SizedBox(height: 5,),
              Text(
                    data["createdAt"] ?? "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
              
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
