import 'dart:convert';

import 'package:app_ft_tmart/src/data/repositories/get_slider_prod_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_cart_rqst.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_cart_rsp.dart';
import '../../data/repositories/get_product_by_id_rsp.dart';
import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../cart/cart_logic.dart';



class ProductLogic extends GetxController {
  final Services tMartServices;
  ProductLogic(this.tMartServices);
  Rxn<GetProductByIdRsp>getProductByIdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int>indexSlider = Rx(0);
  CarouselController carouselControl = CarouselController();
  ScrollController scrollController = ScrollController();
  Rxn<bool>viewAll = Rxn(false);
  Rx<int> quantity = Rx(1);
  final logicCart = Get.put(CartLogic(Get.find()));
  Rxn<GetProductRsp>getProductRsp = Rxn();


  final dio = Dio();
  @override
  void refresh() async{
    // TODO: implement refresh
    super.refresh();
    await logicCart.getCart();
    await getProductById;
    await getProductByIdCategory();
  }
  @override
  void onReady() async{
    // TODO: implement onReady
    // await getSliderProd;
    super.onReady();
    await logicCart.getCart();
    await getProductById;
    await getProductByIdCategory();


  }

  Future<GetProductByIdRsp?>getProductById({required String id})async{
    getProductByIdRsp.value = await tMartServices.getProductByIdRsp(id: id);
    return getProductByIdRsp.value;
  }

  Future<void>postAddCart({required String productId, required String quantity })async{
    await tMartServices.postAddCart(body: PostCartRqst(
      // guestSession: "64FF1EABC08F21694441131",
        productId: productId,
        quantity: quantity
    ));
    await logicCart.getCart();
    Fluttertoast.showToast(msg: "Đã thêm vào giỏ hàng");






  }

  Future<void>buyNow({required String productId, required String quantity })async{
    await postAddCart(productId: productId, quantity: quantity);
    await logicCart.getCart();
    Get.to(CartPage());




  }

  Future<GetProductRsp?>getProductByIdCategory()async{
    final id = (getProductByIdRsp.value?.data?.categoryId)??0;
    getProductRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(
            categoryId: [id.toString()]
        )

    );
    return getProductRsp.value;
  }

}
