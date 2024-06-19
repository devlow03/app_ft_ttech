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
  Rxn<int>notificationLength = Rxn(0);
  Future<GetNotificationRsp?> getNotification() async {
    getNotificationRp.value =
    await tMartServices.getNotification(perPage: "10");
    saveNotification();
    return getNotificationRp.value;
  }

  

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getNotification();
  }

  void saveNotification()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = getNotificationRp.value?.data;
    List<String>? listId = prefs.getStringList(GlobalData.notificationIdList);
    if((listId?.length??0)<(data?.length??0)){
      notificationLength.value = (data?.length??0) - ((listId?.length??0));
    }
    else{
       notificationLength.value = ((listId?.length??0)) - (data?.length??0);
    }
    List<String>notificationIdList = [];
    
    data?.forEach((e){
      if(listId?.contains(e.id.toString())!=true){
        notificationIdList.add(e.id.toString());
      }
      
    });
    prefs.setStringList(GlobalData.notificationIdList, notificationIdList);
    print(">>>>>>>$notificationIdList");
    print(">>>>>>>list: ${prefs.getStringList(GlobalData.notificationIdList)}");
    // notificationLength.value = prefs.getStringList(GlobalData.notificationIdList)?.length;
    
  }

  void clearNotify()async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(GlobalData.notificationIdList);
    notificationLength.value =0;
    
  }
}
