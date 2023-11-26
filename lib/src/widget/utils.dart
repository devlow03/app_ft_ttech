import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../core/xcolor.dart';

class Utils{
   Utils._();

   static Future<void> loading(Function onLoading) async {

     try {
       Get.dialog(
         AlertDialog(
           contentPadding: EdgeInsets.zero, // Loại bỏ khoảng trắng xung quanh nội dung
           icon: Center(
             child: CircularProgressIndicator(
               color: XColor.primary,
               strokeWidth: 2,
             ),
           ),
           title:  Text(
             "Đang tải",
             style: TextStyle(),
             textAlign: TextAlign.center,
           ),
         ),
       );
       await onLoading();
       Get.back();
     } catch (e) {
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
                       icon: Icon(Icons.error,color: Colors.red,size: 35,),
                       title: Text(
                         "${errorMessage}",
                         style: TextStyle(),
                         textAlign: TextAlign.center,
                       ),
                       actions: [
                         ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: XColor.primary
                            ),
                             onPressed: (){
                               Get.back();
                             },
                             child: Text("Xác nhận")
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
   }

}