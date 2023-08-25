import 'package:app_ft_tmart/src/data/respository/get_slider_prod_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';



class ProductLogic extends GetxController {
  final Services tMartServices;
  ProductLogic(this.tMartServices);
  Rxn<GetSliderProdRsp> getSliderProdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int>indexSlider = Rx(0);
  CarouselController carouselControl = CarouselController();
  @override
  void onReady() async{
    // TODO: implement onReady
    await getSliderProd;
    super.onReady();
  }
  Future<GetSliderProdRsp?>getSliderProd({required String id})async{
    getSliderProdRsp.value = await tMartServices.getSlider(id: id);
    return getSliderProdRsp.value;
  }
}
