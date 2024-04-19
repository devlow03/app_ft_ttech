import 'dart:convert';
import 'dart:io';

import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/data/repositories/post_add_comment_rqst.dart';
import 'package:app_ft_tmart/src/data/repositories/post_upload_file_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/create_review/take_photo/take_photo_logic.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_detail/profile_detail_logic.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart'as DIO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';

class CreateReviewLogic extends GetxController {
  final logicPhoto = Get.put(TakePhotoLogic());
  Rxn<PostUploadFileRsp>postUploadFileRsp = Rxn();
  RxList listImage = RxList();
  final Services tMartServices = Get.find();
  Rxn<int>rating = Rxn(5);
  Map<String, String> imageUrlData = {};
  TextEditingController reviewTextController = TextEditingController();


  Future<void>uploadImageToFirebase(File imageFile,String filename )async{
    final productDetail = Get.put(ProductDetailLogic(Get.find()));
    String productId = productDetail.productId.value??"";
    final DIO.Dio dio = DIO.Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(
        printOnSuccess: true
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    DIO.FormData formData = DIO.FormData.fromMap({
      "file": await DIO.MultipartFile.fromFile(imageFile.path),

    });
    final response = await dio.post("https://firebasestorage.googleapis.com/v0/b/appfttmart-3c6e3.appspot.com/o?uploadType=media&name=comments/$productId/$filename.png",
    data: formData
    );
    if (response.data is Map<String, dynamic>) {
      postUploadFileRsp.value = PostUploadFileRsp.fromJson(response.data as Map<String, dynamic>);
    } else {

      return;
    }
  }



  Future<void>postAddComment()async{
    final productDetail = Get.put(ProductDetailLogic(Get.find()));
    Utils.loading(()async{
      for(var i =0; i< logicPhoto.images.length;i++){
        var uuid = const Uuid();
        String fileName = uuid.v1();
        String productId = productDetail.productId.value??"";
        await uploadImageToFirebase(logicPhoto.images[i]!,fileName);
        String imageUrl = "${GlobalData.firebaseStorageUrl}/comments%2F$productId%2F$fileName.png?alt=media&token=${postUploadFileRsp.value?.downloadTokens}";
        listImage.add(imageUrl);


      }
      setMapImage();

      await tMartServices.postAddComment(bodies: PostAddCommentRqst(
          rating: rating.value??0,
          imageUrl:imageUrlData,
          text: reviewTextController.text,
          parentId: "",
          productId: int.parse(productDetail.productId.value??""),
          test: true


      ));
      listImage.clear();
      imageUrlData.clear();
      Fluttertoast.showToast(msg: "Gửi đánh giá thành công");
      Get.back();
      Get.back();




    });
    await productDetail.getComment();
    await productDetail.getProductById();
  }

  setMapImage(){
    int index = 1;
    for (var imageUrl in listImage){
      imageUrlData[index.toString()] = imageUrl;
      index++;
    }
    if (kDebugMode) {
      print(imageUrlData);
    }
  }
}
