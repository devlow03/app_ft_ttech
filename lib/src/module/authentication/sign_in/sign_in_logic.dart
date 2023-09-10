import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInLogic extends GetxController {
  final EncryptedSharedPreferences sharedPreferences;
  SignInLogic(this.sharedPreferences);
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>avatar = Rxn();
  Rxn<String>fullName = Rxn();
  Rxn<String>uid = Rxn();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future socialSignin(User? user)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    avatar.value = user?.photoURL;
    fullName.value = user?.displayName;
    prefs.setString('uid', user?.uid??"");
    uid.value=prefs.getString('uid');
    onSignIn.value=true;
    Get.back();

    print(">>>>>>>>>>>>>>>>>>>${avatar.value}");
    Fluttertoast.showToast(
        msg: "Đăng nhập thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }

  Future signOut()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await auth.signOut();
    prefs.remove('uid');
    uid.value=null;
    Fluttertoast.showToast(
        msg: "Đăng xuất thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }
}
