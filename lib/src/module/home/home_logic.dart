import 'dart:convert';

import 'package:app_ft_tmart/src/data/respository/get_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_category_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_may_be_you_like_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_top_seller_rsp.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/respository/get_product_rsp.dart';
import '../../data/services/service.dart';
import '../../data/services/tiki_service.dart';
import '../cart/cart_logic.dart';



class HomeLogic extends GetxController {
  final Services tMartServices;
  final EncryptedSharedPreferences sharedPreferences;

  HomeLogic(this.tMartServices,this.sharedPreferences);
  Rxn<GetBannerRsp> getBannerRsp = Rxn();
  Rxn<GetProductRsp>getProductRsp = Rxn();
  Rxn<GetProductRsp>getProductByIdCategoryRsp = Rxn();
  Rxn<GetCategoryRsp>getCategoryRsp = Rxn();


  Rxn<int> activeIndex = Rxn();
  // Rxn<String>idCategory = Rxn();
  final dio = Dio();
  Rxn<int>tabIndex = Rxn(0);
  Rxn<int>tabLike = Rxn(0);
  Rx<int>totalItem = Rx(0);
  Rx<int>page = Rx(10);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);
  Rxn<GetProductRsp>getPhoneRsp = Rxn();
  Rxn<GetProductRsp>getLaptopRsp = Rxn();
  Rxn<GetProductRsp>getTabletRsp = Rxn();
  Rxn<GetProductRsp>getWatchRsp = Rxn();
  List<IconData> iconCategory = [
    Icons.phone_android_outlined,
    Icons.laptop_mac_outlined,
    Icons.tablet_mac_outlined,
    Icons.watch_outlined
  ];
  final logicCart = Get.put(CartLogic(Get.find()));

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await logicCart.getCart();
    print(">>>>>>>>>>>>>>>>>>>session:${await sharedPreferences.getString("session")}");
    await getCategory();
    await getPhone();
    await getLaptop();
    await getTablet();
    await getWatch();
    await getProduct(page: page.value);
     loadMore();



  }

  @override
  void refresh()async{
    super.refresh();
    await getBanner();
    await getCategory();
    await getProduct(page: page.value);

    totalItem.value = getProductRsp.value?.data?.length??0;
    if(indexPage.value<=totalItem.value){
      loadMore();
      isLoading.value=false;

    }
    return;
  }



  Future<GetBannerRsp?>getBanner()async{
    getBannerRsp.value = await tMartServices.getBannerRsp();
    return getBannerRsp.value;
  }

  Future<GetProductRsp?>getProduct({required int page})async{
    getProductRsp.value = await tMartServices.getProductRsp(page: page);
    return getProductRsp.value;
  }

  Future<GetCategoryRsp?>getCategory()async{

    getCategoryRsp.value = await tMartServices.getCategoryRsp();

    return getCategoryRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){
        if(page.value<(getProductRsp.value?.meta?.total??0)){
          isLoading.value=true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value+=10;
          await getProduct(page: page.value);
        }



      }
    });
    isLoading.value=false;
  }
  Future<GetProductRsp?>getProductByIdCategory({required int id})async{
    getProductByIdCategoryRsp.value = await tMartServices.getProductByIdCategoryRsp(categoryId: id);
    return getProductByIdCategoryRsp.value;
  }
  Future<GetProductRsp?>getPhone()async{
    getPhoneRsp.value = await tMartServices.getProductByIdCategoryRsp(categoryId: 4);
    return getPhoneRsp.value;
  }

  Future<GetProductRsp?>getLaptop()async{
    getLaptopRsp.value = await tMartServices.getProductByIdCategoryRsp(categoryId: 5);
    return getLaptopRsp.value;
  }

  Future<GetProductRsp?>getTablet()async{
    getTabletRsp.value = await tMartServices.getProductByIdCategoryRsp(categoryId: 6);
    return getTabletRsp.value;
  }
  Future<GetProductRsp?>getWatch()async{
    getWatchRsp.value = await tMartServices.getProductByIdCategoryRsp(categoryId: 7);
    return getWatchRsp.value;
  }













}
