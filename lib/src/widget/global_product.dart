import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/widget/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import 'global_image.dart';

class GlobalProduct extends StatelessWidget {
  final String? imageLink;
  final String? nameProduct;
  final String? price;
  final String? defaultPrice;
  final double? rating;
  final String? shortDes;
  final String? badgesLink;
  final bool? isFavorites;
  final String? productId;
   final void Function()? onAddCart;
  // final String? shortDescript;
  const GlobalProduct({
    Key? key,
    this.imageLink,
    this.nameProduct,
    this.price,
    this.shortDes,
    this.badgesLink,
    this.defaultPrice,
    this.rating, this.onAddCart, this.isFavorites, this.productId,
    // this.shortDescript
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Get.put(CartLogic());
    return Container(
      // height: MediaQuery.of(context).size.height*.25,
      // padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.red),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GlobalImage(
                  imageUrl: imageLink,
                  width: MediaQuery.of(context).size.width * .3,
                  height: 150,
                  boxFit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: badgesLink != null,
                replacement: const Center(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    GlobalImage(
                      imageUrl: badgesLink,
                      height: 18,
                      width: MediaQuery.of(context).size.width * .2,
                      // boxFit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              // Image.network(
              //   widget.badgesLink??"",

              //   height: 10,
              //   fit: BoxFit.cover,
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Text(
                  nameProduct ?? '',
                  // textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),

              // Visibility(
              //     visible: widget.shortDes!='',
              //     child:Column(
              //       children: [
              //         Text(
              //           widget.shortDes??'',
              //           style: const TextStyle(fontSize: 12,
              //             fontWeight: FontWeight.w300,
              //           ),
              //           maxLines: 1,),
              //         const SizedBox(height: 5,),
              //       ],
              //     )
              // ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: RatingBarView(
                    initialRating: rating ?? 0,
                    minRating: rating ?? 0,
                  )),
              Visibility(
                visible: defaultPrice != null,
                replacement: const Center(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            NumberFormat.simpleCurrency(locale: 'vi').format(
                                int.parse(defaultPrice.toString())),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(locale: 'vi')
                          .format(int.parse(price.toString())),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffD92A1C),
                          fontWeight: FontWeight.w400),
                    ),

                    InkWell(
                      onTap: ()async{
                        await cart.postAddCart(
                          productId: productId??"",
                           quantity: "1"
                           );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: XColor.primary,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
              right: 5,
              top: 5,
              child: Visibility(
                visible: isFavorites==true,
                replacement: const Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.favorite,
                  color: XColor.primary,
                ),
              ))
        ],
      ),
    );
  }
}
