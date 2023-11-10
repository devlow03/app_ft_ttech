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
      body: ListView.separated(
        // physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.filterComponent.length,
        itemBuilder: (context,index){
          return logic.filterComponent[index]["widget"];
        }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10,);
      },

      ),
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
      ),
    );
  }
}
