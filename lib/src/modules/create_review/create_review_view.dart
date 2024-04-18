import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_review_logic.dart';

class CreateReviewPage extends StatelessWidget {

  const CreateReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CreateReviewLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){

            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Đánh giá sản phẩm",style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),),

        actions: [



        ],
      ),
    );
  }
}
