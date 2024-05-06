import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/profile/order_history/not_order/not_order.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../order_detail/order_detail_view.dart';
import '../order_history_logic.dart';
import 'order_list_logic.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderHistoryLogic());
    final logicOrderList = Get.put(OrderListLogic());
    logic.getOrder();
    return Obx(() {
      if(logic.getOrderRsp.value?.data?.isEmpty==true){
        return const NotOrder();
      }
      return ListView(
        controller: logicOrderList.controller,
        children: [
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: logic.getOrderRsp.value?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final data = logic.getOrderRsp.value?.data?[index];
              return InkWell(
                onTap: () => Get.to(OrderDetailPage(
                  id: data?.id.toString(),
                  
                )),
                child: Container(
                  margin: const EdgeInsets.symmetric( vertical: 5),
                  // padding: EdgeInsets.all(8),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        
                        ListTile(
                          leading: GlobalImage(
                            imageUrl: data?.orderDetails?.first.thumpnailUrl,
                            width: 50,
                            height: 100,
                          ),
                          title: Text('${data?.orderDetails?.first.productName}'),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${data?.orderDetails?.first.priceFormated}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                                Text(
                                  "x${data?.orderDetails?.first.quantity}",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data?.orderDetails?.length ?? 0} sản phẩm"),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: "Thành tiền: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const WidgetSpan(
                                    child: SizedBox(
                                  width: 5,
                                )),
                                TextSpan(
                                    text: "${data?.infoTotalAmount?.last.text}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent))
                              ]))
                            ],
                          ),
                        ),
                      
                        Visibility(
                          visible: data?.payment?.paymentMethod == "Thanh toán bằng VNPAY" && data?.payment?.paymentStatus == "Chờ xác nhận" && data?.statusCode!="cancelled",
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                    )
                                  ),
                                  onPressed: ()async{
                                    logic.createVnPay(data?.id??0);
                                  },
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(vertical:5),
                                     child: Text("Thanh toán",
                                       style: TextStyle(

                                           fontWeight: FontWeight.w600,
                                           color: Colors.white
                                       ),
                                     ),
                                   )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
          const SizedBox(height: 30,),
                  Visibility(
                    visible: logic.page.value <
                        (logic.getOrderRsp.value?.meta?.total ??
                            0),
                    replacement: Center(),
                    child: Center(
                      child: SpinKitCircle(size: 40,
                      color: Colors.grey,
                      )
                    ),
                  ),
                  const SizedBox(height: 30,),
        ],
      );
    });
  }
}
