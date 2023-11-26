import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../filter_logic.dart';

class FilterPrice extends StatelessWidget {
  const FilterPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterLogic());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Khoảng giá",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: logic.priceRange.map((price) {
              return CheckboxListTile(
                title: Text(price['title'] ?? ""),
                value: logic.selectedPriceRange.contains(price['id']),
                onChanged: (newValue) {
                  print(">>>>>>>>>>>>>>>${newValue}");
                  if (newValue == true) {
                    logic.selectedPriceRange.add(price['id'] ?? "");
                    print(
                        "select >>>>>>>>>>>>>>>>${logic.selectedPriceRange}");
                  } else {
                    logic.selectedPriceRange.remove(price['id']);
                  }
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
