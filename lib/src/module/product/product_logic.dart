import 'dart:convert';

import 'package:app_ft_tmart/src/data/respository/get_slider_prod_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_product_rsp.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/respository/get_product_by_id_rsp.dart';



class ProductLogic extends GetxController {
  final Services tMartServices;
  ProductLogic(this.tMartServices);
  Rxn<GetProductByIdRsp>getProductByIdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int>indexSlider = Rx(0);
  Rxn<GetTikiProductRsp>getTikiProductRsp = Rxn();
  CarouselController carouselControl = CarouselController();
  ScrollController scrollController = ScrollController();
  Rxn<bool>viewAll = Rxn(false);

  final dio = Dio();
  @override
  void onReady() async{
    // TODO: implement onReady
    // await getSliderProd;
    super.onReady();
    await getProductById;
  }
  Future<GetProductByIdRsp?>getProductById({required String id})async{
    getProductByIdRsp.value = await tMartServices.getProdutByIdRsp(id: id);
    return getProductByIdRsp.value;
  }
}
