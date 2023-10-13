import 'package:app_ft_tmart/src/module/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../address/address_view.dart';
import '../cart/cart_logic.dart';
import '../cart/voucher/voucher_view.dart';
import '../product/product_view.dart';
import 'order_logic.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderLogic());
    final logicCart = Get.put(CartLogic(Get.find()));

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            'Thanh toán',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          centerTitle: true,
          actions: [
          ],
        ),
        body: Obx(() {
          return ListView(
            children: [
              const SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Get.to(AddressBookPage());
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
                                    Icons.location_on, color: XColor.primary,size: 18,),
                                  Text("Địa chỉ nhận hàng",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,

                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Text("Hứa Quang Thiện",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Địa chỉ: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          )
                                      ),
                                      TextSpan(
                                        spellOut: true,
                                        text: '149 Nguyễn Đệ, Phường An Hòa, Quận Ninh Kiều, Cần Thơ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            height: 1.5
                                        ),

                                      ),
                                    ]
                                ),
                              ),
                              const SizedBox(height: 10,),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Điện thoại: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          )
                                      ),
                                      TextSpan(
                                          text: '(+84)776506112',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              height: 1.5
                                          )
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Icon(Icons
                              .arrow_forward_ios_outlined, color: Colors.grey,
                            size: 18,)),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                  color: Colors.white,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    logicCart.getCartRsp.value?.data?.cartDetails?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(ProductPage(
                            id: logicCart.getCartRsp.value?.data
                                ?.cartDetails?[index]
                                .productId
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
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                              "${NumberFormat.simpleCurrency(
                                                  locale: "VI").format(
                                                  logicCart.getCartRsp.value
                                                      ?.data
                                                      ?.cartDetails?[index]
                                                      .price)}"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "x${logicCart.getCartRsp.value
                                                    ?.data
                                                    ?.cartDetails?[index]
                                                    .quantity}"),
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
                                        style: TextStyle(color: Colors.black),
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  )
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/coupon.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
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
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .6,
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
                                  Text(
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
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        logicCart.voucherTitle.value ?? "",
                                        style: TextStyle(
                                            color: XColor.primary,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Icon(Icons.arrow_forward_ios_outlined, size: 18,
                                color: Colors.grey,)
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
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
                                Icon(Icons.local_shipping_outlined,
                                  color: XColor.primary,),
                                const SizedBox(width: 5,),
                                Text("Phương thức vận chuyển",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,

                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text("Vận chuyển nội địa",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                              ),

                            ),
                            Text(
                                'Giao hàng nhanh',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    height: 1.5
                                )
                            ),


                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text("40.000đ"),
                          Center(child: Icon(Icons
                              .arrow_forward_ios_outlined, color: Colors.grey,
                            size: 18,)),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
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
                            text: TextSpan(
                                children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(Icons.monetization_on,
                                        color: Colors.yellow.shade700,)
                                  ),
                                  TextSpan(
                                    text: '  Phương thức thanh toán',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,

                                    ),
                                  )
                                ]
                            ),
                          ),
                          Row(
                            children: [
                              Text("Chọn",
                                style: TextStyle(
                                    color: XColor.primary
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_outlined, size: 15,
                                color: Colors.grey,)
                            ],
                          )

                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.payments_outlined, color: Colors.green,),
                          const SizedBox(width: 5,),
                          Text("Thanh toán khi nhận hàng")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.list_alt_outlined,
                                    color: Colors.orangeAccent,)
                              ),
                              TextSpan(
                                text: '  Chi tiết thanh toán',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,

                                ),
                              )
                            ]
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng tiền hàng"),
                            Text("${NumberFormat.simpleCurrency(
                                locale: "VI").format(
                                logicCart.getCartRsp.value?.data
                                    ?.info?.first.value)}",

                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng tiền phí vận chuyển"),
                            Text("40.000đ")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng tiền giảm giá"),
                            Text("${
                                logicCart.voucherValue.value}")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng thanh toán"),
                            Text("${NumberFormat.simpleCurrency(
                                locale: "VI").format(
                                logicCart.getCartRsp.value?.data
                                    ?.info?.last.value)}",
                              style: TextStyle(
                                  color: Colors.redAccent
                              ),
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
            height: 100,
            child: Obx(() {
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng thanh toán: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          "${NumberFormat.simpleCurrency(locale: "VI").format(
                              (logicCart.getCartRsp.value?.data?.info?.last
                                  .value) ?? 0)}",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  Get.to(OrderPage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15),
                                  child: Text(
                                    'Đặt hàng',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5
                                    ),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }))

    );
  }
}
