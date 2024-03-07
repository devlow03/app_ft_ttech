import 'package:get/get.dart';

import '../product_detail/product_detail_logic.dart';

class PhotoLogic extends GetxController {
  final logicPro = Get.put(ProductDetailLogic(Get.find()));
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    logicPro.carouselControl.animateToPage(logicPro.indexSlider.value);

  }
}
