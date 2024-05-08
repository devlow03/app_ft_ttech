import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class IndexLogic extends GetxController {
  final Rx<int> tabIndex = Rx(0);

  void tabSelect(tab) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userUtils = Get.put(UserUtils());
     
    // var isSignIn = await XData.isSignIn();
    // if (!isSignIn && tab == 3) {
    //   // Get.to(() => const SignInPage());
    //   return;
    // }
    
    if(tab==4){
      bool isLogin = await userUtils.checkSignIn(intoPage: false);
      if(isLogin){
        tabIndex.value = tab;
      }

      

    }
    else{
      tabIndex.value = tab;
    }
    
  }
}