import 'package:app_ft_tmart/src/data/repositories/get_order_rsp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/xcolor.dart';
import '../../../widget/global_image.dart';
import '../../product/product_view.dart';
import 'order_detail_logic.dart';

class OrderDetailPage extends StatelessWidget {
  final Data? data;
  const OrderDetailPage({Key? key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderDetailLogic());

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            'Thông tin đơn hàng',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          centerTitle: true,
          actions: [
          ],
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_shipping_outlined,
                                color: XColor.primary,),
                              const SizedBox(width: 5,),
                              Text("Thông tin vận chuyển",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,

                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Text("Vận chuyển nội địa",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700
                            ),

                          ),
                          Text(
                              'Giao hàng nhanh',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 1.5
                              )
                          ),


                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Icon(
                    //   size: 18,
                    //   Icons.location_on_outlined,color: XColor.primary,),
                    // SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on, color: XColor.primary,
                                size: 18,),
                              Text("Địa chỉ nhận hàng",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,

                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              const SizedBox(height: 10,),
                              Text("${data
                                  ?.name}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Địa chỉ: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w500,
                                              color: Colors.black
                                          )
                                      ),
                                      TextSpan(
                                        spellOut: true,
                                        text: '${data?.shippingAddress}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            height: 1.5
                                        ),

                                      ),
                                    ]
                                ),
                              ),
                              const SizedBox(height: 10,),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Điện thoại: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w500,
                                              color: Colors.black
                                          )
                                      ),
                                      TextSpan(
                                          text: '${data?.phone}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Colors.black,
                                              height: 1.5
                                          )
                                      )
                                    ]
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
                color: Colors.white,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:data?.orderDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(ProductPage(
                          id:data?.orderDetails?[index]
                              .productId
                              .toString(),

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
                              imageUrl: data?.orderDetails?[index].thumpnailUrl,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data?.orderDetails?[index].productName}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                            "${data?.orderDetails?[index].priceFormated}"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "x${data?.orderDetails?[index].quantity}"),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5),
                                    child: Text(
                                      "Tổng: ${data?.orderDetails?[index].subtotal}",
                                      style: TextStyle(color: Colors.black),
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
                        height: 1,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Colors.grey.shade300,
                      ),
                    );
                  },
                )
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          children: [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.list_alt_outlined,
                                  color: Colors.orangeAccent,)
                            ),
                            TextSpan(
                              text: '  Chi tiết thanh toán',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,

                              ),
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tổng tiền hàng"),
                          Text("${data?.infoTotalAmount?.first.text}",

                          )
                        ],
                      ),
                    ),

                    Visibility(
                      visible:(data?.infoTotalAmount?.length??0)>=3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tổng tiền giảm giá"),
                            Text("${
                                data?.infoTotalAmount?[1].text}")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tổng thanh toán"),
                          Text("${data?.infoTotalAmount?.last.text}",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.monetization_on,
                                      color: Colors.yellow.shade700,)
                                ),
                                TextSpan(
                                  text: '  Phương thức thanh toán',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,

                                  ),
                                )
                              ]
                          ),
                        ),


                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.payments_outlined, color: Colors.green,),
                        const SizedBox(width: 5,),
                        Text("Thanh toán khi nhận hàng")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mã đơn hàng",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        Text("${data?.orderNumber}")


                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Thời gian đặt hàng",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                Text(DateFormat('dd-MM-yyyy').format(data?.orderDate ?? DateTime.now()))

                ],
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8)
                      ),
                      primary: Colors.redAccent
                    ),
                    onPressed: () async {


                      // await logicCart.getCart();
                    },
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 15),
                      child:Text(
                        'Hủy đơn hàng',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ),
            )
        )

    );
  }
}
