import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_detail_logic.dart';

class DetailItems extends StatelessWidget {
  const DetailItems({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderDetailLogic());
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: logic.getOrderByIdRsp.value?.data?.orderDetails
                  ?.length ??
                  0,
              itemBuilder: (context, index) {
                logic.addToList(
                    logic.getOrderByIdRsp.value?.data
                        ?.orderDetails?[index].productId
                        .toString(),
                    logic.getOrderByIdRsp.value?.data
                        ?.orderDetails?[index].quantity
                        .toString());
                return InkWell(
                  onTap: () {
                    Get.to(ProductDetailPage(
                      id: logic.getOrderByIdRsp.value?.data
                          ?.orderDetails?[index].productId
                          .toString(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalImage(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .3,
                          imageUrl: logic.getOrderByIdRsp.value?.data
                              ?.orderDetails?[index].thumpnailUrl,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].productName}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].priceFormated}"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "x${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].quantity}"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5),
                                child: Text(
                                  "Tổng: ${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].subtotalFormated}",
                                  style: const TextStyle(
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tổng tiền hàng"),
                        Text(
                          "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?.first.text}",
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (logic.getOrderByIdRsp.value?.data
                        ?.infoTotalAmount?.length ??
                        0) >=
                        3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tổng tiền giảm giá"),
                          Text(
                              "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?[1].text}")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tổng thanh toán"),
                        Text(
                          "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?.last.text}",
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
