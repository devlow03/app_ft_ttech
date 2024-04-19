import 'package:app_ft_tmart/src/modules/cart/voucher_widget/voucher_widget.dart';
import 'package:app_ft_tmart/src/modules/order/address/order_address.dart';
import 'package:app_ft_tmart/src/modules/order/items/order_item.dart';
import 'package:app_ft_tmart/src/modules/order/payments/payments_logic.dart';
import 'package:app_ft_tmart/src/modules/order/payments/payments_view.dart';
import 'package:app_ft_tmart/src/modules/order/total/order_total.dart';
import 'package:app_ft_tmart/src/modules/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../cart/cart_logic.dart';
import '../cart/voucher/voucher_view.dart';
import '../product_detail/product_detail_view.dart';
import 'order_logic.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderLogic());
    final logicCart = Get.put(CartLogic());
    final logicPay = Get.put(PaymentsLogic());

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: const Text(
            'Thanh toán',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          centerTitle: true,
          actions: [],
        ),
        body:ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 10,
            ),
            const OrderAddress(),
            const SizedBox(
              height: 10,
            ),
            const OrderItem(),
            const SizedBox(height: 10,),
            const VoucherWidget(),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Visibility(
                visible: logic.totalFee.value != 0,
                child: Container(
                  padding: const EdgeInsets.all(15),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_shipping_outlined,
                                      color: XColor.primary,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Đơn vị vận chuyển",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Vận chuyển nội địa",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text('Giao hàng nhanh',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.5)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(logic.totalFee.value != 0
                                  ? NumberFormat.simpleCurrency(locale: 'VI')
                                  .format(logic.totalFee.value)
                                  : "chưa chọn địa chỉ"),
                              // Center(child: Icon(Icons
                              //     .arrow_forward_ios_outlined, color: Colors.grey,
                              //   size: 18,)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.payment,
                                        color: Colors.green,
                                      )),
                                  const TextSpan(
                                    text: '  Phương thức thanh toán',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  )
                                ]),
                              ),
                              InkWell(
                                onTap: () => Get.bottomSheet(
                                    isScrollControlled: true,
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height * .3,
                                        child: PaymentsPage())),
                                child: Row(
                                  children: [
                                    Text(
                                      "Chọn",
                                      style: TextStyle(color: XColor.primary),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 15,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() => Visibility(
                            visible: logicPay.selectPayment.value != null,
                            replacement:
                            Text("Chưa chọn phương thức thanh toán"),
                            child: Row(
                              children: [
                                Image.asset(
                                  "${logicPay.selectPayment.value?["thumbnail"]}",
                                  height: 35,
                                  width: 35,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${logicPay.selectPayment.value?["title"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),


            const SizedBox(
              height: 10,
            ),
            const OrderTotal(),
            const SizedBox(height: 30,),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                if (logicCart.getCartRsp.value?.data?.address ==
                    null) {
                  Fluttertoast.showToast(
                    msg: "Vui lòng chọn địa chỉ nhận hàng!",
                  );
                  Get.to(const AddressBookPage(
                    intoOrder: true,
                  ));
                } else if (logicPay.selectPayment.value == null) {
                  Fluttertoast.showToast(
                    msg: "Vui lòng chọn phương thức thanh toán!",
                  );
                  Get.bottomSheet(
                      isScrollControlled: true,
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height *
                              .3,
                          child: PaymentsPage()));
                } else {
                  await logic.postConfirmOrder(
                      cartId:
                      logicCart.getCartRsp.value?.data?.id ??
                          0,
                      address: logicCart
                          .getCartRsp.value?.data?.address,
                      payment:
                      logicPay.selectPayment.value?["value"]);
                }
              },
              child: Text(
                'Đặt hàng',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              )),
        ));
  }
}
