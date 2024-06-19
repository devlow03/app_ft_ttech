import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/widget/global_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SameType extends StatelessWidget {
  const SameType({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() => Column(
          children: [
            Visibility(
              visible:
                  logic.getProductByIdRsp.value?.data?.manufacturerName != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey.shade50,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Các sản phẩm khác của ${logic.getProductByIdRsp.value?.data?.manufacturerName}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                
                                Get.to(AllProductByCategoryPage(
                                  idBrand: int.parse(logic.getProductByIdRsp
                                          .value?.data?.manufacturerId
                                          .toString() ??
                                      ""),
                                  categoryName: logic.getProductByIdRsp.value
                                      ?.data?.manufacturerName,
                                ));
                              },
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
                      Obx(() => Visibility(
                            visible: logic.getProductByBrandRsp.value?.data
                                    ?.isNotEmpty ==
                                true,
                            replacement: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * .4,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, ind) {
                                    return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 2),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // border: Border.all(color: Colors.red),

                                        color: Colors.grey.shade200,
                                      ),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1,
                                          height: 190,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
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
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * .4,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (logic.getProductByBrandRsp.value
                                                  ?.data?.length ??
                                              0) >=
                                          6
                                      ? 6
                                      : logic.getProductByBrandRsp.value?.data
                                              ?.length ??
                                          0,
                                  itemBuilder: (context, ind) {
                                    final data = logic
                                        .getProductByBrandRsp.value?.data?[ind];
                                    return Visibility(
                                      visible: logic.getProductByBrandRsp.value
                                              ?.data?[ind].id !=
                                          logic.getProductByIdRsp.value?.data
                                              ?.id,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 2),
                                        child: GlobalProduct(
                                          productId: data?.id.toString(),
                                          imageLink: data?.thumpnailUrl,
                                          defaultPrice:
                                              '${data?.defaultPrice}',
                                          price: '${data?.price}',
                                          nameProduct: data?.productName,
                                          rating: double.parse(
                                              data?.averageRating ?? ""),
                                          isFavorites: data?.favorite,
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
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.grey.shade50,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sản phẩm cùng loại',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(AllProductByCategoryPage(
                                id: int.parse(logic.getProductRsp.value?.data
                                        ?.first.categoryId
                                        .toString() ??
                                    ""),
                                categoryName: logic.getProductRsp.value?.data
                                    ?.first.categoryName,
                              ));
                            },
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
                    Obx(() => Visibility(
                          visible:
                              logic.getProductRsp.value?.data?.isNotEmpty ==
                                  true,
                          replacement: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .4,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, ind) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 2),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // border: Border.all(color: Colors.red),

                                        color: Colors.grey.shade200,
                                      ),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1,
                                          height: 190,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
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
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .4,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, ind) {
                                  return Visibility(
                                    visible: logic.getProductRsp.value
                                            ?.data?[ind].id !=
                                        logic.getProductByIdRsp.value?.data?.id,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 2),
                                      child: GlobalProduct(
                                        productId: logic.getProductRsp.value
                                            ?.data?[ind].id.toString(),
                                        imageLink: logic.getProductRsp.value
                                            ?.data?[ind].thumpnailUrl,
                                        defaultPrice:
                                            '${logic.getProductRsp.value?.data?[ind].defaultPrice}',
                                        price:
                                            '${logic.getProductRsp.value?.data?[ind].price}',
                                        nameProduct: logic.getProductRsp.value
                                            ?.data?[ind].productName,
                                        rating: double.parse(logic
                                                .getProductRsp
                                                .value
                                                ?.data?[ind]
                                                .averageRating ??
                                            ""),
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
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
