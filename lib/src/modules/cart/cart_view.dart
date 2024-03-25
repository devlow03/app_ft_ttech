import 'package:app_ft_tmart/src/modules/cart/voucher/voucher_logic.dart';
import 'package:app_ft_tmart/src/modules/cart/voucher/voucher_view.dart';
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
                          Get.to(ProductDetailPage(
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
                                              GestureDetector(
                                                  onTap: () async {
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
                                                  child: Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
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
                                              GestureDetector(
                                                  onTap: () async {

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
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(color: XColor.primary)
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * .5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () async{
                      if(logic.getCartRsp.value?.data?.address!=null){
                        final order = Get.put(OrderLogic());
                        Utils.loading(()async{
                          await order.postCreateShipping(action: "p");
                          Get.back();
                          Get.to(const OrderPage());

                        },
                          // onSuccess: ()async{

                          // }

                        );

                      }
                      else{
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
            )
          ),
        ));
  }
}
