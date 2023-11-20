import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order_detail/order_detail_view.dart';
import '../order_history_logic.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderHistoryLogic());
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: logic.getOrderRsp.value?.data?.length ?? 0,
        itemBuilder: (context, index) {
          final data = logic.getOrderRsp.value?.data?[index];
          return InkWell(
            onTap: ()=>Get.to(OrderDetailPage(data: data,)),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              // padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.storefront,),
                              const SizedBox(width: 5,),
                              Text("TMart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              )
                            ],
                          ),
                          Text("Chờ xác nhận",
                          style: TextStyle(
                            color: XColor.primary
                          ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 5,),
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
                                    color: Colors.redAccent
                                )
                            ),
                            Text("x${data?.orderDetails?.first.quantity}",
                            style: TextStyle(
                              color: Colors.black
                            ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:  Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${data?.orderDetails?.length??0} sản phẩm"),
                          RichText(text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: "Thành tiền: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    )
                                ),
                                const WidgetSpan(child: SizedBox(width: 5,)),
                                TextSpan(
                                    text: "${data?.infoTotalAmount?.last.text}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent
                                    )
                                )
                              ]
                          ))
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10,);
      },
      );
    });
  }
}
