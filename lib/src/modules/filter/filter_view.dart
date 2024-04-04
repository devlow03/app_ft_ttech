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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.white,
        backgroundColor: XColor.primary,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: Text("Lọc sản phẩm",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PriceItem(),
               SizedBox(height: 20,),
              CategoryItem(),
               SizedBox(height: 20,),
              BrandItem()



            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .5,
              height: 50,
              child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: XColor.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  onPressed: () async{
                    final search = Get.put(SearchLogic());
                    final allCategory = Get.put(AllProductByCategoryLogic());
                    if(isCategory==true){
                      Utils.loading(() async {
                        await allCategory.getProductCategory(
                            brand: logic.selectedBrandTypes,
                            category: logic.selectedCategoryTypes,
                            price: logic.selectedPriceRange
                        );
                        Get.back();
                        Get.back();
                      });
                    }
                    else{
                      Utils.loading(()async{

                        await search.getSearch(
                            keyword: logic.keyword.value,
                            brand: logic.selectedBrandTypes,
                            category: logic.selectedCategoryTypes,
                            price: logic.selectedPriceRange
                        );
                        Get.back();
                        Get.back();
                      });
                    }
                  },
                  child: Text("Áp dụng", style: TextStyle(
                      color: Colors.white
                  ),)
              ),
            ),
          ),
        ),
      ),
    );
  }
}










