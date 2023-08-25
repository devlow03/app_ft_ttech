import 'package:app_ft_tmart/src/data/respository/get_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_category_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_product_by_category_rsp.dart';

import 'package:get/get.dart';

import '../../data/services/service.dart';



class HomeLogic extends GetxController {
  final Services tMartServices;
  HomeLogic(this.tMartServices);

  Rxn<GetBannerRsp> getBannerRsp = Rxn();
  Rxn<GetCategoryRsp> getCategoryRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getProductRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getPhoneRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getTabletRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getAccessoryRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getScreenRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getKeyboardRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getTvRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getLaptopRsp = Rxn();
  Rxn<GetProductByCategoryRsp>getWatchRsp = Rxn();
  Rxn<int> activeIndex = Rxn();
  Rxn<String>idCategory = Rxn();

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getBanner();
    await getCategory();
    // await getProduct;
    await getPhone();
    await getLaptop();
    await getTablet();
    await getWatch();
    await getAccessory();
    await getScreen();
    await getKeyboard();
    await getTv();
  }

  @override
  void refresh()async{
    super.refresh();
    await getBanner();
    await getCategory();
    await getProduct;
  }
  Future<GetBannerRsp?>getBanner()async{
    getBannerRsp.value = await tMartServices.getBanner();
    return getBannerRsp.value;
  }

  Future<GetCategoryRsp?>getCategory()async{
     getCategoryRsp.value = await tMartServices.getCategory();
     return getCategoryRsp.value;
  }
  Future<GetProductByCategoryRsp?>getProduct({required String id})async{
    getProductRsp.value = await tMartServices.getProductCategory(id: id);
    return getProductRsp.value;
  }
  Future<GetProductByCategoryRsp?>getPhone()async{
    getPhoneRsp.value = await tMartServices.getProductCategory(id: '1');
    return getPhoneRsp.value;
  }
  Future<GetProductByCategoryRsp?>getLaptop()async{
    getLaptopRsp.value = await tMartServices.getProductCategory(id: '2');
    return getLaptopRsp.value;
  }
  Future<GetProductByCategoryRsp?>getTablet()async{
    getTabletRsp.value = await tMartServices.getProductCategory(id: '3');
    return getTabletRsp.value;
  }
  Future<GetProductByCategoryRsp?>getWatch()async{
    getWatchRsp.value = await tMartServices.getProductCategory(id: '4');
    return getWatchRsp.value;
  }
  Future<GetProductByCategoryRsp?>getAccessory()async{
    getAccessoryRsp.value = await tMartServices.getProductCategory(id: '5');
    return getAccessoryRsp.value;
  }
  Future<GetProductByCategoryRsp?>getScreen()async{
    getScreenRsp.value = await tMartServices.getProductCategory(id: '6');
    return getScreenRsp.value;
  }
  Future<GetProductByCategoryRsp?>getKeyboard()async{
    getKeyboardRsp.value = await tMartServices.getProductCategory(id: '7');
    return getKeyboardRsp.value;
  }
  Future<GetProductByCategoryRsp?>getTv()async{
    getTvRsp.value = await tMartServices.getProductCategory(id: '8');
    return getTvRsp.value;
  }






}
