import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/global_product.dart';
import '../product/product_view.dart';
import '../search/search_view.dart';
import 'list_product_logic.dart';

class ListProductPage extends StatelessWidget {
  final String? id;
  final String? name;

  const ListProductPage({Key? key, this.id,  this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ListProductLogic(Get.find()));
    logic.keyController.text=name??"";
    logic.getSearch(name: name??"", page: logic.page.value);

    return WillPopScope(
      onWillPop: ()async{
        logic.keyController.text ="";
        logic.getSearchRsp.value =null;
        logic.page.value=10;
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.grey.shade200,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white,),

          ),
          title: Container(
            decoration: BoxDecoration(

            ),
            width: double.infinity,
            height: 40,
            child: TextField(
              autofocus: false,
              controller: logic.keyController,
              readOnly: true,
              onTap: () {
                Get.to(SearchPage());
              },
              onChanged: (value) {
                // logic.getProduct(name: value);
              },
              onSubmitted: (value){
                // logic.getProduct(name: value);
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

          actions:[
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.filter_alt_outlined,color: Colors.white,)
            ),

          ]
        ),
        body: Obx(() {
          if(logic.getSearchRsp.value?.data?.isEmpty??true){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: XColor.primary,
                  ),
                  const SizedBox(height: 5,),
                  Text("Đang tải")
                ],
              ),
            );
          }
          return ListView(
            controller: logic.controller,
            children: [
              const SizedBox(height: 10,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: logic.getSearchRsp.value?.data?.length??0,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, ind) {
                        logic.indexPage.value=ind;
                        return InkWell(
                          onTap: () {
                            Get.to(ProductPage(
                              id: logic.getSearchRsp.value?.data?[ind].id.toString(),
                              categoryId: logic.getSearchRsp.value?.data?[ind].categoryId.toString(),
                            ));
                          },
                          child: GlobalProduct(
                            imageLink:logic.getSearchRsp.value?.data?[ind].thumpnailUrl,
                            defaultPrice: '${logic.getSearchRsp.value?.data?[ind].defaultPrice}',
                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                            price:
                            '${ logic.getSearchRsp.value?.data?[ind].price}',
                            nameProduct:
                            logic.getSearchRsp.value?.data?[ind].productName,
                            numStar: '5.0',
                          ),
                        );

                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3 / 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Visibility(
                    visible: logic.page.value<(logic.getSearchRsp.value?.meta?.total??0),
                    replacement: Center(),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: XColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  // TextButton(
                  //     onPressed: (){
                  //       print(">>>>>>>>>>>>>>>>>>>${logic.isLoading.value}");
                  //     },
                  //     child: Text('a')
                  // )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
