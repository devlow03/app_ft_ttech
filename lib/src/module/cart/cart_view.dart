import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'cart_logic.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CartLogic());

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
              onPressed: (){},
              icon: Icon(Icons.search)
          )
        ],
      ),

      body: ListView(
        children: [
          const SizedBox(height: 20,),
          ListView.separated(
            shrinkWrap: true,
              itemCount: 4,
            itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalImage(
                          height: 100,
                          width: MediaQuery.of(context).size.width*.3,
                          imageUrl: 'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2021/09/23/macmoi256.png',
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('MacBook Air M1 13" (8GB/256GB) - Chính hãng Apple Việt Nam',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.2
                              ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  NumberFormat.simpleCurrency(locale: "VI").format(18350000)
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade100
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: (){},
                                            icon: Icon(Icons.remove,size: 10,)
                                        ),
                                        Text('1'),
                                        IconButton(
                                            onPressed: (){},
                                            icon: Icon(Icons.add,size: 10,)
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.shade100
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Icon(Icons.favorite_border_outlined,color: Colors.black,),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.shade100
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Icon(Icons.delete_outline,color: Colors.black,),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
            },
            separatorBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                  ),
                );
            },
          )
        ],
      ),
        bottomNavigationBar: BottomAppBar(
            child:Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(73400000)}",
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
        )
    );
  }
}
