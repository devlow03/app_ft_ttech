import 'dart:convert';

import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/data/repositories/get_banner_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_category_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_product_rq_query.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_logic.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/repositories/get_product_rsp.dart';
import '../../data/services/service.dart';
import '../cart/cart_logic.dart';



class HomeLogic extends GetxController {
  final Services tMartServices = Get.find();
  final EncryptedSharedPreferences sharedPreferences= Get.find();
  final notification = Get.put(NotificationLogic());
  HomeLogic();
  Rxn<GetBannerRsp> getBannerRsp = Rxn();
  Rxn<GetProductRsp>getProductRsp = Rxn();
  Rx<Map<int, GetProductRsp>> getProductByIdCategoryRsp = Rx({});
  Rxn<GetCategoryRsp>getCategoryRsp = Rxn();


  Rxn<int> activeIndex = Rxn();
  Rxn<bool>hasData = Rxn(false);
  // Rxn<String>idCategory = Rxn();
  final dio = Dio();
  Rxn<int>tabIndex = Rxn(0);
  Rxn<int>tabLike = Rxn(0);
  Rx<int>totalItem = Rx(0);
  Rx<int>page = Rx(10);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);
  List<IconData> iconCategory = [
    Icons.phone_android_outlined,
    Icons.laptop_mac_outlined,
    Icons.tablet_mac_outlined,
    Icons.watch_outlined
  ];
  final logicCart = Get.put(CartLogic());

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await notification.getNotifications();
    await getBanner();
    print(">>>>>>>>>>>>>>>>>>>session:${await sharedPreferences.getString("session")}");
    await getCategory();
    await getProductByIdCategory();

    // if(hasData.value == false){
    //   getProductByIdCategoryRsp.refresh();
    //   hasData.value=true;
    // }
    // else{
    //   hasData.value=false;
    // }
    await getProduct();
    loadMore();



  }



  @override
  void refresh()async{
    super.refresh();
    await getBanner();
    await getCategory();
    await getProductByIdCategory();
    await getProduct();



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

  Future<GetProductRsp?>getProduct()async{

    getProductRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(
          perPage: (page.value).toString(),
        )
    );
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
          print(">>>>page: ${page.value}");
          await getProduct();
        }



      }
    });
    
  }
  Future getProductByIdCategory()async{
    final category = getCategoryRsp.value?.data;
    final categoryLength = category?.length;
    for(var i=0; i< (categoryLength??0);i++){
      int? id = category?[i].id;
      getProductByIdCategoryRsp.value[id??0] = await tMartServices.getProductRsp(
          query: GetProductRqQuery(
              categoryId: [id.toString()],
            perPage: "5"
          )
      );




    }
    getProductByIdCategoryRsp.refresh();





  }














}
