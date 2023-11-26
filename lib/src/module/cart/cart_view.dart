import 'package:app_ft_tmart/src/module/cart/voucher/voucher_logic.dart';
import 'package:app_ft_tmart/src/module/cart/voucher/voucher_view.dart';
import 'package:app_ft_tmart/src/module/order_history/order_list/not_order/not_order.dart';
import 'package:app_ft_tmart/src/module/product/product_view.dart';
import 'package:app_ft_tmart/src/module/search/search_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../order/order_view.dart';
import 'cart_logic.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());
    logic.getCart();
    final logicVoucher = Get.put(VoucherLogic(Get.find()));
    

    print(
        ">>>>>>>>>>>>>>>${logic.getCartRsp.value?.data?.cartDetails?.length ?? 0}");
    return WillPopScope(
      onWillPop: () async {
        // await logicVoucher.deleteVoucher(cartId: int.parse((logic.getCartRsp.value?.data?.id??0).toString()));
        logic.voucherTitle.value = null;
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: const Text(
              'Giỏ hàng',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(const SearchPage());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: Obx(() {
            if(logic.getCartRsp.value?.data?.cartDetails?.isEmpty==true || logic.getCartRsp.value?.data == null){
              return const NotOrder();
            }
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      logic.getCartRsp.value?.data?.cartDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(ProductPage(
                          id: logic.getCartRsp.value?.data?.cartDetails?[index]
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "${NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].price)}"),
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
                                                  print(">>>>>>>>>>>>>>>>>>A");
                                                  int? quantity = int.parse(
                                                          ((logic
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
                                                    await logic.updateCartDetail(
                                                        idCart: logic
                                                                .getCartRsp
                                                                .value
                                                                ?.data
                                                                ?.cartDetails?[
                                                                    index]
                                                                .id
                                                                .toString() ??
                                                            "",
                                                        quantity: quantity);
                                                    await logic.getCart();
                                                  } else {
                                                    await logic.deleteCart(
                                                        idCart: logic
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
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 10,
                                                )),
                                            Text(
                                                "${logic.getCartRsp.value?.data?.cartDetails?[index].quantity}"),
                                            IconButton(
                                                onPressed: () async {
                                                  print(">>>>>>>>>>>>>>>>>>A");
                                                  int? quantity = int.parse(
                                                          ((logic
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
                                                    await logic.updateCartDetail(
                                                        idCart: logic
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
                                                icon: const Icon(
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
                                        child: const Padding(
                                          padding: EdgeInsets.all(5),
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
                                          await logic.deleteCart(
                                              idCart: logic
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
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey.shade100),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
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
                                      "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].total)}",
                                      style: const TextStyle(color: Colors.black),
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
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                    );
                  },
                )
              ],
            );
          }),
          bottomNavigationBar: Obx(() {
            return Visibility(
              visible:
                  (logic.getCartRsp.value?.data?.cartDetails?.length ?? 0) >= 1,
              child: BottomAppBar(
                  height: 160,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                    // fontWeight: FontWeight.w500,
                                    // letterSpacing: 0.5
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: logic.voucherTitle.value != null,
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
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: XColor.primary),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        logic.voucherTitle.value ?? "",
                                        style: TextStyle(
                                            color: XColor.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5),
                            ),
                            Text(
                              "${NumberFormat.simpleCurrency(locale: "VI").format((logic.getCartRsp.value?.data?.info?.last.value) ?? 0)}",
                              style: const TextStyle(
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
                            Container(
                              // padding: EdgeInsets.symmetric(vertical: 3),
                              width: MediaQuery.of(context).size.width * .23,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  onPressed: () {
                                    Get.bottomSheet(
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .6,
                                          child: VoucherPage(
                                              cartId: int.parse((logic
                                                      .getCartRsp
                                                      .value
                                                      ?.data
                                                      ?.id
                                                      .toString() ??
                                                  ""))),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible:
                                            logic.voucherTitle.value == null,
                                        replacement: Icon(
                                          Icons.verified,
                                          color: XColor.primary,
                                        ),
                                        child: Image.asset(
                                          "assets/images/voucher.png",
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          width: 2,
                                          height: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Expanded(
                                        child: Text(
                                          'Mã giảm giá',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width * .5,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    onPressed: () {
                                      Get.to(const OrderPage());
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        'Mua hàng',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          })),
    );
  }
}
