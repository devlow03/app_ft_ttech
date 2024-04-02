import 'package:app_ft_tmart/src/modules/product_detail/product_rating/product_rating.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/comments/list_image_comments.dart';
import 'package:flutter/material.dart';



class ProductComment extends StatelessWidget {
  final int? itemCount;
  const ProductComment({super.key, this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount??3,
      itemBuilder: (context, index) 
      => Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://plus.unsplash.com/premium_photo-1664461664321-c9b95d47f0a4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8"),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    "Nguyễn Văn A",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ProductRating(
                      isReview: true,
                    ),
                  ),
                   const Text(
                    "Mình nhận đc hàng rồi ạ, hàng đẹp lắm 2 lớp dày dặn chất sờ mềm, mát đg may chắc chắn có túi khóa rất tiện",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black, height: 1.5),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  const ListImageComments(),

                ],
              ),
            )

          ],
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }
}
