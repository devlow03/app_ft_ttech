import 'package:get/get.dart';

class IndexLogic extends GetxController {
  final Rx<int> tabIndex = Rx(0);

  void tabSelect(int tab) async {
    // var isSignIn = await XData.isSignIn();
    // if (!isSignIn && tab == 3) {
    //   // Get.to(() => const SignInPage());
    //   return;
    // }
    tabIndex.value = tab;
  }
}
