import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../core/xcolor.dart';

class Utils{
   Utils._();

   static Future<void> loading(Function onLoading, {Function? onSuccess}) async {

    try {
    Get.dialog(
      SpinKitRing(
        size: 60,
        color: Colors.white,
      ),
    );

    await onLoading();
    if (onSuccess != null) {
      onSuccess();
    }

    
  } catch (e) {
      // Get.back();
       if (e is DioError) {
         if (e.response != null && e.response!.data is Map) {
           // Trích xuất thông báo lỗi từ phản hồi
           final errorData = e.response!.data as Map<String, dynamic>;
           final error = errorData['error'];
           if (error != null) {
             final errorObject = error['errors'];
             if (errorObject != null) {
               final errorMessage = errorObject['msg'];
               if (errorMessage != null) {
                 Get.back();
                 // Hiển thị thông báo lỗi lên giao diện
                 Get.dialog(

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: AlertDialog(
                       icon: Icon(Icons.error,color: Colors.red,size: 50,),
                       title: Text(
                         "$errorMessage",
                         style: TextStyle(
                           fontSize: 14
                         ),
                         textAlign: TextAlign.center,
                       ),
                       actions: [
                         ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: XColor.primary
                            ),
                             onPressed: (){
                               Get.back();
                             },
                             child: Text("Xác nhận",style: TextStyle(color: Colors.white),)
                         )
                       ],
                     ),
                   ),
                 );
               }
             }
           }
         }
       }
     }
    //  finally{
    //   Get.back();
    //  }
   }

}