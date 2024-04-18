import 'package:app_ft_tmart/src/widget/rating_bar.dart';
import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
   bool? isReview = false;
   bool? isLinear;
   int? itemCount = 5;
   final double? initialRating;
   final double? minRating;
   final String? ratingText;

   ProductRating({super.key, this.isReview,this.itemCount,this.isLinear, this.initialRating, this.minRating, this.ratingText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isLinear==true?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        RatingBarView(initialRating: initialRating,minRating: minRating,itemCount: itemCount,),
        const SizedBox(
          width: 5,
        ),

         Visibility(
           visible:isReview!=true,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Text(
                 ratingText??"",
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                     fontSize: 14
                 ),
               ),
               const SizedBox(
                 width: 5,
               ),
               Text(
                "(20 views)",
                style: TextStyle(color: Colors.grey),
        ),
             ],
           ),
         )
      ],
    );
  }
}
