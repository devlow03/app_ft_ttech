import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../search/list_product/list_product_view.dart';
import '../../product_detail/product_detail_view.dart';
import '../home_logic.dart';

class ProductByCategoryPage extends StatelessWidget {
  const ProductByCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.getCategoryRsp.value?.data?.length ?? 0,
        itemBuilder: (context, index) {
          final dataCategory = logic.getCategoryRsp.value?.data?[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${dataCategory?.name} bán chạy',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllProductByCategoryPage(id: dataCategory?.id,categoryName: dataCategory?.name,));
                          },
                          child: Text(
                            'Xem thêm',
                            style: TextStyle(
                                color: XColor.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Obx(() {
                    return Visibility(
                        visible: logic.getProductByIdCategoryRsp.value[logic
                            .getCategoryRsp.value?.data?[index].id]?.data
                            ?.isNotEmpty == true,
                        replacement: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * .4,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, ind) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 2),
                                    child: Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          .25,
                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          .4,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        // border: Border.all(color: Colors.red),

                                        color: Colors.grey.shade200,
                                      ),
                                      child: Shimmer.fromColors(
                                        baseColor:
                                        Colors.grey.shade300,
                                        highlightColor:
                                        Colors.grey.shade100,
                                        child: Container(
                                          width: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .width *
                                              .1,
                                          height: 190,
                                          decoration:
                                          BoxDecoration(
                                            color: Colors
                                                .grey,
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    10),
                                                topRight: Radius
                                                    .circular(
                                                    10)),
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 2,
                                );
                              },
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * .4,
                            child: Obx(() {
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: logic
                                    .getProductByIdCategoryRsp
                                    .value[logic.getCategoryRsp.value
                                    ?.data?[index].id]
                                    ?.data?.length??0,
                                itemBuilder: (context, ind) {
                                  final dataProduct = logic
                                      .getProductByIdCategoryRsp
                                      .value[logic.getCategoryRsp.value
                                      ?.data?[index].id]
                                      ?.data?[ind];
                                  return InkWell(
                                    onTap: () async {
                                      Get.to(ProductDetailPage(
                                        id: dataProduct?.id.toString(),

                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 2),
                                      child: GlobalProduct(
                                        imageLink: dataProduct?.thumpnailUrl,
                                        defaultPrice: '${dataProduct
                                            ?.defaultPrice}',
                                        // // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                                        price:
                                        '${dataProduct?.price.toString()}',
                                        nameProduct: dataProduct?.productName,
                                        numStar: '5.0',

                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 2,
                                  );
                                },
                              );
                            }),
                          ),
                        )
                    );
                  }),
                  const SizedBox(height: 5,)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20,);
        },
      );
    });
  }
}
