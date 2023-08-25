import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'global_image.dart';

class GlobalProduct extends StatefulWidget {
  final String? imageLink;
  final String? nameProduct;
  final dynamic  price;
  final String? numStar;
  final String? shortDes;
  // final String? shortDescript;
  const GlobalProduct({
    Key? key,
    this.imageLink,
    this.nameProduct,
    this.price,
    this.shortDes,
    this.numStar,
    // this.shortDescript


  }) : super(key: key);


  @override
  State<GlobalProduct> createState() => _GlobalProductState();
}

class _GlobalProductState extends State<GlobalProduct> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width*.2,
      // padding: EdgeInsets.symmetric(vertical: 20),
      // width: MediaQuery.of(context).size.width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: Colors.red),
        // border: Border.all(color: Colors.grey.shade300,),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            Center(
              child: GlobalImage(
                imageUrl:widget.imageLink,
                width: MediaQuery.of(context).size.width*.45,
                height: 150,
                  boxFit:BoxFit.cover
              )
            ),
            const SizedBox(height: 20,),
            Text(widget.nameProduct??'',
              // textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  height: 1,
                  // fontWeight: FontWeight.w500,
                  fontSize: 15,
                color: Colors.black
                  ),),
            const SizedBox(height: 5,),
            Visibility(
                visible: widget.shortDes!='',
                child:Column(
                  children: [
                    Text(
                      widget.shortDes??'',
                      style: const TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,),
                    const SizedBox(height: 5,),
                  ],
                )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(NumberFormat.simpleCurrency(locale: 'vi').format(double.parse(widget.price)),
                  style:  TextStyle(fontSize: 14,color: Colors.grey),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

