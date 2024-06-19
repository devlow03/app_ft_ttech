import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/order/order_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderTotal extends StatelessWidget {
  const OrderTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(OrderLogic());
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(5),
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chi tiết thanh toán",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20,),
              Visibility(
                visible: logic.totalFee.value != 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tổng tiền phí vận chuyển"),
                    Text(NumberFormat.simpleCurrency(locale: 'VI')
                        .format(0))
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: logicCart.getCartRsp.value?.data?.info?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(height: 20,),
                itemBuilder: (context, index) {
                  final info = logicCart.getCartRsp.value?.data?.info?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(info?.title ?? "",style: TextStyle(fontSize: 15,fontWeight: info?.code=='total'?FontWeight.bold:FontWeight.w400),),
                      Text(
                        "${info?.text}",style: TextStyle(
                          color: info?.code=='total'?Colors.red:Colors.black
                      ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
