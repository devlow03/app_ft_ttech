import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
import 'list_product/list_product_view.dart';
import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());

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

            title: SizedBox(
              width: double.infinity,
              height: 45,
              child: TextField(
                autofocus: true,
                controller: logic.keyController,
                onTap: () {

                },
                onChanged: (value) {

                  logic.getSearch();
                },
                onSubmitted: (value) {

                  Get.to(const ListProductDetailPage());

                },


                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  hintStyle: const TextStyle(
                    color: Colors.grey,

                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  suffixIcon:  Image.asset('assets/images/icons/search.png',width: 10,height: 10),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.transparent
                    ),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.transparent
                    ),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
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
                itemCount: (logic.getSearchRsp.value?.data
                    ?.length ?? 0)>5?5:(logic.getSearchRsp.value?.data
                    ?.length ?? 0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Get.to(ProductDetailPage(id: logic.getSearchRsp.value?.data?[index]
                          .id.toString() ?? ""));

                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: GlobalImage(
                              imageUrl: logic.getSearchRsp.value?.data?[index]
                                  .thumpnailUrl ?? "",
                              width: MediaQuery.of(context).size.width*.2,
                              height: 50,
                              boxFit: BoxFit.contain,
                            ),
                            title: Text(logic.getSearchRsp.value?.data?[index]
                                .productName ?? ""),
                            subtitle: Text(
                              NumberFormat.simpleCurrency(locale: 'VI')
                                  .format(
                                  logic.getSearchRsp.value?.data?[index]
                                      .price ??
                                      0),
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1
                              ),
                            ),
                          )
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
                    color: Colors.grey.shade100,
                  ),
                );
              },
              ),
              const SizedBox(height: 10,),
              Visibility(
                visible: (logic.getSearchRsp.value?.data
                    ?.length ?? 0)>5,
                child: TextButton(
                    onPressed: (){
                      Get.to(const ListProductDetailPage());
                    },
                    child: Text("Xem thêm sản phẩm")
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}