import 'dart:convert';

import 'package:app_ft_tmart/src/data/respository/get_slider_prod_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_product_rsp.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProductLogic extends GetxController {
  final Services tMartServices;
  ProductLogic(this.tMartServices);
  Rxn<GetSliderProdRsp> getSliderProdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int>indexSlider = Rx(0);
  Rxn<GetTikiProductRsp>getTikiProductRsp = Rxn();
  CarouselController carouselControl = CarouselController();
  ScrollController scrollController = ScrollController();
  final dio = Dio();
  @override
  void onReady() async{
    // TODO: implement onReady
    // await getSliderProd;
    super.onReady();
    await getProduct;
  }
  Future<GetSliderProdRsp?>getSliderProd({required String id})async{
    getSliderProdRsp.value = await tMartServices.getSlider(id: id);
    return getSliderProdRsp.value;
  }

  Future<GetTikiProductRsp?>getProduct({required num id})async{
    final response = await dio.get("https://tiki.vn/api/v2/products/$id");
    getTikiProductRsp.value = GetTikiProductRsp.fromJson(response.data);
    print(jsonEncode(response.data));
    return getTikiProductRsp.value;
  }
}
