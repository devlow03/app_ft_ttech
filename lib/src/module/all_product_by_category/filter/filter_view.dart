import 'package:app_ft_tmart/src/module/all_product_by_category/all_product_by_category_logic.dart';
import 'package:app_ft_tmart/src/module/all_product_by_category/filter/filter_brand/filter_brand.dart';
import 'package:app_ft_tmart/src/module/all_product_by_category/filter/filter_category/filter_category.dart';
import 'package:app_ft_tmart/src/module/all_product_by_category/filter/filter_price/filter_price.dart';
import 'package:app_ft_tmart/src/module/search/search_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_logic.dart';

class FilterPage extends StatelessWidget {
  final String? name;

  const FilterPage({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterAllLogic());
    final logicAll = Get.put(AllProductByCategoryLogic());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Bộ lọc sản phẩm",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Obx(() {
        if(logicAll.idCategory.value!=null){
          return ListView(
            children: const [
              FilterPrice(),
              FilterBrand(),
            ],
          );
        }
        else if(logicAll.idBrand.value!=null){
          return ListView(
            children: const [
              FilterPrice(),
              FilterCategory(),
            ],
          );
        }
        return Center();
      }),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onPressed: () async {
                  Utils.loading(() async {
                    await logicAll.getProductCategory(
                        brand: logic.selectedBrandTypes,
                        category: logic.selectedCategoryTypes,
                        price: logic.selectedPriceRange
                    );
                    Get.back();
                    Get.back();
                  });
                },
                child: const Text("Áp dụng")
            ),
          )
      ),
    );
  }
}
