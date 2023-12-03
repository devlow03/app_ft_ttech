import 'package:app_ft_tmart/src/module/cart/voucher/voucher_logic.dart';
import 'package:app_ft_tmart/src/module/cart/voucher/voucher_view.dart';
import 'package:app_ft_tmart/src/module/order_history/not_order/not_order.dart';
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
    logic.onReady();
    
     
    print(
        ">>>>>>>>>>>>>>>${logic.getCartRsp.value?.data?.cartDetails?.length ?? 0}");
    return WillPopScope(
        onWillPop: () async {
          // await logicVoucher.deleteVoucher(cartId: int.parse((logic.getCartRsp.value?.data?.id??0).toString()));
          logic.voucherTitle.value = null;
          logic.onClearCart.value==false;
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
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
            if (logic.getCartRsp.value?.data?.cartDetails?.isEmpty == true ||
                logic.getCartRsp.value?.data == null) {
                  
              return const NotOrder();
            }
            return RefreshIndicator(
              onRefresh: logic.refresh,
              child: ListView(
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
                            id: logic.getCartRsp.value?.data
                                ?.cartDetails?[index].productId
                                .toString(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].total)}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>A");
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
                                                  icon: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.grey.shade200)
                                                    ),
                                                    child:  const Icon(
                                                      Icons.remove,
                                                      size: 25,
                                                      color: Colors.grey
                                                    ),
                                                  )),
                                              Text(
                                                  "${logic.getCartRsp.value?.data?.cartDetails?[index].quantity}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                  ),
                                                  ),
                                              IconButton(
                                                  onPressed: () async {
                                                    print(
                                                        ">>>>>>>>>>>>>>>>>>A");
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
                                                  icon: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.grey.shade200)
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 25,
                                                      color: Colors.grey
                                                    ),
                                                  ))
                                            ],
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
                                                      color:
                                                          Colors.grey.shade200),
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15,);
                    },
                  )
                ],
              ),
            );
          }),
          bottomNavigationBar: BottomAppBar(
            child: Obx(() => Visibility(
                  visible:logic.onClearCart.value==false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width * .5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    primary: Colors.white),
                                onPressed: () async {
                                  await logic.removeCart();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Xóa giỏ hàng',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: XColor.primary),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
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
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  Get.to(const OrderPage());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
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
                  ),
                )),
          ),
        ));
  }
}
