import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:get/get.dart';

import '../../data/respository/get_session_rsp.dart';
import '../home/home_logic.dart';
import '../index/index_view.dart';

class SplashLogic extends GetxController {
  final EncryptedSharedPreferences sharedPreferences;
  final logic = Get.put(HomeLogic(Get.find(),Get.find()));
  final Services tMartServices;
  SplashLogic(this.tMartServices,this.sharedPreferences);
  Rxn<GetSessionRsp>getSessionRsp = Rxn();

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await logic.getBanner();
    Get.offAll(IndexPage());



  }

}
