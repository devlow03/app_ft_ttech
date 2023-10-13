import 'package:app_ft_tmart/src/core/config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLogic extends GetxController {
  Rxn<bool> onSignIn = Rxn(false);
  Rxn<String>token = Rxn();
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = await prefs.getString(GlobalData.token);
  }
}
