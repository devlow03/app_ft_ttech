import 'package:app_ft_tmart/src/modules/cart/cart_info/cart_info.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_items/cart_items_screen.dart';
import 'package:app_ft_tmart/src/modules/cart/voucher/voucher_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/voucher/voucher_view.dart';
import 'package:app_ft_tmart/src/modules/cart/voucher_widget/voucher_widget.dart';
import 'package:app_ft_tmart/src/modules/order/order_logic.dart';
import 'package:app_ft_tmart/src/modules/order_history/not_order/not_order.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
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
        ">>>>>>>>>>>>>>>${logic.getCartRsp.value?.data?.cartDetails?.length ??
            0}");
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              SizedBox(
                height: 20,
              ),
              CartItemsScreen(),
              SizedBox(height: 20,),
              VoucherWidget(),
              SizedBox(height: 20,),
              CartInfo(),
              SizedBox(height: 30,),

            ],
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
          child: Obx(() {
            return Visibility(
              visible: logic.getCartRsp.value?.data?.cartDetails
                  ?.isNotEmpty == true,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      if (logic.getCartRsp.value?.data?.address != null) {
                        final order = Get.put(OrderLogic());
                        Utils.loading(() async {
                          await order.postCreateShipping(action: "p");
                          Get.back();
                          Get.to(const OrderPage());
                        },


                        );
                      }
                      else {
                        Get.to(const OrderPage());
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    )),
              ),
            );
          })
      ),
    );
  }
}
