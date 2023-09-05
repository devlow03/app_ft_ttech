import 'dart:async';

import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../signup/signup_logic.dart';

class OtpLogic extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController codeController = TextEditingController();
  final logic = Get.put(SignupLogic());
  Rxn<String>phoneNumber = Rxn();
  Rx<int> seconds = Rx(60);
  Rxn<String>verifyId = Rxn();

  Future<void> startTimer() async {
     // Thời gian đếm ngược (60 giây)

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (seconds.value > 0) {
        seconds.value--;
        print('Remaining time: $seconds seconds');
      } else {
        timer.cancel();
        seconds.value=0;
      }
    });
  }

  Future<void>verifyOtp()async{
    if (codeController.text.isEmpty) {
      Get.snackbar('Thông báo', 'Vui lòng nhập mã xác thực');
    }
    else {
      Get.dialog( Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 5,
              color: Color(0xffffa386),

            ),
            const SizedBox(height: 20,),
            Text("Hệ thống đang xác thực",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  decoration: TextDecoration.none
              ),
            )
          ],
        ),
      ));
      try{
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: logic.verifyId.value ?? '',
          smsCode: codeController.text,
        );
        await auth.signInWithCredential(credential).then((value) async {
          phoneNumber.value = value.user?.phoneNumber;

        });
        Get.to( IndexPage());
      }catch(e){
        Get.back();
        Get.snackbar("Hệ thộng xác thực thất bại","Vui lòng thử lại");
      }
    }
  }
  Future<void>resendOtp(String? phone)async{


      try{
        await auth.verifyPhoneNumber(
          phoneNumber: "+84${phone}",
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
