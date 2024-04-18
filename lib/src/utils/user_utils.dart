import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUtils extends GetxController{
  Future<bool>checkSignIn({ bool? intoPage, bool? fromHome,})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")==''){
      if(fromHome==true){
        return false;
      }
      else{
        Fluttertoast.showToast(msg: "Đăng nhập để sử dụng chức năng này");
        Get.to( SignInPage(intoPage: intoPage,));
        return false;
      }
    }

    return true;
  }

}

