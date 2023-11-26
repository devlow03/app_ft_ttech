import 'package:app_ft_tmart/src/module/order/payments/payments_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PaymentsLogic());
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey.shade50,
          title: const Text(
            "Chọn phương thức thanh toán",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: logic.paymentList.map((e) {
            return Obx(() => RadioListTile(
                  value: e,
                  groupValue: logic.selectPayment.value,
                  title: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            e['thumbnail'],
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        e["title"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onChanged: (value) {
                    logic.selectPayments(value);
                  },
                ));
          }).toList(),
        ),
      ),
    );
  }
}
