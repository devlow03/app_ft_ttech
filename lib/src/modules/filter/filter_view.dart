import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/repositories/get_brand_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_category_rsp.dart';
import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_logic.dart';
import 'package:app_ft_tmart/src/modules/filter/brand_item/brand_item.dart';
import 'package:app_ft_tmart/src/modules/filter/category_item/category_item.dart';
import 'package:app_ft_tmart/src/modules/filter/price_item/price_item.dart';
import 'package:app_ft_tmart/src/modules/search/search_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_logic.dart';

class FilterPage extends StatelessWidget {
  final bool? isCategory;

  FilterPage({Key? key, this.isCategory}) : super(key: key);

  final logic = Get.put(FilterLogic());

  @override
  Widget build(BuildContext context) {
    logic.isCategory.value = isCategory??false;
    return Obx(() {
      return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                centerTitle: false,
                automaticallyImplyLeading: false,
                title: Text("Lọc sản phẩm",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: logic.initialChildSize.value == 0.6
                          ? Colors.black
                          : XColor.primary
                  ),
                ),
                actions: [
                  IconButton(
                  
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close, color:Colors.black, size: 28,)
                  )
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PriceItem(),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return Visibility(
                            visible: logic.isCategory.isFalse,
                            child: const CategoryItem());
                      }),
                      const SizedBox(height: 20,),
                      const BrandItem(),
                      const SizedBox(height: 20,),
              
              
                    ],
                  )
                ],
              ),
              bottomNavigationBar: Visibility(
                visible: logic.initialChildSize.value == 0.6,
                child: BottomAppBar(
                  elevation: 1.0,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .6,
                    height: 50,
                    child: ElevatedButton(
                                    
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                            backgroundColor: XColor.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        onPressed: () async {
                          final search = Get.put(SearchLogic());
                          final allCategory = Get.put(
                              AllProductByCategoryLogic());
                          if (isCategory == true) {
                            Utils.loading(() async {
                              await allCategory.getProductCategory(
                                  brand: logic.selectedBrandTypes,
                                  category: logic.selectedCategoryTypes,
                                  price: logic.selectedPriceRange
                              );
                                    
                              Get.back();
                              logic.initialChildSize.value = 0.08;
                            });
                          }
                          else {
                            Utils.loading(() async {
                              await search.getSearch(
                                  keyword: logic.keyword.value,
                                  brand: logic.selectedBrandTypes,
                                  category: logic.selectedCategoryTypes,
                                  price: logic.selectedPriceRange
                              );
                              Get.back();
                              logic.initialChildSize.value = 0.08;
                            });
                          }
                        },
                        child: const Text("Áp dụng", style: TextStyle(
                            color: Colors.white
                        ),)
                    ),
                  ),
                ),
              ),
            ),
          );
    });
    
  }
}










