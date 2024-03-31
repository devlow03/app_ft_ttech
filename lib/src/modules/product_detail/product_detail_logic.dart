import 'dart:convert';

import 'package:app_ft_tmart/src/data/repositories/get_slider_prod_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_cart_rqst.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global_data.dart';
import '../../data/repositories/get_cart_rsp.dart';
import '../../data/repositories/get_product_by_id_rsp.dart';
import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/repositories/post_add_favorite_rqst.dart';
import '../authentication/sign_in/sign_in_view.dart';
import '../cart/cart_logic.dart';



class ProductDetailLogic extends GetxController {
  final Services tMartServices;
  ProductDetailLogic(this.tMartServices);
  Rxn<GetProductByIdRsp>getProductByIdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int>indexSlider = Rx(0);
  CarouselController carouselControl = CarouselController();
  ScrollController scrollController = ScrollController();
  Rxn<bool>viewAll = Rxn(false);
  Rx<int> quantity = Rx(1);
  final logicCart = Get.put(CartLogic());
  Rxn<GetProductRsp>getProductRsp = Rxn();
  Rxn<GetProductRsp>getProductByBrandRsp = Rxn();


  final dio = Dio();
  @override
  void refresh() async{
    // TODO: implement refresh
    super.refresh();
    await logicCart.getCart();
    getProductByBrands();
      getProductByIdCategory();
    
  }
  @override
  void onReady() async{
    // TODO: implement onReady
    // await getSliderProd;
    super.onReady();
    await logicCart.getCart();
    await getProductByIdCategory();


  }

  Future<GetProductByIdRsp?>getProductById({required String id})async{
    if(id!=''){
    getProductByIdRsp.value = null;
    getProductByIdRsp.value = await tMartServices.getProductByIdRsp(id: id);
    }
    getProductByIdRsp.refresh();
    return getProductByIdRsp.value;
    
  }

  Future<void>postAddCart({required String productId, required String quantity })async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")==''){
      Fluttertoast.showToast(msg: "Đăng nhập để mua hàng");
      Get.to(const SignInPage(intoCart: true,));
    }
    else{
      await tMartServices.postAddCart(body: PostCartRqst(
        // guestSession: "64FF1EABC08F21694441131",
          productId: productId,
          quantity: quantity
      ));
      await logicCart.getCart();
      Fluttertoast.showToast(msg: "Đã thêm vào giỏ hàng");

    }

    




  }

  Future<void>postAddFavorite()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")==''){
      Fluttertoast.showToast(msg: "Đăng nhập để sử dụng chức năng này");
      Get.to(const SignInPage(intoCart: true,));
    }
      else{
      await tMartServices.postAddFavorite(body:
      PostAddFavoriteRqst(
          productId: int.parse(getProductByIdRsp.value?.data?.id.toString()??"")
      )
      );
      Fluttertoast.showToast(msg: "Đã thêm vào bộ sưu tập");
    }
    }

    Future<void>deleteFavorite()async{
      await tMartServices.deleteFavorite(body: 
      PostAddFavoriteRqst(
        productId: int.parse(getProductByIdRsp.value?.data?.id.toString()??"")
      )
      );
      Fluttertoast.showToast(msg: "Đã thêm vào bộ sưu tập");
    }


  Future<void>buyNow({required String productId, required String quantity })async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(( prefs.getString(GlobalData.token)??"")==''){
      Fluttertoast.showToast(msg: "Đăng nhập để mua hàng");
      Get.to(const SignInPage(intoCart: true,));
    }
    else{
      await postAddCart(productId: productId, quantity: quantity);
      await logicCart.getCart();
      Get.to(CartPage());
    }




  }

  Future<GetProductRsp?>getProductByIdCategory()async{
    final id = (getProductByIdRsp.value?.data?.categoryId)??0;
    getProductRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(
            categoryId: [id.toString()]
        )

    );
    // getProductRsp.refresh();
    return getProductRsp.value;
  }

  Future<GetProductRsp?>getProductByBrands()async{
    final brands = (getProductByIdRsp.value?.data?.manufacturerId)??0;
    getProductByBrandRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(
            manufacturerId: [brands.toString()]
        )

    );
    getProductByBrandRsp.refresh();
    return getProductByBrandRsp.value;
  }


  Future<void>getProduct(String? id)async{
  
      await getProductById(id: id ??"");
      await getProductByBrands();
      await getProductByIdCategory();
    
  }

}
