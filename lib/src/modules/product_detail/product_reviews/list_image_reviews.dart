import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:flutter/material.dart';

class ListImageReviews extends StatelessWidget {
  const ListImageReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context,index)=>ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network("https://plus.unsplash.com/premium_photo-1669312747277-b1acd3eb2f98?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
                width: MediaQuery.of(context).size.width*.25,
                  height: 50,
                  fit: BoxFit.fill,

                ),

              ),
              separatorBuilder: (context,index)=>const SizedBox(width: 10,),
              ),
        ),

      ],
    );
  }
}
