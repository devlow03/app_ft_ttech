import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/data/repositories/post_signin_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/home/home_view.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_android/local_auth_android.dart';
import '../../../core/xcolor.dart';
import '../../../data/repositories/post_signin_rqst.dart';

class SignInLogic extends GetxController {
  final Services tMartServices = Get.find();
   final localAuth = LocalAuthentication();
  Rx<bool>checkAuth = Rx(false);
  Rxn<String>biometric = Rxn();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rxn<bool>intoPage = Rxn(false);
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>avatar = Rxn();
  Rxn<String>fullName = Rxn();
  Rxn<String>uid = Rxn();
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<PostSigninRsp>postSignInRsp = Rxn();
  Rxn<bool>onLocalAuth = Rxn();

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    
    // passControl.text = "11111111aA@";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("biometric")=="finger"){
          biometric.value = "finger";
        }
    else if(prefs.getString("biometric")=="faceID"){
          biometric.value = "faceID";
    }
     await checkBiometric();
    await checkOnLocalAuth();
    print(">>>>>>>>>>>>>>>>biometric: ${biometric.value}");
     
    
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
    prefs.remove(GlobalData.token);
    prefs.remove(GlobalData.userIdNotify);
    uid.value=null;
    Get.offAll(SignInPage());
    Fluttertoast.showToast(
        msg: "Đăng xuất thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
  }

  Future signIn({String? phone, String? password})async{
    if(phone!='' && password!=''){
      Utils.loading(()async{
        postSignInRsp.value = await tMartServices.postSigninRsp(body:
        PostSigninRqst(
            phone: phone,
            password: password
        )
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(GlobalData.token,"${postSignInRsp.value?.token}" );
        await prefs.setString("password", password??"");
        await prefs.setString("phone", phone??"");
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
        if(intoPage.value==true){
          Get.back();
          Get.back();
        }
        else{
          Get.offAll(IndexPage());
        }
      });
    }
    else{
      Utils.loading(()async{
        postSignInRsp.value = await tMartServices.postSigninRsp(body:
        PostSigninRqst(
            phone: phoneControl.text,
            password: passControl.text
        )
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(GlobalData.token,"${postSignInRsp.value?.token}" );
        await prefs.setString("password", passControl.text);
        await prefs.setString("phone", phoneControl.text);
  
        Get.back();
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
        if(intoPage.value==true){
          Get.back();
          Get.back();
        }
        else{
          Get.offAll(IndexPage());
        }
      });
    }
  }

  Future<void> signInwithBiometric() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Vui lòng xác thực để tiếp tục',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
              signInTitle: "Xác thực bằng vân tay", cancelButton: "Thoát"),

        ],
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true)
        // Thông điệp hiển thị cho người dùng

        );

    if (isAuthenticated) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phone = prefs.getString("phone");
      String? password = prefs.getString("password");
      await signIn(phone: phone,password: password);
      
    } else {
      Fluttertoast.showToast(msg: "Xác thực thất bại vui lòng thử lại");
    }
  }

  Future<void> checkOnLocalAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("onLocalAuth") == "true") {
      onLocalAuth.value = true;
    } else {
      onLocalAuth.value = false;
    }
  }

   Future<void> checkBiometric() async {
    final localAuth = LocalAuthentication();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      checkAuth.value = await localAuth.isDeviceSupported();
      prefs.setString("checkAuth", "${checkAuth.value}");

      if (!checkAuth.value) {
        return;
      } 
    } catch (e) {
      print('Lỗi trong quá trình kiểm tra local authentication: $e');
    }
  }


}
