import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/global_product.dart';
import '../product/product_view.dart';
import 'list_product_logic.dart';

class List_productPage extends StatelessWidget {
  final String? id;
  final String? name;

  const List_productPage({Key? key, this.id,  this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(List_productLogic(Get.find()));
    logic.keyController.text=name??"";
    logic.getProduct(name: name??"");

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
              logic.getProduct(name: value);
            },
            onSubmitted: (value){
              logic.getProduct(name: value);
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
      body: Obx(() {
        return ListView(
          children: [
            const SizedBox(height: 10,),
            GridView.builder(
              shrinkWrap: true,
              itemCount: logic.getProductRsp.value?.searchProducts?.length ?? 0,
              physics:
              const NeverScrollableScrollPhysics(),
              itemBuilder: (context, ind) {
                return InkWell(
                  onTap: () {
                    // Get.to(Product_detailPage(data: snapshot.data?.searchProducts?[ind]));
                    // Get.to(ProductPage(
                    //   data: logic.getProductRsp.value?.searchProducts?[ind],
                    // ));
                  },
                  child: GlobalProduct(
                    imageLink: logic.getProductRsp.value?.searchProducts?[ind]
                        .imgLink,
                    shortDes: logic.getProductRsp.value?.searchProducts?[ind]
                        .shortDes,
                    // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                    price:
                    '${ logic.getProductRsp.value?.searchProducts?[ind].price}',
                    nameProduct:
                    logic.getProductRsp.value?.searchProducts?[ind].name,
                    numStar: '5.0',
                  ),
                );
              },
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4.5,
              ),
            ),
          ],
        );
      }),
    );
  }
}
