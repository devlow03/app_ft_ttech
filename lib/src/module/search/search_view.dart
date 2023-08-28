import 'package:app_ft_tmart/src/module/list_product/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.grey.shade200,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white,),

          ),
          title: SizedBox(
            width: double.infinity,
            height: 40,
            child: TextField(
              controller: logic.keyController,
              onTap: () {
                // Get.to(SearchPage());
              },
              onChanged: (value) {
                // logic.onSearch.value = false;
                // logic.name = value;
                // logic.getSearch(name: logic.name);
              },
              onSubmitted: (value){
                Get.to(List_productPage(name: logic.keyController.text,)
                );
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                hintText: 'Tìm sản phẩm',
                // suffixIcon: InkWell(
                //     onTap: () {
                //       logic.onSearch.value = true;
                //       logic.getSearch(name: logic.name);
                //     },
                //     child: Icon(Icons.search, color: Colors.black, size: 30,)),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Container(
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.filter_alt_outlined,
                        color: XColor.primary,
                      )
                  ),
                ),
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),
                ),

              ),
            ),
          ),

          actions: null
        // [

        // ],
      ),
    );
  }
}
