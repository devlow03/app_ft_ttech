import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_icon/cart_icon.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_view.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
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
  final String? keyword;

  const ListProductDetailPage({Key? key, this.keyword, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final logicCart = Get.put(CartLogic());
    final logic = Get.put(SearchLogic());

    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    // logic.getSearch(name: name??"");



    return WillPopScope(
      onWillPop: logic.onWillPop,
      child: Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.grey.shade200,
            leading: IconButton(
              onPressed: () {

                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black,),

            ),
            title: Text(keyword??logic.keyController.text,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            // centerTitle: true,

            actions:[
              IconButton(
                onPressed: () {
                  Get.to(
                      const SearchPage());
                },
                icon:
                const Icon(Icons.search,color: Colors.black,)
                ,
              ),
              CartIcon(),
              IconButton(
                  onPressed: ()=>Get.offAll(IndexPage()),
                  icon: const Icon(Icons.home_outlined,color: Colors.black,)
              )

            ]
        ),
        // endDrawer: const Drawer(
        //   child: FilterPage(),
        // ),
        body: Stack(
          children: [
            Obx(() {

              if(logic.getSearchRsp.value?.data?.isEmpty==true){
                if((logic.getSearchRsp.value?.data?.length??0)<1){
                  return const Center(
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
                        const Text("Đang tải")
                      ],
                    ),
                  );
                }



              }
              return Visibility(
                replacement: LinearProgressIndicator(

                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(XColor.primary),
                ),
                visible: logic.getSearchRsp.value?.data!=null,
                child: RefreshIndicator(
        color: XColor.primary,
                  onRefresh: ()async{
                    logic.getSearch(
                        keyword: logic.logic.keyword.value,
                        brand: logic.logic.selectedCategoryTypes,
                        category: logic.logic.selectedCategoryTypes,
                        price: logic.logic.selectedPriceRange

                    );
                  },
                  child: ListView(
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
                                    rating: double.parse(logic.getSearchRsp.value?.data?[ind].averageRating??""),
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
                            replacement: const Center(),
                            child: const Center(
                                child: SpinKitCircle(size: 40,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          const SizedBox(height: 80,),

                          // TextButton(
                          //     onPressed: (){
                          //       print(">>>>>>>>>>>>>>>>>>>${logic.isLoading.value}");
                          //     },
                          //     child: Text('a')
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            FilterPage()
          ],
        )

      ),
    );
  }
}