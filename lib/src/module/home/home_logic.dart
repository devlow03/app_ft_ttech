import 'dart:convert';

import 'package:app_ft_tmart/src/data/respository/get_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_category_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_may_be_you_like_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_top_seller_rsp.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';

import '../../data/respository/get_product_rsp.dart';
import '../../data/services/service.dart';
import '../../data/services/tiki_service.dart';



class HomeLogic extends GetxController {
  final Services tMartServices;
  final TikiService tikiService;
  HomeLogic(this.tMartServices,this.tikiService);
  Rxn<GetTikiBannerRsp> getTikiBannerRsp = Rxn();
  Rxn<GetTikiTopSellerRsp>getTikiTopSellerRsp = Rxn();
  Rxn<GetMayBeYouLikeRsp>getMayBeYouLikeRsp =Rxn();
  Rxn<GetProductRsp>getProductRsp = Rxn();
  Rxn<GetCategoryRsp>getCategoryRsp = Rxn();

  Rxn<int> activeIndex = Rxn();
  // Rxn<String>idCategory = Rxn();
  final dio = Dio();
  Rxn<int>tabIndex = Rxn(0);
  Rxn<int>tabLike = Rxn(0);


  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    getTikiBanner();
    getCategory();
    getProduct();
     getTikiTopSeller();
     getMayBeYouLike();


  }

  @override
  void refresh()async{
    super.refresh();
    await getTikiBanner();
    await getCategory();
    await getProduct();
    await getTikiTopSeller();
    await getMayBeYouLike();
  }



  Future<GetTikiBannerRsp?>getTikiBanner()async{
    final response = await dio.get("https://tka.tiki.vn/widget/api/v1/banners-group?group=home_banner_main_v2");
    getTikiBannerRsp.value = GetTikiBannerRsp.fromJson(response.data);
    return getTikiBannerRsp.value;
  }

  Future<GetTikiTopSellerRsp?>getTikiTopSeller()async{
    final response = await dio.get("https://api.tiki.vn/raiden/v3/widgets/top_selling");
    getTikiTopSellerRsp.value = GetTikiTopSellerRsp.fromJson(response.data);
    return getTikiTopSellerRsp.value;
  }

  Future<GetMayBeYouLikeRsp?>getMayBeYouLike()async{
    final response = await dio.get("https://api.tiki.vn/raiden/v3/widgets/maybe_you_like");
    getMayBeYouLikeRsp.value = GetMayBeYouLikeRsp.fromJson(response.data);
    print(jsonEncode(response.data));
    return getMayBeYouLikeRsp.value;
  }

  Future<GetProductRsp?>getProduct()async{
    getProductRsp.value = await tMartServices.getProductRsp();
    return getProductRsp.value;
  }

  Future<GetCategoryRsp?>getCategory()async{
    final response = await dio.get("https://smartstore.khanhnhat.top/api/v1/category");
    getCategoryRsp.value = GetCategoryRsp.fromJson(response.data);
    print(jsonEncode(response.data));
    return getCategoryRsp.value;
  }







}
