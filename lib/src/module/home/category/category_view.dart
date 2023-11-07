import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../list_product/list_product_view.dart';
import '../../product/product_view.dart';
import '../home_logic.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic(Get.find(), Get.find()));
    return Obx(() {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey.shade200,),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,
              horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Danh mục sản phẩm',
                  style: TextStyle(
                      color: XColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Visibility(
                visible: logic.getCategoryRsp.value?.data
                    ?.isEmpty ==
                    false,
                replacement: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width:
                          MediaQuery
                              .of(context)
                              .size
                              .width *
                              .25,
                          height: 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade200),
                              color: Colors.grey.shade200,
                              borderRadius:
                              BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor:
                              Colors.grey.shade100,
                              child: Container(
                                width: 10,
                                height: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: logic.getCategoryRsp.value
                          ?.data?.length ??
                          0,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(ListProductPage(
                              id: logic
                                  .getCategoryRsp
                                  .value
                                  ?.data?[index]
                                  .id
                                  .toString() ??
                                  "",
                              name: logic.getCategoryRsp.value
                                  ?.data?[index].name,
                            ));
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width *
                                .25,
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //     color: Colors.grey.shade200),
                                color: Colors.grey.shade200,
                                borderRadius:
                                BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    logic.iconCategory[index],
                                    color: XColor.primary,
                                    size: 20,),
                                  const SizedBox(width: 10,),
                                  Text(logic.getCategoryRsp
                                      .value?.data?[index]
                                      .name ?? "",
                                    style: const TextStyle(
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
