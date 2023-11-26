import 'package:app_ft_tmart/src/module/order/payments/payments_logic.dart';
import 'package:app_ft_tmart/src/module/order/payments/payments_view.dart';
import 'package:app_ft_tmart/src/module/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../cart/cart_logic.dart';
import '../cart/voucher/voucher_view.dart';
import '../product/product_view.dart';
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
        body: Obx(() {
          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(const AddressBookPage(
                    intoOrder: true,
                  ));
                },
                child: Container(
                  color: Colors.white,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: XColor.primary,
                                    size: 18,
                                  ),
                                  const Text(
                                    "Địa chỉ nhận hàng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
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
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  color: Colors.white,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        logicCart.getCartRsp.value?.data?.cartDetails?.length ??
                            0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(ProductPage(
                            id: logicCart.getCartRsp.value?.data
                                ?.cartDetails?[index].productId
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
                                      '${logicCart.getCartRsp.value?.data?.cartDetails?[index].productName}',
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
                                              "${NumberFormat.simpleCurrency(locale: "VI").format(logicCart.getCartRsp.value?.data?.cartDetails?[index].price)}"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "x${logicCart.getCartRsp.value?.data?.cartDetails?[index].quantity}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(logicCart.getCartRsp.value?.data?.cartDetails?[index].total)}",
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  )),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/coupon.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Khuyến mãi",
                            style: TextStyle(
                              fontSize: 14,

                              // letterSpacing: 0.5
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(
                              isScrollControlled: true,
                              enableDrag: true,
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .6,
                                child: VoucherPage(
                                    cartId: int.parse((logicCart
                                            .getCartRsp.value?.data?.id
                                            .toString() ??
                                        ""))),
                              ));
                        },
                        child: Visibility(
                          visible: logicCart.voucherTitle.value != null,
                          replacement: Container(
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey),
                            //     borderRadius: BorderRadius.circular(5)
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Chưa áp mã giảm giá',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: XColor.primary),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        logicCart.voucherTitle.value ?? "",
                                        style: TextStyle(
                                            color: XColor.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return Visibility(
                  visible: logic.totalFee.value != 0,
                  child: Container(
                    color: Colors.white,
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
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
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
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.list_alt_outlined,
                                color: Colors.orangeAccent,
                              )),
                          TextSpan(
                            text: '  Chi tiết thanh toán',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          )
                        ]),
                      ),
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
                              "${logicCart.getCartRsp.value?.data?.info?.first.value}",
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: logic.totalFee.value != 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tổng tiền phí vận chuyển"),
                              Text(NumberFormat.simpleCurrency(locale: 'VI')
                                  .format(logic.totalFee.value))
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            logicCart.voucherValue.value?.isNotEmpty == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tổng tiền giảm giá"),
                              Text("${logicCart.voucherValue.value}")
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
                              "${logicCart.getCartRsp.value?.data?.info?.last.text}",
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
              ),
            ],
          );
        }),
        bottomNavigationBar: BottomAppBar(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width * .5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  if (logicCart.getCartRsp.value?.data?.address == null) {
                    Fluttertoast.showToast(
                      msg: "Vui lòng chọn địa chỉ nhận hàng!",
                    );
                    Get.to(const AddressBookPage(
                      intoOrder: true,
                    ));
                  }
                  else if (logicPay.selectPayment.value == null) {
                    Fluttertoast.showToast(
                      msg: "Vui lòng chọn phương thức thanh toán!",
                    );
                    Get.bottomSheet(
                        isScrollControlled: true,
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            child: PaymentsPage()));
                  } else {
                    await logic.postConfirmOrder(
                        cartId: logicCart.getCartRsp.value?.data?.id ?? 0,
                        address: logicCart.getCartRsp.value?.data?.address,
                        payment: logicPay.selectPayment.value?["value"]);
                  }

                  // await logicCart.getCart();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Đặt hàng',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
          ),
        )));
  }
}
