import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_logic.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class SplashLogic extends GetxController {
  final userUtils = Get.put(UserUtils());

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    print(">>>>>>>>>>>>>>>${await userUtils.checkSignIn(fromHome: true)}");
    if(await userUtils.checkSignIn(fromHome: true)==true){
      final profile = Get.put(ProfileLogic());
      await profile.getUserProfile();
      Get.offAll(IndexPage());
    }
    else{
      Future.delayed(const Duration(seconds: 3),(){

        Get.offAll(IndexPage());
      });
    }
    // checkSignIn();
  }


}
