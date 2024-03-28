import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../search/list_product/list_product_view.dart';
import '../../product_detail/product_detail_view.dart';
import '../home_logic.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh mục',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Get.to(AllProductByCategoryPage(
                            id: logic.getCategoryRsp
                                .value?.data?[logic.indexCat.value ?? 0]
                                .id,
                            categoryName: logic.getCategoryRsp
                                .value?.data?[logic.indexCat.value ?? 0]
                                .name ?? "",
                          )),
                      child: Text(
                        'Xem thêm',
                        style: TextStyle(
                            color: XColor.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
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
                              .3,
                          height: 15,
                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(10),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor:
                              Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(15),
                                  color: Colors.white,

                                ),
                                width: 10,
                                height: 40,

                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                ),
                child: Obx(() {
                  return Padding(
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
                              logic.indexCat.value = index;
                              print(">>>>>>>>>>${logic.indexCat.value}");
                              logic.idCategory.value = logic.getCategoryRsp
                                  .value?.data?[index]
                                  .id ?? 0;
                              logic.getProdByCategory();
                            },
                            child: Obx(() {
                              return Container(
                                alignment: Alignment.center,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    .3,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: logic.indexCat.value == index
                                  //         ? Colors.transparent
                                  //         : Colors.black, width: 2),
                                  color: logic.indexCat.value == index ? XColor
                                      .primary : Colors.grey.shade200,
                                  borderRadius:
                                  BorderRadius.circular(30),

                                ),
                                child: Text(logic.getCategoryRsp
                                    .value?.data?[index]
                                    .name ?? "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: logic.indexCat.value == index?FontWeight.w600:FontWeight.w500,
                                      color: logic.indexCat.value == index
                                          ? Colors.white
                                          : Colors.grey
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
