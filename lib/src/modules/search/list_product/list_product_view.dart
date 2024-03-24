import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/search/list_product/filter/filter_logic.dart';
import 'package:app_ft_tmart/src/modules/search/list_product/filter/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../widget/global_product.dart';
import '../../cart/cart_logic.dart';
import '../../cart/cart_view.dart';
import '../../product_detail/product_detail_view.dart';
import '../search_logic.dart';
import '../search_view.dart';
import 'list_product_logic.dart';

class ListProductDetailPage extends StatelessWidget {


  const ListProductDetailPage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final logicCart = Get.put(CartLogic());
    final logic = Get.put(SearchLogic());
    final logicFilter = Get.put(FilterLogic());
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    // logic.getSearch(name: name??"");



    return WillPopScope(
      onWillPop: logic.onWillPop,
      child: Scaffold(
        key: key,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
            automaticallyImplyLeading: false,

            // backgroundColor: Colors.grey.shade200,
            leading: IconButton(
              onPressed: () {

                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: XColor.primary,),

            ),
            title: Container(
              decoration: BoxDecoration(

              ),
              width: MediaQuery.of(context).size.width*.85,
              height: 45,
              child: TextField(
                autofocus: false,
                controller: logic.keyController,
                readOnly: true,
                onTap: () {
                  Get.to(const SearchPage());
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
                        color: XColor.primary,
                        width: 2
                    ),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: XColor.primary,
                        width: 2
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: XColor.primary,
                        width: 2
                    ),
                  ),

                ),
              ),
            ),

            actions:[

              InkWell(
                onTap: ()=>key.currentState?.openEndDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.filter_alt_outlined,color: XColor.primary),
                      Text('Lọc',style: TextStyle(color:XColor.primary),)
                    ],
                  ),
                ),
              )

            ]
        ),
        endDrawer: const Drawer(
          child: FilterPage(),
        ),
        body: Obx(() {

          if(logic.getSearchRsp.value?.data?.isEmpty==true){
            if((logic.getSearchRsp.value?.data?.length??0)<1){
              return Center(
                child: Text("Sản phẩm không tồn tại",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              );
            }
            else{
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
                            Get.to(ProductDetailPage(
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
                        child: SpinKitCircle(size: 40,
                          color: Colors.grey,
                        )
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