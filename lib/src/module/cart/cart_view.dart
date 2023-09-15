import 'package:app_ft_tmart/src/module/product/product_view.dart';
import 'package:app_ft_tmart/src/module/search/search_view.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/xcolor.dart';
import 'cart_logic.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic(Get.find()));
    logic.getCart();
    print(">>>>>>>>>>>>>>>${logic.getCartRsp.value?.data?.cartDetails?.length??0}");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text('Giỏ hàng',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(SearchPage());
                },
                icon: Icon(Icons.search)
            )
          ],
        ),

        body: Obx(() {
          return ListView(
              children: [
                const SizedBox(height: 20,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: logic.getCartRsp.value?.data
                      ?.cartDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Get.to(ProductPage(
                            id:  logic.getCartRsp.value?.data
                            ?.cartDetails?[index].productId.toString(),
                          categoryId: logic.getCartRsp.value?.data
                              ?.cartDetails?[index].categoryId.toString(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalImage(
                              height: 100,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .3,
                              imageUrl: logic.getCartRsp.value?.data
                                  ?.cartDetails?[index].thumpnailUrl,
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${logic.getCartRsp.value?.data
                                      ?.cartDetails?[index].productName}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        "${NumberFormat.simpleCurrency(
                                            locale: "VI")
                                            .format(logic.getCartRsp.value?.data
                                            ?.cartDetails?[index].price)}"
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(
                                                5),
                                            color: Colors.grey.shade100
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async{
                                                  print(">>>>>>>>>>>>>>>>>>A");
                                                  int? quantity =int.parse(( (logic.getCartRsp.value?.data
                                                      ?.cartDetails?[index].quantity).toString()))-1;
                                                  print(">>>>>>>>>>>>>>>>>>${quantity}");
                                                  if(quantity>=1){
                                                    await logic.updateCartDetail(
                                                        idCart: logic.getCartRsp.value?.data
                                                            ?.cartDetails?[index].id.toString()??"",
                                                        quantity: quantity
                                                    );
                                                    await logic.getCart();
                                                  }
                                                  else{
                                                    await logic.deleteCart(idCart: logic.getCartRsp.value?.data
                                                        ?.cartDetails?[index].id.toString()??"");

                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove, size: 10,)
                                            ),
                                            Text("${logic.getCartRsp.value?.data
                                                ?.cartDetails?[index].quantity}"),
                                            IconButton(
                                                onPressed: () async{
                                                  print(">>>>>>>>>>>>>>>>>>A");
                                                  int? quantity =int.parse(( (logic.getCartRsp.value?.data
                                                      ?.cartDetails?[index].quantity).toString()))+1;
                                                  print(">>>>>>>>>>>>>>>>>>${quantity}");
                                                  if(quantity>=1){
                                                    await logic.updateCartDetail(
                                                        idCart: logic.getCartRsp.value?.data
                                                            ?.cartDetails?[index].id.toString()??"",
                                                        quantity: quantity
                                                    );

                                                  }
                                                },
                                                icon: Icon(Icons.add, size: 10,)
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(
                                                5),
                                            color: Colors.grey.shade100
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.black,),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      InkWell(
                                        onTap: ()async{
                                          await logic.deleteCart(idCart: logic.getCartRsp.value?.data
                                              ?.cartDetails?[index].id.toString()??"");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius: BorderRadius.circular(
                                                  5),
                                              color: Colors.grey.shade100
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Icon(Icons.delete_outline,
                                              color: Colors.black,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      "Tổng: ${NumberFormat.simpleCurrency(
                                          locale: "VI")
                                          .format(logic.getCartRsp.value?.data
                                          ?.cartDetails?[index].total)}",
                                      style: TextStyle(
                                          color: Colors.redAccent
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 2,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Colors.grey.shade300,
                      ),
                    );
                  },
                )
              ],
            );
        }),
        bottomNavigationBar: Obx(() {
          return Visibility(
            visible: (logic.getCartRsp.value?.data?.cartDetails?.length??0)>=1,
            replacement:  Center(
              child: Visibility(
                visible: logic.getCartRsp.value?.data?.cartDetails?.isEmpty??true,
                child: Center(
                  child: Text("Không có sản phẩm nào"),
                ),
                replacement: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: XColor.primary,
                    ),
                    const SizedBox(height: 10,),
                    Text("Đang tải",style: TextStyle(
                        color: Colors.black
                    ),)
                  ],
                ),
              ),
            ),
            child: BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(
                            (logic.getCartRsp.value?.data?.info?[1].value)??0)}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .5,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),

                            ),
                            onPressed: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text('Mua hàng',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        })
    );
  }
}
