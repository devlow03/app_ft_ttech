import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/home/home_logic.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class IndexLogic extends GetxController {
  final Rx<int> tabIndex = Rx(0);

  void tabSelect(tab) async {
    setAppBar();
    final userUtils = Get.put(UserUtils());
    if (tab == 4) {

      bool isLogin = await userUtils.checkSignIn(intoPage: false);
      if (isLogin) {
        tabIndex.value = tab;
      }
    } else {

      tabIndex.value = tab;
    }
  }

  void setAppBar(){
    final home = Get.put(HomeLogic());
    home.positionPixel.value=100;
  }
}
