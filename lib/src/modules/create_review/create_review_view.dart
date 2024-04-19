import 'package:app_ft_tmart/src/modules/create_review/take_photo/take_photo_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:app_ft_tmart/src/widget/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/xcolor.dart';
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
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Đánh giá sản phẩm",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: Obx(() {
        final productDetail = Get.put(ProductDetailLogic(Get.find()));
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalImage(
                    height: 100,
                    width: MediaQuery.of(context).size.width * .3,
                    imageUrl: productDetail
                        .getProductByIdRsp.value?.data?.thumpnailUrl,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${productDetail.getProductByIdRsp.value?.data?.productName}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(NumberFormat.simpleCurrency(locale: "VI")
                              .format(productDetail.getProductByIdRsp.value
                                  ?.data?.defaultPrice)),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Mua lại",
                              style: TextStyle(color: Colors.white),
                            ))
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10),
                        //   child: Text(
                        //     "Tổng: ${NumberFormat.simpleCurrency(locale: "VI").format(logic.getCartRsp.value?.data?.cartDetails?[index].total)}",
                        //     style: const TextStyle(color: Colors.black),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Đánh giá của bạn về sản phẩm này",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: RatingBarView(
              itemSize: 50,
              disableRatingChange: false,
              allowHalfRating: false,
              initialRating: 5,
              minRating: 1,
                  onRatingUpdate: (value){
                logic.rating.value = value.toInt();
                  },
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Viết nhận xét của bạn",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: InputDecorationTheme(
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                )),
                child: TextFormField(
                  controller: logic.reviewTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                      hintText: 'Nhận xét của bạn',
                      hintStyle: TextStyle(color: Colors.grey)),
                  minLines: 4,
                  maxLines: 4,
                )),
            const SizedBox(
              height: 20,
            ),
            const TakePhotoPage()
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: XColor.primary,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Gửi đánh giá",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            onPressed: () async {
              await logic.postAddComment();
            },
          )),
    );
  }
}
