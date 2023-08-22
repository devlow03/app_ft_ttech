import 'package:get/get.dart';

import '../../data/respository/prodslider_res.dart';
import '../../data/services/tmart_services.dart';

class ProductLogic extends GetxController {
  final TMartServices tMartServices;
  ProductLogic(this.tMartServices);
  Rxn<ProdsliderRes> getSliderProdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  @override
  void onReady() async{
    // TODO: implement onReady
    await getSliderProd;
    super.onReady();
  }
  Future<ProdsliderRes?>getSliderProd({required String id})async{
    getSliderProdRsp.value = await tMartServices.getSliderProdRsp(slider: id);
    return getSliderProdRsp.value;
  }
}
