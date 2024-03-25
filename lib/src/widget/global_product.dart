import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'global_image.dart';

class GlobalProduct extends StatefulWidget {
  final String? imageLink;
  final String? nameProduct;
  final String?  price;
  final String? defaultPrice;
  final String? numStar;
  final String? shortDes;
  final String? badgesLink;
  // final String? shortDescript;
  const GlobalProduct({
    Key? key,
    this.imageLink,
    this.nameProduct,
    this.price,
    this.shortDes,
    this.numStar,
    this.badgesLink,
    this.defaultPrice,
    // this.shortDescript


  }) : super(key: key);


  @override
  State<GlobalProduct> createState() => _GlobalProductState();
}

class _GlobalProductState extends State<GlobalProduct> {


  @override
  Widget build(BuildContext context) {

    return Container(

      // height: MediaQuery.of(context).size.height*.25,
      // padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width*.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.red),
        border: Border.all(color: Colors.grey.shade200,),
        color: Colors.white,
      ),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Center(
            child: GlobalImage(
              imageUrl:widget.imageLink,
              width: MediaQuery.of(context).size.width*.3,
              height: 150,
              boxFit: BoxFit.contain,

            ),
          ),
          const SizedBox(height: 10,),
          Visibility(
            visible: widget.badgesLink!=null,
            replacement: const Center(),
            child: Column(
              children: [
                const SizedBox(height: 5,),
                GlobalImage(
                  imageUrl: widget.badgesLink,
                  height: 18,
                  width: MediaQuery.of(context).size.width*.2,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
            child: Text(widget.nameProduct??'',
              // textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  height: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                color: Colors.black
                  ),),
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
            child: Row(

              children: [
                Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                Icon(Icons.star,color: Colors.amberAccent,size: 15,)

              ],
            ),
          ),
          Visibility(
            visible: widget.defaultPrice!=null,
            replacement: Center(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(widget.defaultPrice.toString())),
                        style:  TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            decoration:TextDecoration.lineThrough
                        ),)
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(NumberFormat.simpleCurrency(locale: 'vi').format(int.parse(widget.price.toString())),
                  style:  TextStyle(fontSize: 16,color: Colors.redAccent,fontWeight: FontWeight.w600),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

