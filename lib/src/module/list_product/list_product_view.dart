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
    logic.getProduct(name: name??"");

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            Get.to(SearchPage());
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),

        ),
        title: Container(
          decoration: BoxDecoration(

          ),
          width: double.infinity,
          height: 40,
          child: TextField(
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
        if(logic.getProductRsp.value?.searchProducts?.isEmpty??true){
          return Center(
            child: CircularProgressIndicator(
              color: XColor.primary,
            ),
          );
        }
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
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 3 / 4.5,
              ),
            ),
          ],
        );
      }),
    );
  }
}
