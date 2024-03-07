import 'dart:io';

import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/repositories/put_update_user_rqst.dart';
import '../profile_logic.dart';
import 'pick_image/pick_image_logic.dart';
import 'package:intl/intl.dart';

class ProfileDetailLogic extends GetxController{
  final logicProfile = Get.put(ProfileLogic());
  final Services tMartServices = Get.find();
  TextEditingController fullNameController  = TextEditingController();
  TextEditingController emailController  = TextEditingController();
  TextEditingController phoneController  = TextEditingController();
  TextEditingController idController  = TextEditingController();
  TextEditingController birthdayController  = TextEditingController();
  TextEditingController userNameController  = TextEditingController();
   final pickImage = Get.put(PickImageLogic());
   Rxn<String>networkImage = Rxn();
   Rxn<bool?>readOnly = Rxn(true);
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await logicProfile.getUserProfile();

    setProfile();
    setImage();

  }

  void setProfile(){
    final data = logicProfile.getUserProfileRsp.value?.data;
    idController.text = "KH${data?.id}";
    fullNameController.text = data?.fullName??"";
    phoneController.text = data?.phone??"";
    emailController.text = data?.email??"";
    birthdayController.text = data?.birthday??"";
    userNameController.text = data?.username??"";
    print(">>>>>>>>>>>>>>>>${data?.fullName??""}");
    // readOnly.value = true;

    
  
  }

  void postUpdateAvatar()async{
    Utils.loading(()async{
      await pickImage.selectImage();
      await tMartServices.uploadImage(pickImage.image.value!);
      await logicProfile.getUserProfile();
      logicProfile.onReady();
      Get.back();
      Fluttertoast.showToast(msg: "Cập nhật ảnh đại diện thành công");
    });
  }

  void setImage(){
    if(logicProfile.getUserProfileRsp.value?.data?.avatar!=null){
      networkImage.value = logicProfile.getUserProfileRsp.value?.data?.avatar??"";
    }
    else{
      networkImage.value = "https://cdn-icons-png.flaticon.com/128/3033/3033143.png";
    }
  }

  final Rxn<DateTime?> selectedDate = Rxn<DateTime?>();
  Future<void>selectDate(BuildContext context)async{
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      final formatter = DateFormat('d/M/y');
      final formattedDate = formatter.format(selectedDate.value!);
      birthdayController.text = formattedDate;
    }



  }

  Future<void>putUpdateUser()async{
    final String? birthdayString = logicProfile.getUserProfileRsp.value?.data?.birthday;
    print(">>>>>>>>>>>>>>$birthdayString");

    final birthday = DateFormat("M/d/y").format(convertStringToDate(birthdayString ?? ""));
    print("Formatted Date: $birthday");
    // final dateApi = DateFormat('M/d/y').format();
    // print(">>>>>>>>>>>dateApi: ${dateApi}");
     Utils.loading(()async{
      await tMartServices.putUpdateUser(
        body: PutUpdateUserRqst(
          fullName: fullNameController.text,
          birthday: selectedDate.value!=null?DateFormat('M/d/y').format(selectedDate.value!):birthdayString,
          phone: phoneController.text,
          email: emailController.text
        )
      );
      readOnly.value = true;
      await logicProfile.getUserProfile();
      Get.back();
      Fluttertoast.showToast(msg: "Cập nhật thông tin thành công");
     });
  }

  DateTime convertStringToDate(String dateString) {
    List<String> parts = dateString.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }


}