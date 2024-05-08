import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
    
class CommentDetails extends StatelessWidget {

  const CommentDetails({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
     final logic = Get.put(ProductDetailLogic(Get.find()));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
         backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Get.back() ,
        ),
        title: const Text(''),
      ),
      body:Obx(() {
  return PageView(
    scrollDirection: Axis.vertical,
    physics: const AlwaysScrollableScrollPhysics(),
    children: logic.getCommentRsp.value?.data?.map((data) {
      return CarouselSlider.builder(
        
        itemCount: data.imageUrl?.length ?? 0,
        itemBuilder: (context, index, realIndex) {
          final images = data.imageUrl?[index];
          return GlobalImage(

            imageUrl: images,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            boxFit: BoxFit.cover,
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: false,
          aspectRatio: 10/9,
          viewportFraction: 1,
        ),
      );
    }).toList() ?? [],
  );
})

    );
  }
}