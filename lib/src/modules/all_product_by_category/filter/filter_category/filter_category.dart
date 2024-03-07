import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../filter_logic.dart';

class FilterCategory extends StatelessWidget {
  const FilterCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterAllLogic());
    final logicAll = Get.put(AllProductByCategoryLogic());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Danh mục sản phẩm",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: logic.getCategoryRsp.value?.data?.map((categoryType) {
              return CheckboxListTile(
                title: Text(categoryType.name ?? ""),
                value: logic.selectedCategoryTypes.contains(categoryType.id
                    .toString()),
                onChanged: (newValue) {
                  if (newValue == true) {
                    logic.selectedCategoryTypes.add(
                        categoryType.id.toString());
                    print("select >>>>>>>>>>>>>>>>${logic
                        .selectedCategoryTypes}");
                  } else {
                    logic.selectedCategoryTypes.remove(
                        categoryType.id.toString());
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
