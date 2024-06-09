import 'dart:convert';

import 'package:app_ft_tmart/src/data/repositories/get_notification_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class NotificationLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<GetNotificationRsp>getNotificationRp = Rxn();

  Future<GetNotificationRsp?> getNotification() async {
    getNotificationRp.value =
    await tMartServices.getNotification(perPage: "10");
    return getNotificationRp.value;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getNotification();
  }
}
