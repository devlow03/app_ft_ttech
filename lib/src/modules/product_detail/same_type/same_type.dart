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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Các sản phẩm khác của ${logic.getProductByIdRsp.value?.data?.manufacturerName}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: XColor.primary),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(AllProductByCategoryPage(
                                idBrand: logic.getProductByIdRsp.value?.data
                                    ?.manufacturerId,
                                categoryName: logic.getProductByIdRsp.value
                                    ?.data?.manufacturerName,
                              ));
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'Xem thêm',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 12,
                                )
                              ],
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // border: Border.all(color: Colors.red),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const SizedBox(height: 5,),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .1,
                                                    height: 190,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),



                                          ],
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
                              height: MediaQuery.of(context).size.height * .4,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: (logic.getProductByBrandRsp.value
                                                ?.data?.length ??
                                            0) >=
                                        10
                                    ? 10
                                    : logic.getProductByBrandRsp.value?.data
                                            ?.length ??
                                        0,
                                itemBuilder: (context, ind) {
                                  return Visibility(
                                    visible: logic.getProductByBrandRsp.value
                                            ?.data?[ind].id !=
                                        logic.getProductByIdRsp.value?.data?.id,
                                    child: InkWell(
                                      onTap: () async {
                                        Get.back();
                                        Get.to(ProductDetailPage(
                                          id: logic.getProductByBrandRsp.value
                                              ?.data?[ind].id
                                              .toString(),
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 2),
                                        child: GlobalProduct(
                                          imageLink: logic.getProductByBrandRsp
                                              .value?.data?[ind].thumpnailUrl,
                                          defaultPrice:
                                              '${logic.getProductByBrandRsp.value?.data?[ind].defaultPrice}',
                                          price:
                                              '${logic.getProductByBrandRsp.value?.data?[ind].price}',
                                          nameProduct: logic
                                              .getProductByBrandRsp
                                              .value
                                              ?.data?[ind]
                                              .productName,
                                          numStar: '5.0',
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
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sản phẩm cùng loại',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: XColor.primary),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(AllProductByCategoryPage(
                                id: logic.getProductRsp.value?.data?.first
                                    .categoryId,
                                categoryName: logic.getProductRsp.value?.data
                                    ?.first.categoryName,
                              ));
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'Xem thêm',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 12,
                                )
                              ],
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // border: Border.all(color: Colors.red),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const SizedBox(height: 5,),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .1,
                                                    height: 190,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ],
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
                              height: MediaQuery.of(context).size.height * .4,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, ind) {
                                  return Visibility(
                                    visible: logic.getProductRsp.value
                                            ?.data?[ind].id !=
                                        logic.getProductByIdRsp.value?.data?.id,
                                    child: InkWell(
                                      onTap: () async {
                                        Get.back();
                                        Get.to(ProductDetailPage(
                                          id: logic.getProductRsp.value
                                              ?.data?[ind].id
                                              .toString(),
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 2),
                                        child: GlobalProduct(
                                          imageLink: logic.getProductRsp.value
                                              ?.data?[ind].thumpnailUrl,
                                          defaultPrice:
                                              '${logic.getProductRsp.value?.data?[ind].defaultPrice}',
                                          price:
                                              '${logic.getProductRsp.value?.data?[ind].price}',
                                          nameProduct: logic.getProductRsp.value
                                              ?.data?[ind].productName,
                                          numStar: '5.0',
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
