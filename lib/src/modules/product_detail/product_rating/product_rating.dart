import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
   bool? isReview = false;
   bool? isLinear;
   int? itemCount = 5;

   ProductRating({super.key, this.isReview,this.itemCount,this.isLinear});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isLinear==true?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount??5,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.orange,
              size: 20,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 2,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),

         Visibility(
           visible:isReview!=true,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               const Text(
                 "4.9",
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
