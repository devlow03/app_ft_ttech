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



      tabIndex.value = tab;

    
  }
}
