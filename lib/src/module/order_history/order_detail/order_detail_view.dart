import 'package:app_ft_tmart/src/data/repositories/get_order_rsp.dart';
import 'package:app_ft_tmart/src/module/order_history/order_history_logic.dart';
import 'package:app_ft_tmart/src/module/product/product_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/xcolor.dart';
import '../../../widget/global_image.dart';
import '../../product/product_view.dart';
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
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${logic.getOrderByIdRsp.value?.data?.name}",
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
                                            '${logic.getOrderByIdRsp.value?.data?.billingAddress}',
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
                                              '${logic.getOrderByIdRsp.value?.data?.phone}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              height: 1.5))
                                    ]),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
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
                      itemCount: logic.getOrderByIdRsp.value?.data?.orderDetails
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        logic.addToList(
                            logic.getOrderByIdRsp.value?.data
                                ?.orderDetails?[index].productId
                                .toString(),
                            logic.getOrderByIdRsp.value?.data
                                ?.orderDetails?[index].quantity
                                .toString());
                        return InkWell(
                          onTap: () {
                            Get.to(ProductPage(
                              id: logic.getOrderByIdRsp.value?.data
                                  ?.orderDetails?[index].productId
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
                                  imageUrl: logic.getOrderByIdRsp.value?.data
                                      ?.orderDetails?[index].thumpnailUrl,
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
                                        '${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].productName}',
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
                                                "${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].priceFormated}"),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "x${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].quantity}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          "Tổng: ${logic.getOrderByIdRsp.value?.data?.orderDetails?[index].subtotalFormated}",
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
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?.first.text}",
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: (logic.getOrderByIdRsp.value?.data
                                      ?.infoTotalAmount?.length ??
                                  0) >=
                              3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Tổng tiền giảm giá"),
                                Text(
                                    "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?[1].text}")
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
                                "${logic.getOrderByIdRsp.value?.data?.infoTotalAmount?.last.text}",
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
                                  "${logic.getOrderByIdRsp.value?.data?.payment?.paymentMethod}",
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
                                onPressed: () async {
                                  await logicHistory.createVnPay(
                                      logic.getOrderByIdRsp.value?.data?.id ?? 0);
                                },
                                child: Text("Thanh toán"),
                              ),
                            ),
                          ],
                        ),
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
                        )
                      ],
                    ),
                  ),
                ),
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
                          replacement: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * .5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
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
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * .5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
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
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ))),
              ))),
    );
  }
}
