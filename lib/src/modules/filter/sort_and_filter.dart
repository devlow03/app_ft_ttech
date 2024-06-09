import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_logic.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_logic.dart';
import 'package:app_ft_tmart/src/modules/search/search_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'filter_view.dart';
import 'dart:developer' as dev;

class SortAndFilterWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isCategory;
  final AllProductByCategoryLogic? allCategoryLogic;

  const SortAndFilterWidget(
      {super.key, required this.isCategory, required this.allCategoryLogic});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterLogic());

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade100)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PopupMenuButton(

              color: Colors.white,
              position: PopupMenuPosition.under,
              onSelected: (value) async {
                if (value == true) {
                  logic.selectLatest.value = value as bool?;


                    Utils.loading(() async {
                      await allCategoryLogic?.getProductCategory(
                        latest: logic.selectLatest.value,
                        brand: logic.selectedBrandTypes.isNotEmpty==true?logic.selectedBrandTypes:[],
                        view: null,
                        name: allCategoryLogic?.keyword.value,


                      );
                      Get.back();
                    });
                  }

                else {
                  logic.sortPrice.value = value.toString();


                  if (isCategory == true) {
                    Utils.loading(() async {
                      await allCategoryLogic?.getProductCategory(
                        rangePrice: logic.sortPrice.value,
                        view: null,
                          name: allCategoryLogic?.keyword.value,
                        brand: logic.selectedBrandTypes.isNotEmpty==true?logic.selectedBrandTypes:[],


                      );
                      Get.back();
                    });
                  }
                }
              },
              itemBuilder: (context) {
                return logic.popupMenuItems.map((item) {
                  return PopupMenuItem(
                      onTap: () {
                        logic.titleSort.value = item["title"];
                      },
                      value: item["value"],
                      child: Text(item["title"],
                      )
                  );
                }).toList();
              },
              icon: Obx(() {
                return Row(
                  children: [
                    const Icon(Icons.swap_vert),
                    Text(
                        logic.titleSort.value != null ? logic.titleSort.value ??
                            "" : "Sắp xếp")
                  ],
                );
              })),
          IconButton(
              onPressed: () =>
                  Get.bottomSheet(FilterPage(
                    isCategory: true,

                  )
                  ),
              icon: const Row(
                children: [
                  PhosphorIcon(PhosphorIconsRegular.funnel),
                  Text("Lọc sản phẩm")
                ],
              ))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(30);
}
