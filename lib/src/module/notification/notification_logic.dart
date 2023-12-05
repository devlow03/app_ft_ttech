import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class NotificationLogic extends GetxController {
  @override
  void onReady() async {
    // TODO: implement onReady
    await getNotifications();
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  RxList<Map<String, dynamic>> dataNotification = <Map<String, dynamic>>[].obs;

  Future<void> getNotifications() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString(GlobalData.userIdNotify);
    DatabaseReference notifyList =
        FirebaseDatabase.instance.ref("notifications");
    DatabaseReference userNotificationsRef = notifyList.child(userId ?? "");

    userNotificationsRef.onValue.listen((event) {
      print(">>>>>>>>>${jsonEncode(event.snapshot.value)}");
      if (event.snapshot.value != null &&
          event.snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;

        // Chuyển đổi dữ liệu thành List<Map<String, dynamic>>
        List<Map<String, dynamic>> dataList = [];
        data.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            dataList.add(Map<String, dynamic>.from(value));
          }
        });

        // Cập nhật giá trị cho biến dataNotification
        dataNotification.assignAll(dataList);
        print(">>>>>>>>>${jsonEncode(dataNotification)}");
      }
    });
  }

  Future<void>deleteNotification()async{
     final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString(GlobalData.userIdNotify);
    DatabaseReference notifyList =
        FirebaseDatabase.instance.ref("notifications");
    DatabaseReference userNotificationsRef = notifyList.child(userId ?? "");
    
    await userNotificationsRef.remove();
    dataNotification.clear();
    Fluttertoast.showToast(msg: "Đã xóa tất cả thông báo");
    
  }
}
