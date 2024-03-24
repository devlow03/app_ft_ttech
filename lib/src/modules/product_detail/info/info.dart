import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(
      () => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.getProductByIdRsp.value?.data
                                  ?.manufacturerName ??
                              "",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          logic.getProductByIdRsp.value?.data?.productName ??
                              "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(locale: 'VI').format(
                        logic.getProductByIdRsp.value?.data?.price ?? 0),
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text("Số lượng: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Visibility(
                                visible: logic.quantity.value >= 2,
                                replacement: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 15,
                                      color: Colors.grey.shade200,
                                    ),
                                    onPressed: null),
                                child: IconButton(
                                  icon: const Icon(Icons.remove, size: 15),
                                  onPressed: () {
                                    logic.quantity.value--;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Text(logic.quantity.value.toString()),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 15),
                                onPressed: () {
                                  logic.quantity.value++;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
