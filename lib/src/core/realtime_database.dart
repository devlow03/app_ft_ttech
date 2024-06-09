// import 'dart:convert';

// import 'package:app_ft_tmart/src/core/global_data.dart';
// import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
// import 'package:dio/dio.dart' as DIO;
// import 'package:firebase_database/firebase_database.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class RealTimeDataBase extends GetxController {
//   FirebaseDatabase database = FirebaseDatabase.instance;

//   Rxn<Map<dynamic, dynamic>> data = Rxn();
//   final DIO.Dio dio;

//   RealTimeDataBase(this.dio);

//   @override
//   onReady() async {
//     super.onReady();
//     pushNotifyOnChilAdded();
//     // pushNotifyOnChilChanged();
//     // pushNotifyOnValue();
//   }

//   Future<void> addData(
//       {int? orderId,
//       int? productId,
//       required String? title,
//       required String? content,
//       required String? image}) async {
//     // ignore: unused_local_variable
//     final createdTime =
//         DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();

//     DatabaseReference notifyList =
//         FirebaseDatabase.instance.ref("notifications");
//     if (sharedPreferences.getString(GlobalData.userIdNotify) != null) {
//       String? userId = sharedPreferences.getString(GlobalData.userIdNotify);
//       DatabaseReference userNotificationsRef = notifyList.child(userId ?? "");
//       DatabaseReference newNotifyRef = userNotificationsRef.push();

//       newNotifyRef.set({
//         "orderId": orderId,
//         "productId": productId,
//         "title": title,
//         "content": content,
//         "image": image,
//         "createdTime": createdTime,
//       });
//       sharedPreferences.setString(
//           GlobalData.notifyChildKey, newNotifyRef.key ?? "");
//       await pushNotifyOnChilAdded();
//     } else {
//       String? userId = Uuid().v4();
//       sharedPreferences.setString(GlobalData.userIdNotify, userId);
//       // Tạo một nút con mới dựa trên userId
//       DatabaseReference userNotificationsRef = notifyList.child(userId);

//       // Tạo một nút con mới cho thông báo
//       DatabaseReference newNotifyRef = userNotificationsRef.push();

//       newNotifyRef.set({
//         "orderId": orderId,
//         "productId": productId,
//         "title": title,
//         "content": content,
//         "image": image,
//         "createdTime": createdTime,
//       });
//       sharedPreferences.setString(
//           GlobalData.notifyChildKey, newNotifyRef.key ?? "");
//       await pushNotifyOnChilAdded();
//     }
//   }

//   Future<void> pushNotifyOnChilAdded() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     String? userId = sharedPreferences.getString(GlobalData.userIdNotify);
//     String? notifyChildKey =
//         sharedPreferences.getString(GlobalData.notifyChildKey);

//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     DatabaseReference notifyList =
//         FirebaseDatabase.instance.ref("notifications");
//     DatabaseReference userNotificationsRef = notifyList.child(userId ?? "");

    

//     userNotificationsRef.orderByKey().limitToLast(1).once().then((event)async{
//        Map dataList = event.snapshot.value as Map;
//        final String? key = dataList.keys.first;
//        final data = dataList[key];
//       print(">>>>>>>>>>>>>>>>>>onAdd:${jsonEncode(data)}");
     
//       if(data["title"]!=null){
//         await postPushNotify(
//           title: data["title"].toString(),
//           content: data["content"].toString(),
//           image: data["image"].toString(),
//           orderId: data["orderId"].toString(),
//           productId: data["productId"].toString());
    
//       }
//     });
//   }

//   Future<void> pushNotifyOnValue() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     String? userId = sharedPreferences.getString(GlobalData.userIdNotify);
//     String? notifyChildKey =
//         sharedPreferences.getString(GlobalData.notifyChildKey);

//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     DatabaseReference notifyList =
//         FirebaseDatabase.instance.ref("notifications");
//     DatabaseReference userNotificationsRef = notifyList.child(userId ?? "");

//     userNotificationsRef.onValue.listen((event) async {
//       Map dataList = event.snapshot.value as Map;
//        final String? key = dataList.keys.first;
//        final data = dataList[key];
//       if(data["title"]!=null){
//         await postPushNotify(
//           title: data["title"].toString(),
//           content: data["content"].toString(),
//           image: data["image"].toString(),
//           orderId: data["orderId"].toString(),
//           productId: data["productId"].toString());
    
//       }
//       });
//   }



//   Future<void> postPushNotify(
//       {required String? title,
//       required String content,
//       required String? image,
//       String? orderId,
//       String? productId}) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final body = {
//       "to": "${prefs.getString(GlobalData.fCmToken)}",
//       "notification": {"title": title, "body": content, "image": image},
//       "data": {"orderId": orderId, "product_id": productId}
//     };

//     final jsonBody = jsonEncode(body);
//     print(">>>>>>>>>>>>>>>>>>>>body:${jsonBody}");

//     dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
//     // Thực hiện POST request
//     final response = await dio.post(
//       'https://fcm.googleapis.com/fcm/send',
//       options: DIO.Options(
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': GlobalData.fCmServerKey,
//         },
//       ),
//       data: jsonBody,
//     );
//   }
// }
