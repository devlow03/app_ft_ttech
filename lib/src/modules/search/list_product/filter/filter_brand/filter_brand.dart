import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../../../search_logic.dart';
import '../../list_product_logic.dart';
import '../filter_logic.dart';

class FilterBrand extends StatelessWidget {
  const FilterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterLogic());
    final logicSearch = Get.put(SearchLogic());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Thương thiệu",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: logic.getBrandRsp.value?.data?.map((brandType) {
              return CheckboxListTile(
                title: Text(brandType.name ?? ""),
                value: logic.selectedBrandTypes.contains(brandType.id
                    .toString()),
                onChanged: (newValue) {
                  if (newValue == true) {
                    logic.selectedBrandTypes.add(brandType.id.toString());
                    print(
                        "select >>>>>>>>>>>>>>>>${logic.selectedBrandTypes}");
                  } else {
                    logic.selectedBrandTypes.remove(brandType.id.toString());
                  }
                },
              );
            }).toList() ??
                [],
          ),
        ],
      );
    });
  }
}
