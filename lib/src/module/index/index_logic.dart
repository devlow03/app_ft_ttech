import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:get/get.dart';

class IndexLogic extends GetxController {
  final Rx<int> tabIndex = Rx(0);

  void tabSelect(tab) async {
    // var isSignIn = await XData.isSignIn();
    // if (!isSignIn && tab == 3) {
    //   // Get.to(() => const SignInPage());
    //   return;
    // }
    if(tab == 2){
      Get.to(const CartPage());
    }
    else{
      tabIndex.value = tab;
    }
    
  }
}
