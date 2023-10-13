import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../list_product_logic.dart';
import 'filter_logic.dart';

class FilterPage extends StatelessWidget {
  final String? name;

  const FilterPage({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterLogic());
    final logicSearch = Get.put(ListProductLogic(Get.find()));
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Khoảng giá",
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
                      logic.selectedPriceRange.add(price['id']??"");
                      print(
                          "select >>>>>>>>>>>>>>>>${logic.selectedPriceRange}");
                    } else {
                      logic.selectedPriceRange.remove(price['id']);
                    }
                  },
                );
              }).toList() ??
                  [],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Danh mục sản phẩm",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Thương hiệu",
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
            const SizedBox(height: 10,),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: ()async{
                    Utils.loading(()async{
                      await logicSearch.getSearch(
                          name: logicSearch.keyController.text,
                          brand: logic.selectedBrandTypes,
                          category: logic.selectedCategoryTypes,
                          price: logic.selectedPriceRange
                      );
                      Get.back();
                    });

                  },
                  child: Text("Áp dụng")
              ),
            )
          ],
        );
      }),
    );
  }
}
