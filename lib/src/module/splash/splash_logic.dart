import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config.dart';

class SplashLogic extends GetxController {

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    Future.delayed(Duration(seconds: 3),(){
      Get.offAll(IndexPage());
    });
    // checkSignIn();
  }

  Future<void>checkSignIn()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if((await prefs.getString(GlobalData.token)??"")!=""){
      Get.offAll(IndexPage());
    }
    else{
      Get.offAll(SignInPage());
    }
  }
}
