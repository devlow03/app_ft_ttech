import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widget/global_image.dart';
import '../../product_detail/product_detail_view.dart';
import '../cart_logic.dart';

class CartItemsScreen extends StatelessWidget {
  const CartItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());
    return Obx(() {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.getCartRsp.value?.data?.cartDetails?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(ProductDetailPage(
                id: logic.getCartRsp.value?.data?.cartDetails?[index].productId
                    .toString(),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalImage(
                    height: 100,
                    width: MediaQuery.of(context).size.width * .3,
                    imageUrl: logic.getCartRsp.value?.data
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
                          '${logic.getCartRsp.value?.data?.cartDetails?[index].productName}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].price)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].total)}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () async =>logic.inCreaseOrDecreaseQuantity(index: index, type: '-'),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey.shade200)),
                                      child: const Icon(Icons.remove,
                                          size: 25, color: Colors.grey),
                                    )),
                                Text(
                                  "${logic.getCartRsp.value?.data?.cartDetails?[index].quantity}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                GestureDetector(
                                    onTap: () async =>logic.inCreaseOrDecreaseQuantity(index: index, type: '+'),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: XColor.primary)),
                                      child: const Icon(Icons.add,
                                          size: 25, color: Colors.grey),
                                    ))
                              ],
                            ),
                            InkWell(
                              onTap: () async =>await logic.deleteCart(
                                  idCart: logic.getCartRsp.value?.data
                                      ?.cartDetails?[index].id
                                      .toString() ??
                                      ""),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
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
          return const SizedBox(
            height: 15,
          );
        },
      );
    });
  }
}
