import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_logic.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import '../all_product_by_category/all_product_by_category_view.dart';

import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());
    final all = Get.put(AllProductByCategoryLogic());
    // logic.getSearchRsp.value = null;
    // logic.showKeyboard(context);

    return WillPopScope(
      onWillPop: ()async{
        logic.keyController.clear();
        logic.getSearchRsp.value = null;
        return true;

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: XColor.primary,),

            ),

            title: SearchWidget(
              autofocus: true,
              controller: logic.keyController,
              onChanged: (value) {

                logic.getSearchSuggest();
              },
              onSubmitted: (value) async{
                all.keyword.value = logic.keyController.text;
                await all.getProductCategory();
                Get.to(AllProductByCategoryPage(
                  keyword: logic.keyController.text,

                ));

              },
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
                itemCount: (logic.getSearchSuggestionRsp.value?.data?.length ?? 0),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: ()async{
                      all.keyword.value = logic.getSearchSuggestionRsp.value?.data?[index].keyword;
                      await all.getProductCategory();
                      Get.to(AllProductByCategoryPage(
                        keyword: logic.getSearchSuggestionRsp.value?.data?[index].keyword,


                      ));
                      // logic.logic.keyword.value = logic.getSearchSuggestionRsp.value?.data?[index].keyword;
                      //  logic.getSearch(keyword: logic.getSearchSuggestionRsp.value?.data?[index].keyword);
                      // Get.to( ListProductDetailPage(keyword: logic.getSearchSuggestionRsp.value?.data?[index].keyword,));
                    },
                    leading: const Icon(Icons.search),
                    title: Text('${logic.getSearchSuggestionRsp.value?.data?[index].keyword}',style: const TextStyle(color: Colors.black),),
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
                    color: Colors.grey.shade100,
                  ),
                );
              },
              ),
              const SizedBox(height: 10,),

            ],
          );
        }),
      ),
    );
  }
}