import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartInfo extends StatelessWidget {
  const CartInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),


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
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logic.getCartRsp.value?.data?.info?.length ?? 0,
          separatorBuilder: (context, index) => const SizedBox(height: 20,),
          itemBuilder: (context, index) {
            final info = logic.getCartRsp.value?.data?.info?[index];
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
      );
    });
  }
}
