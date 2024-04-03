import 'package:app_ft_tmart/src/modules/home/product_suggest/product_suggest_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'not_order_logic.dart';
class NotOrder extends StatefulWidget {
  const NotOrder({super.key});

  @override
  State<NotOrder> createState() => _NotOrderState();
}

class _NotOrderState extends State<NotOrder> {
  @override
  Widget build(BuildContext context) {
  final logic = Get.put(NotOrderLogic());

    return WillPopScope(
      onWillPop: logic.onWillPop,
      child: Scaffold(
        body: Center(
          child: ListView(
            controller: logic.controller,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
             Column(
              children: [
                 Image.asset("assets/images/notepad.png",
              width: 80,
              height: 80,
              ),
              const SizedBox(height: 10,),
              const Text("Chưa có đơn hàng",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
              ],
             ),
    
              SizedBox(height: MediaQuery.of(context).size.height*.15,),
             const  ProductSuggestPage()
          ]),
        ),
        bottomNavigationBar: null,
      ),
    );
  }
}