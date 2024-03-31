import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';

class IndexLogic extends GetxController {
  final Rx<int> tabIndex = Rx(0);

  void tabSelect(tab) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     
    // var isSignIn = await XData.isSignIn();
    // if (!isSignIn && tab == 3) {
    //   // Get.to(() => const SignInPage());
    //   return;
    // }
    if(tab == 2){
      Get.to(const CartPage(),transition: Transition.downToUp);
    }
    else if((tab==3 && ( prefs.getString(GlobalData.token)??"")=='') || (tab==4 && ( prefs.getString(GlobalData.token)??"")=='')){
      Fluttertoast.showToast(msg: "Đăng nhập để sử dụng chức năng này");
      Get.to(const SignInPage(intoCart: true,));

    }
    else{
      tabIndex.value = tab;
    }
    
  }
}
