import 'package:app_ft_tmart/src/modules/cart/cart_icon/cart_icon.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_view.dart';
import 'package:app_ft_tmart/src/modules/filter/sort_and_filter.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../core/xcolor.dart';
import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';

import 'all_product_by_category_logic.dart';

class AllProductByCategoryPage extends StatelessWidget {
  final int? id;
  final String? categoryName;
  final int? idBrand;
  final String? keyword;


  const AllProductByCategoryPage(
      {Key? key, this.id, this.categoryName, this.idBrand, this.keyword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AllProductByCategoryLogic());
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    final logicCart = Get.put(CartLogic());
    logic.idCategory.value = id;
    logic.idBrand.value = idBrand;
    logic.keyword.value = keyword;
    logic.getProductCategory();

    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        key: key,
        appBar: AppBar(

            backgroundColor: Colors.grey.shade50,
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.grey.shade200,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Visibility(
              visible: categoryName!=null,
              replacement:  Text(
                keyword ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              child: Text(
                categoryName ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            // centerTitle: true,

            actions: [
              IconButton(
                onPressed: () {
                  Get.to(const SearchPage());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              CartIcon(),
              // IconButton(
              //     onPressed: ()=>Get.offAll(IndexPage()),
              //     icon: const Icon(Icons.home_outlined,color: Colors.black,)
              // ),

            ],
          bottom:SortAndFilterWidget(isCategory:true,allCategoryLogic: logic,)

        ),
        body: Obx(() {
          if (logic.getProductByCategory.value?.data?.isEmpty == true) {
            return const Center(
              child: Text(
                "Sản phẩm không tồn tại",
                style: TextStyle(color: Colors.black),
              ),
            );
          }
          return Visibility(
            replacement: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(XColor.primary),
            ),
            visible:
                logic.getProductByCategory.value?.data?.isNotEmpty == true,
            child: ListView(
              controller: logic.controller,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: logic
                                .getProductByCategory.value?.data?.length ??
                            0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, ind) {
                          logic.indexPage.value = ind;
                          final data =
                              logic.getProductByCategory.value?.data?[ind];
                          return GlobalProduct(
                            productId: data?.id.toString(),
                            imageLink: data?.thumpnailUrl,
                            defaultPrice: '${data?.defaultPrice}',
                            // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                            price: '${data?.price}',
                            nameProduct: data?.productName,
                            rating:
                                double.parse(data?.averageRating ?? ""),
                            isFavorites: data?.favorite,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: (logic.getProductByCategory.value?.meta
                                  ?.perPage ??
                              0) <
                          (logic.getProductByCategory.value?.meta?.total ??
                              0),
                      replacement: const Center(),
                      child: const Center(
                          child: SpinKitCircle(
                        size: 40,
                        color: Colors.grey,
                      )),
                    ),
                    const SizedBox(
                      height: 80,
                    ),

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
          );
        }));
  }
}
