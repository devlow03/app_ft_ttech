import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/module/list_product/filter/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';
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
    final logicCart = Get.put(CartLogic());
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    logic.keyController.text = name??'';
    logic.keyController.text=name??"";
    logic.getSearch(name: name??"");

    return WillPopScope(
      onWillPop: ()async{
        logic.keyController.text ="";
        logic.getSearchRsp.value =null;
        logic.page.value=10;
        return true;

      },
      child: Scaffold(
        key: key,
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
            width: MediaQuery.of(context).size.width*.85,
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
            Obx(() {
              return Stack(
                alignment: Alignment.centerRight,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(
                          CartPage());
                    },
                    icon:
                    Icon(Icons.shopping_cart_outlined,color: Colors.white,)
                    ,
                  ),
                  Visibility(
                    visible: logicCart.getCartRsp.value?.data?.cartDetails
                        ?.isNotEmpty == true,
                    child: Positioned(
                      right: 5,
                      bottom: 25,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: XColor.primary
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "${logicCart.getCartRsp.value?.data
                                ?.cartDetails
                                ?.length}",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
            IconButton(
                onPressed: (){
                  key.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.filter_alt_outlined,color: Colors.white,)
            )

          ]
        ),
        endDrawer: const Drawer(
          child: FilterPage(),
        ),
        body: Obx(() {
          if(logic.getSearchRsp.value?.data?.isEmpty??true){
            if(logic.getSearchRsp.value?.data?.length==0){
              return Center(
                child: Text("Sản phẩm không tồn tại",
                style: TextStyle(
                  color: Colors.black
                ),
                ),
              );
            }

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
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 3 / 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Visibility(
                    visible: (logic.getSearchRsp.value?.meta?.perPage ?? 0) <
                        (logic.getSearchRsp.value?.meta?.total ?? 0),
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
