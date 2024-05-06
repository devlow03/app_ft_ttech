import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MiniImageList extends StatelessWidget {
  const MiniImageList({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: logic
                    .getProductByIdRsp.value?.data?.galleryImagesUrl?.isEmpty ==
                false,
            replacement: SizedBox(
              height: 50,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * .15,
                      height: 30,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                controller: logic.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: logic.getProductByIdRsp.value?.data?.galleryImagesUrl
                        ?.length ??
                    0,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return GestureDetector(
                      onTap: () {
                        logic.indexSlider.value = index;
                        logic.carouselControl
                            .jumpToPage(logic.indexSlider.value);

                        print(">>>>>>>>>>>>>>>>>>>${logic.indexSlider.value}");
                      },
                      child: Visibility(
                        visible: logic.indexSlider.value == index,
                        replacement: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 3),
                            child: GlobalImage(
                              imageUrl: logic.getProductByIdRsp.value?.data
                                      ?.galleryImagesUrl?[index].smallUrl ??
                                  '',
                              width: MediaQuery.of(context).size.width * .1,
                              height: 30,
                              // boxFit: BoxFit.cover,
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: XColor.primary, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 3),
                            child: GlobalImage(
                              imageUrl: logic.getProductByIdRsp.value?.data
                                      ?.galleryImagesUrl?[index].smallUrl ??
                                  '',
                              width: MediaQuery.of(context).size.width * .1,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
