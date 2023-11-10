import 'package:app_ft_tmart/src/core/config.dart';
import 'package:app_ft_tmart/src/data/repositories/post_signin_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/home/home_view.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/xcolor.dart';
import '../../../data/repositories/post_signin_rqst.dart';

class SignInLogic extends GetxController {
  final Services tMartServices = Get.find();


  TextEditingController phoneControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rxn<bool>intoCart = Rxn(false);
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>avatar = Rxn();
  Rxn<String>fullName = Rxn();
  Rxn<String>uid = Rxn();
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<PostSigninRsp>postSignInRsp = Rxn();

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    // phoneControl.text = "0776506112";
    // passControl.text = "12345678";
  }


  Future socialSignin(User? user)async{


    avatar.value = user?.photoURL;
    fullName.value = user?.displayName;
    uid.value = user?.uid;

    onSignIn.value=true;
    Get.offAll(IndexPage());

    print(">>>>>>>>>>>>>>>>>>>${avatar.value}");

  }

  Future signOut()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await auth.signOut();
    prefs.remove('token');
    uid.value=null;
    Get.offAll(SignInPage());
    Fluttertoast.showToast(
        msg: "Đăng xuất thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }

  Future signIn()async{
    Utils.loading(()async{
      postSignInRsp.value = await tMartServices.postSigninRsp(body:
      PostSigninRqst(
          phone: phoneControl.text,
          password: passControl.text
      )
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(GlobalData.token,"${postSignInRsp.value?.token}" );
      print(">>>>>>>>>token: ${ await prefs.getString(GlobalData.token )}");

      print(">>>>>>>>>>>>>>>>>onSignin: ${onSignIn.value}");
      Fluttertoast.showToast(
          msg: "Đăng nhập thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
      intoCart.value==true?Get.back():Get.offAll(IndexPage());
    });
  }


}
