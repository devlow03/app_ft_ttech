import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/order/order_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/address_book/address_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrderAddress extends StatelessWidget {
  const OrderAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderLogic());
    final logicCart = Get.put(CartLogic());
    return InkWell(
      onTap: () {
        Get.to(const AddressBookPage(
          intoOrder: true,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
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
                      return Visibility(
                        visible:
                        logicCart.getCartRsp.value?.data?.name !=
                            null,
                        replacement: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Nhấn để chọn địa chỉ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${logicCart.getCartRsp.value?.data?.name}",
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
                                  '${logicCart.getCartRsp.value?.data?.address}',
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
                                    '${logicCart.getCartRsp.value?.data?.phone}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        height: 1.5))
                              ]),
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 18,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
