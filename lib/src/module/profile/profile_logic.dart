import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/profile/profile_detail/profile_detail_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/get_user_profile_rsp.dart';

class ProfileLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>token = Rxn();
  Rxn<GetUserProfileRsp>getUserProfileRsp = Rxn();
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getUserProfile();
    // final logic = Get.put(ProfileDetailLogic());
    //  logic.setImage();


  }

  Future<GetUserProfileRsp?>getUserProfile()async{
    getUserProfileRsp.value = await tMartServices.getUserProfileRsp();
    return getUserProfileRsp.value;
  }



 
}
