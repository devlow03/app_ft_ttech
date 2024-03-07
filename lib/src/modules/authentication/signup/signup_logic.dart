import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/repositories/post_check_phone_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/post_check_phone_rsp.dart';
import '../otp/otp_view.dart';

class SignupLogic extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  Rxn<String>verifyId = Rxn();
  Rxn<PostCheckPhoneRsp>postCheckPhoneRsp = Rxn();
  final Services tMartServices = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void>sendOtp()async{
    try{

      if(phoneController.text.startsWith('0')==true){
        String? phone = "+84${phoneController.text.substring(1)}";
        print(">>>>>>>>>$phone");
        await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential)async{
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e){
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            // Update the UI - wait for the user to enter the SMS code
            verifyId.value = verificationId;

          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Auto-resolution timed out...
          },
        );
      }
      Get.to(OtpPage(phoneNumber: phoneController.text,));
    }catch(e){
      Get.back();
      Get.snackbar("Gửi mã xác thực thất bại","Vui lòng thử lại");
    }
  }

  Future<void>postCheckPhone()async{
    postCheckPhoneRsp.value = await tMartServices.postCheckPhoneRsp(body: PostCheckPhoneRqstBodies(
      phone: phoneController.text
    ));
  }

}
