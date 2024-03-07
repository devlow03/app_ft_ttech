import 'dart:async';

import 'package:app_ft_tmart/src/modules/authentication/form_sign_up/form_sign_up_view.dart';
import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../signup/signup_logic.dart';

class OtpLogic extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController codeController = TextEditingController();
  final logic = Get.put(SignupLogic());
  Rxn<String>phoneNumber = Rxn();

  Rx<int> seconds = Rx(60);
  Rxn<String>verifyId = Rxn();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> startTimer() async {
     // Thời gian đếm ngược (60 giây)

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (seconds.value > 0) {
        seconds.value--;
        // print('Remaining time: $seconds seconds');
      } else {
        timer.cancel();
        seconds.value=0;
      }
    });
  }

  Future<void>verifyOtp()async{
    Utils.loading(()async{
      try{
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: logic.verifyId.value ?? '',
          smsCode: codeController.text,
        );


          String? phone = "0${phoneNumber.substring(1)}";
          print(">>>>>>>$phone");
          Get.offAll( FormSignUpPage(phoneNumber: phone,credential: credential,) );


      }catch(e){
        Get.back();
        Get.snackbar("Hệ thộng xác thực thất bại","Vui lòng thử lại");
      }
    });
  }
  Future<void>resendOtp(String? phone)async{


      try{
        seconds.value=59;
        await startTimer();
        if(phone?.startsWith('0')==true){
          String? phoneNumber = "+84${phone?.substring(1)}";
          print(">>>>>>>>>$phoneNumber");
          await auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
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
        Fluttertoast.showToast(msg: "Mã xác thực đã được gửi lại");

      }catch(e){
        Get.back();
        Get.snackbar("Gửi mã xác thực thất bại","Vui lòng thử lại");
      }
    }




  @override
  void onReady() async{
    await startTimer();
    // TODO: implement onReady
    super.onReady();
  }
}
