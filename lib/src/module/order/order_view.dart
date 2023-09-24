import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../address/address_view.dart';
import '../cart/cart_logic.dart';
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
                                Icon(Icons.location_on, color: XColor.primary,),
                                Text("Địa chỉ nhận hàng",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 1
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  ),
                                ],
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
                            categoryId: logicCart.getCartRsp.value?.data
                                ?.cartDetails?[index].categoryId
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
                                      child: Text(
                                          "${NumberFormat.simpleCurrency(
                                              locale: "VI").format(
                                              logicCart.getCartRsp.value?.data
                                                  ?.cartDetails?[index]
                                                  .price)}"),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.grey.shade100),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>A");
                                                    int? quantity = int.parse(
                                                        ((logicCart
                                                            .getCartRsp
                                                            .value
                                                            ?.data
                                                            ?.cartDetails?[
                                                        index]
                                                            .quantity)
                                                            .toString())) -
                                                        1;
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>${quantity}");
                                                    if (quantity >= 1) {
                                                      await logicCart
                                                          .updateCartDetail(
                                                          idCart: logicCart
                                                              .getCartRsp
                                                              .value
                                                              ?.data
                                                              ?.cartDetails?[
                                                          index]
                                                              .id
                                                              .toString() ??
                                                              "",
                                                          quantity: quantity);
                                                      await logicCart.getCart();
                                                    } else {
                                                      await logicCart
                                                          .deleteCart(
                                                          idCart: logicCart
                                                              .getCartRsp
                                                              .value
                                                              ?.data
                                                              ?.cartDetails?[
                                                          index]
                                                              .id
                                                              .toString() ??
                                                              "");
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    size: 10,
                                                  )),
                                              Text(
                                                  "${logicCart.getCartRsp.value
                                                      ?.data
                                                      ?.cartDetails?[index]
                                                      .quantity}"),
                                              IconButton(
                                                  onPressed: () async {
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>A");
                                                    int? quantity = int.parse(
                                                        ((logicCart
                                                            .getCartRsp
                                                            .value
                                                            ?.data
                                                            ?.cartDetails?[
                                                        index]
                                                            .quantity)
                                                            .toString())) +
                                                        1;
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>${quantity}");
                                                    if (quantity >= 1) {
                                                      await logicCart
                                                          .updateCartDetail(
                                                          idCart: logicCart
                                                              .getCartRsp
                                                              .value
                                                              ?.data
                                                              ?.cartDetails?[
                                                          index]
                                                              .id
                                                              .toString() ??
                                                              "",
                                                          quantity: quantity);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 10,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.grey.shade100),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await logicCart.deleteCart(
                                                idCart: logicCart
                                                    .getCartRsp
                                                    .value
                                                    ?.data
                                                    ?.cartDetails?[index]
                                                    .id
                                                    .toString() ??
                                                    "");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .shade300),
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Colors.grey.shade100),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
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
                          height: 2,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  )
              )
            ],
          );
        })
    );
  }
}
