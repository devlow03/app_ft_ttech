import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/xcolor.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
          return Visibility(
            visible:
                logic.getProductByIdRsp.value?.data?.thumpnailUrl?.isNotEmpty ==
                    true,
            child: BottomAppBar(
              height: 150,
              // color: Colors.transparent,
              elevation: 0.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tổng tiền: "),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              NumberFormat.simpleCurrency(locale: 'VI').format(
                                  ((logic.getProductByIdRsp.value?.data
                                              ?.price ??
                                          0) *
                                      (logic.quantity.value))),
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                await logic.postAddCart(
                                    productId: logic
                                            .getProductByIdRsp.value?.data?.id
                                            .toString() ??
                                        "",
                                    quantity:
                                        logic.quantity.value.toString() ?? "");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: XColor.primary),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Thêm vào giỏ hàng',
                                  style: TextStyle(color: XColor.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                await logic.buyNow(
                                    productId: logic
                                            .getProductByIdRsp.value?.data?.id
                                            .toString() ??
                                        "",
                                    quantity:
                                        logic.quantity.value.toString() ?? "");
                              },
                              style: ElevatedButton.styleFrom(
                                primary: XColor.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Mua ngay",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}