import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:app_ft_tmart/src/module/list_product/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../list_product/list_product_logic.dart';
import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());
    final logicSearch = Get.put(ListProductLogic(Get.find()));
    logic.showKeyboard(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.grey.shade200,
          leading: IconButton(
            onPressed: () {
              Get.offAll(IndexPage());
            },
            icon: Icon(Icons.arrow_back, color: Colors.white,),

          ),
          title: SizedBox(
            width: double.infinity,
            height: 40,
            child: TextField(
              focusNode: logic.focusNode,
              controller: logic.keyController,
              onTap: () {

              },
              onChanged: (value) {
                // logic.keyController.text=value;
                logicSearch.getProduct(name: value);
              },
              onSubmitted: (value) {
                logic.keyController.text=value;
                Get.to(ListProductPage(name: value,)
                );
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                hintText: 'Tìm sản phẩm',
                // suffixIcon: InkWell(
                //     onTap: () {
                //       logic.onSearch.value = true;
                //       logic.getSearch(name: logic.name);
                //     },
                //     child: Icon(Icons.search, color: Colors.black, size: 30,)),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2, vertical: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: XColor.primary,
                        borderRadius: BorderRadius.circular(2)

                    ),
                    child: IconButton(
                        onPressed: () {
                          Get.to(
                              ListProductPage(name: logic.keyController.text,));
                        },
                        icon: Icon(Icons.search,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
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
      body: Obx(() {
        return ListView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: logicSearch.getProductRsp.value?.searchProducts
                  ?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.to(ListProductPage(name: logic.keyController.text,)
                    );
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          logicSearch.getProductRsp.value?.searchProducts?[index]
                              .name ?? ""),
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.grey.shade200,
                ),
              );
            },
            )
          ],
        );
      }),
    );
  }
}
