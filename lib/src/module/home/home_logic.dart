import 'package:app_ft_tmart/src/data/services/tmart_services.dart';
import 'package:get/get.dart';

import '../../data/respository/banner_res.dart';
import '../../data/respository/category_res.dart';
import '../../data/respository/prod_category_res.dart';

class HomeLogic extends GetxController {
  final TMartServices tMartServices;
  HomeLogic(this.tMartServices);

  Rxn<BannerRes> getBannerRsp = Rxn();
  Rxn<CategoryRes> getCategoryRsp = Rxn();
  Rxn<ProdCategoryRes>getProductRsp = Rxn();
  Rxn<int> activeIndex = Rxn();

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getBanner();
    await getCategory();
    await getProduct;
  }

  @override
  void refresh()async{
    super.refresh();
    await getBanner();
    await getCategory();
    await getProduct;
  }
  Future<BannerRes?>getBanner()async{
    getBannerRsp.value = await tMartServices.getBanner();
    return getBannerRsp.value;
  }

  Future<CategoryRes?>getCategory()async{
     getCategoryRsp.value = await tMartServices.getCategory();
     return getCategoryRsp.value;
  }
  Future<ProdCategoryRes?>getProduct({required String id_category})async{
    getProductRsp.value = await tMartServices.getCategoryRes(id_category: id_category);
    return getProductRsp.value;
  }

}
