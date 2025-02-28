import 'package:app_ft_tmart/src/data/repositories/get_comment_response.dart';
import 'package:app_ft_tmart/src/modules/product_detail/comment_details/comment_info/comment_info.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CommentDetails extends StatelessWidget {
  final int? index;
  const CommentDetails({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black12,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Obx(() {
          return PageView(
            onPageChanged: (index) {

              logic.indexComment.value = index;
              logic.indexCommentDetail.value = 0;

            },
            controller: PageController(initialPage: index ?? 0),
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            children: logic.imageComments.map((data) {
                  // logic.indexCommentDetail.value = 0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: data["imageUrl"].isEmpty == false,
                        child: Center(
                          child: Container(
                            width: 50,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.grey.shade200)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${(logic.indexCommentDetail.value ?? 0) + 1}/${data["imageUrl"].length ?? 0}",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CarouselSlider.builder(
                            itemCount: data["imageUrl"].length ?? 0,
                            itemBuilder: (context, index, realIndex) {
                              final images = data["imageUrl"]?[index];
                              return GlobalImage(
                                imageUrl: images,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                boxFit: BoxFit.cover,
                              );
                            },
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                aspectRatio: 15 / 17,
                                viewportFraction: 1,
                                onPageChanged: ((index, reason) {
                                  logic.indexCommentDetail.value = index;
                                })),
                          ),
                          Positioned(

                              left: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    // BoxShadow(
                                    //   color: Colors.grey.withOpacity(0.3),
                                    //   spreadRadius: 7,
                                    //   blurRadius: 5,
                                    //   offset: Offset(
                                    //       0, 5), // changes position of shadow
                                    // ),
                                  ],
                                ),
                                child: const Details(),

                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          data["createdAt"] ?? "",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                }).toList() ??
                [],
          );
        }));
  }
}

class Details extends StatelessWidget {

  const Details({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    final data = logic.imageComments[logic.indexComment.value??0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(data["avatar"] ?? ""),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data["fullName"] ?? "",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        ProductRating(
          isReview: true,
          initialRating: data["rating"].toDouble(),
          minRating: data["rating"].toDouble(),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Text(
              data["content"] ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
