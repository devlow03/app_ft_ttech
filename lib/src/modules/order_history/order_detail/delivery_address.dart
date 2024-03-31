import 'package:app_ft_tmart/src/modules/order_history/order_history_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/xcolor.dart';
import 'order_detail_logic.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderDetailLogic());
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icon(
                //   size: 18,
                //   Icons.location_on_outlined,color: XColor.primary,),
                // SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Địa chỉ nhận hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Obx(() {
                        final data = logic.getOrderByIdRsp.value?.data;
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${data?.name}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Địa chỉ: ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                TextSpan(
                                  spellOut: true,
                                  text:
                                  '${data?.billingAddress}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      height: 1.5),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Điện thoại: ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                TextSpan(
                                    text:
                                    '${data?.phone}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        height: 1.5))
                              ]),
                            )
                          ],
                        );
                      })
                    ],
                  ),
                ),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
