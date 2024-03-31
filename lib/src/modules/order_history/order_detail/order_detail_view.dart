import 'package:app_ft_tmart/src/data/repositories/get_order_rsp.dart';
import 'package:app_ft_tmart/src/modules/order_history/order_detail/delivery_address.dart';
import 'package:app_ft_tmart/src/modules/order_history/order_detail/detail_items.dart';
import 'package:app_ft_tmart/src/modules/order_history/order_history_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/xcolor.dart';
import '../../../widget/global_image.dart';
import '../../product_detail/product_detail_view.dart';
import 'order_detail_logic.dart';

class OrderDetailPage extends StatelessWidget {
  final String? id;
  const OrderDetailPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderDetailLogic());
    final logicHistory = Get.put(OrderHistoryLogic());
    logic.productId.clear();
    logic.productQuantity.clear();
    logic.getOrderById(id: id ?? "");
    
    return WillPopScope(
      onWillPop: ()async{
        logic.productId.clear();
        logic.productQuantity.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: const Text(
              'Thông tin đơn hàng',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
            ),
            centerTitle: true,
            actions: [],
          ),
          body: Obx(() {
            if (logic.getOrderByIdRsp.value?.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: XColor.primary,
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
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
                                    "Thông tin vận chuyển",
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
                                    fontSize: 15, fontWeight: FontWeight.w700),
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const DeliveryAddress(),
                const SizedBox(
                  height: 10,
                ),
                const DetailItems(),

                const SizedBox(
                  height: 10,
                ),
                Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(
                                      Icons.payment,
                                      color: Colors.green,
                                    )),
                                TextSpan(
                                  text: '  Phương thức thanh toán',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Visibility(
                                  visible: logic.getOrderByIdRsp.value?.data
                                          ?.payment?.paymentMethod ==
                                      "Thanh toán bằng VNPAY",
                                  replacement: Image.asset(
                                    "assets/images/cod.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  child: Image.asset(
                                    "assets/images/vnpay.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  logic.getOrderByIdRsp.value?.data
                                      ?.payment?.paymentMethod ==
                                      "Thanh toán bằng VNPAY"?"Thanh toán VNPAY":"Thanh toán COD",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: logic.getOrderByIdRsp.value?.data?.payment
                                          ?.paymentMethod ==
                                      "Thanh toán bằng VNPAY" &&
                                  logic.getOrderByIdRsp.value?.data?.payment
                                          ?.paymentStatus ==
                                      "Chờ xác nhận" &&
                                  logic.getOrderByIdRsp.value?.data?.statusCode !=
                                      "cancelled",
                              replacement: Text(
                                "${logic.getOrderByIdRsp.value?.data?.payment?.paymentStatus}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: XColor.primary),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: XColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                  )
                                ),
                                onPressed: () async {
                                  await logicHistory.createVnPay(
                                      logic.getOrderByIdRsp.value?.data?.id ?? 0);
                                },
                                child: const Text("Thanh toán",
                                  style: TextStyle(

                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Mã đơn hàng",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "${logic.getOrderByIdRsp.value?.data?.orderNumber}")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Thời gian đặt hàng",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(DateFormat('dd-MM-yyyy').format(
                                logic.getOrderByIdRsp.value?.data?.orderDate ??
                                    DateTime.now()))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: logic.getOrderByIdRsp.value?.data?.payment
                                      ?.paymentMethod ==
                                  "Thanh toán bằng VNPAY" &&
                              logic.getOrderByIdRsp.value?.data?.payment
                                      ?.paymentStatus ==
                                  "Thành công",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Thời gian thanh toán",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(logic.getOrderByIdRsp.value?.data?.payment
                                      ?.paydate ??
                                  "")
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            );
          }),
          bottomNavigationBar: Obx(() => Visibility(
                visible: logic.getOrderByIdRsp.value?.data != null,
                child: BottomAppBar(
                    child: Obx(() => Visibility(
                          visible:
                              logic.getOrderByIdRsp.value?.data?.statusCode ==
                                      "cancelled" ||
                                  logic.getOrderByIdRsp.value?.data?.statusCode ==
                                      "delivered" ||
                                  logic.getOrderByIdRsp.value?.data?.statusCode ==
                                      "returned",
                          replacement: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .85,

                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    primary: Colors.redAccent),
                                onPressed: () async {
                                  await logic.cancelOrder(
                                      "${logic.getOrderByIdRsp.value?.data?.id}",
                                      "${logic.getOrderByIdRsp.value?.data?.orderDetails?.first.productName}",
                                      "${logic.getOrderByIdRsp.value?.data?.orderDetails?.first.thumpnailUrl}",
                                      "${logic.getOrderByIdRsp.value?.data?.orderNumber}",
                                      context
                                      );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Hủy đơn hàng',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                    ),
                                  ),
                                )),
                          ),
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
                                        horizontal: 5, vertical: 3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    primary: XColor.primary),
                                onPressed: () async {
                                  await logic.rePurchase();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Mua lại',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                    ),
                                  ),
                                )),
                          ),
                        ))),
              ))),
    );
  }
}
