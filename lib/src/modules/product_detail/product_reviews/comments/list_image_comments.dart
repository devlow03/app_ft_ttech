import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/product_comment.dart';
import 'package:flutter/material.dart';

class ListImageComments extends StatelessWidget {
  const ListImageComments({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context,index)=>ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network("https://plus.unsplash.com/premium_photo-1681139760816-d0c39952f9ac?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNnx8fGVufDB8fHx8fA%3D%3D",
            width: MediaQuery.of(context).size.width*.25,
            height: 50,
            fit: BoxFit.cover,

          ),
        ),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 6 / 5,
      ),
    );
  }
}