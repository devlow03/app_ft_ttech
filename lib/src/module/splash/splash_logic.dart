import 'package:get/get.dart';

import '../home/home_logic.dart';
import '../index/index_view.dart';

class SplashLogic extends GetxController {
  final logic = Get.put(HomeLogic(Get.find(),Get.find()));
  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await logic.getBanner();
    // await logic.getCategory();
    // await logic.getTikiTopSeller();
    // await logic.getBanner();
    // await logic.getCategory();
    // await logic.getPhone();
    // await logic.getLaptop();
    // await logic.getTablet();
    // await logic.getWatch();
    // await logic.getAccessory();
    // await logic.getScreen();
    // await logic.getKeyboard();
    // await logic.getTv();
    Get.offAll(IndexPage());
  }
}
