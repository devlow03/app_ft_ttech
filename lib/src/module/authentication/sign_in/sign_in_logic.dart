import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignInLogic extends GetxController {
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>avatar = Rxn();
  Rxn<String>fullName = Rxn();
  Rxn<String>uid = Rxn();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future socialSignin(User? user)async{
    avatar.value = user?.photoURL;
    fullName.value = user?.displayName;
    uid.value = user?.uid;
    Get.offAll(IndexPage());
    onSignIn.value=true;
    print(">>>>>>>>>>>>>>>>>>>${avatar.value}");
    Fluttertoast.showToast(
        msg: "Đăng nhập thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }

  Future signOut()async{
    await auth.signOut();
    onSignIn.value=false;
    Fluttertoast.showToast(
        msg: "Đăng xuất thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }
}
