import 'package:app_ft_tmart/src/core/config.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/get_user_profile_rsp.dart';

class ProfileLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>token = Rxn();
  Rxn<GetUserProfileRsp>getUserProfileRsp = Rxn();
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await checkSignIn();
    await getUserProfile();

  }

  Future<GetUserProfileRsp?>getUserProfile()async{
    getUserProfileRsp.value = await tMartServices.getUserProfileRsp();
    return getUserProfileRsp.value;
  }



  Future<void>checkSignIn()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")==''){
      Get.to(const SignInPage(intoCart: false,));
    }
    else{
      onSignIn.value = true;

    }
  }
}
