import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:flutter/material.dart';
class LinearRatingView extends StatelessWidget {
  const LinearRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '4.9',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),


                ),
                Text("30 đánh giá",style: TextStyle(color: Colors.black),)
              ],
            ),
          ),
          Expanded(
              flex: 11,
              child: SizedBox(
            width: MediaQuery.of(context).size.width*.5,
            child: Column(
              children: const[
                LinearRatingWidget(text: '12',value: 1.0,itemCount: 5,),
                LinearRatingWidget(text: '5',value: 0.8,itemCount: 4,),
                LinearRatingWidget(text: '4',value: 0.6,itemCount: 3,),
                LinearRatingWidget(text: '2',value: 0.4,itemCount: 2,),
                LinearRatingWidget(text: '0',value: 0.2,itemCount: 1,),
              ],
            ),

          ))
        ],
      ),
    );
  }
}

class LinearRatingWidget extends StatelessWidget {
  final String? text;
  final double value;
  final int itemCount;
  const LinearRatingWidget({
    super.key, this.text, required this.value, required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            flex: 10,
            child: ProductRating(isReview: true,itemCount: itemCount,isLinear: true,)),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 11,
                backgroundColor: Colors.grey.shade200,
                valueColor:  AlwaysStoppedAnimation(XColor.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
            flex: 2,
            child: Text(text??"",
                style: Theme.of(context).textTheme.bodyMedium
            )
        ),
      ],
    );
  }
}
