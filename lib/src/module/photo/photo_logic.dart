import 'package:get/get.dart';

import '../product/product_logic.dart';

class PhotoLogic extends GetxController {
  final logicPro = Get.put(ProductLogic(Get.find()));
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    logicPro.carouselControl.animateToPage(logicPro.indexSlider.value);

  }
}
