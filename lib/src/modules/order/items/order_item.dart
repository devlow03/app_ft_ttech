import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/order/order_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(OrderLogic());
    return Obx(() {
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
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
            logicCart.getCartRsp.value?.data?.cartDetails?.length ??
                0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.put(ProductDetailLogic(Get.find())).getProductById(logicCart.getCartRsp.value?.data
                      ?.cartDetails?[index].productId
                      .toString()??"");

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalImage(
                        height: 100,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .3,
                        imageUrl: logicCart.getCartRsp.value?.data
                            ?.cartDetails?[index].thumpnailUrl,
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
                              '${logicCart.getCartRsp.value?.data
                                  ?.cartDetails?[index].productName}',
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
                                      "${NumberFormat.simpleCurrency(
                                          locale: "VI").format(
                                          logicCart.getCartRsp.value?.data
                                              ?.cartDetails?[index].price)}"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "x${logicCart.getCartRsp.value?.data
                                            ?.cartDetails?[index].quantity}"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5),
                              child: Text(
                                "Tổng: ${NumberFormat.simpleCurrency(
                                    locale: "VI").format(
                                    logicCart.getCartRsp.value?.data
                                        ?.cartDetails?[index].total)}",
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
              return SizedBox(height: 10,);
            },
          ));
    });
  }
}

