import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/put_change_password_rqst.dart';
import '../../../../data/services/service.dart';

class ResetPasswordLogic extends GetxController{
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   final Services tMartServices = Get.find();
  
  Future<void>putChangePassword()async{
    Utils.loading(()async{
      await tMartServices.putChangePassword(
        body: PutChangePasswordRqst(
          password: oldPasswordController.text,
          newPassword: passwordController.text,
          passwordNewConfirmation: rePasswordController.text
        )
      );
      Fluttertoast.showToast(msg: "Đổi mật khẩu thành công");
      Get.back();
      Get.back();
    });
  }
   
}