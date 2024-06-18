import 'dart:convert';

import 'package:app_ft_tmart/src/data/repositories/get_%20comment_queries.dart';
import 'package:app_ft_tmart/src/data/repositories/get_comment_response.dart';
import 'package:app_ft_tmart/src/data/repositories/post_cart_rqst.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_view.dart';
import 'package:app_ft_tmart/src/utils/user_utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_by_id_rsp.dart';
import '../../data/repositories/get_product_rq_query.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/repositories/post_add_favorite_rqst.dart';
import '../cart/cart_logic.dart';

class ProductDetailLogic extends GetxController {
  final Services tMartServices;
  ProductDetailLogic(this.tMartServices);
  Rxn<GetProductByIdRsp> getProductByIdRsp = Rxn();
  Rx<int> activeIndex = Rx(0);
  Rx<int> indexSlider = Rx(0);
  CarouselController carouselControl = CarouselController();
  ScrollController scrollController = ScrollController();
  Rxn<bool> viewAll = Rxn(false);
  Rx<int> quantity = Rx(1);
  final logicCart = Get.put(CartLogic());
  Rxn<GetProductRsp> getProductRsp = Rxn();
  Rxn<GetProductRsp> getProductByBrandRsp = Rxn();
  final userUtils = Get.put(UserUtils());
  Rxn<GetCommentResponse> getCommentRsp = Rxn();
  RxBool isAllReviews = RxBool(false);
  // Rxn<String> productId = Rxn();
  PageController pageViewController = PageController();
  Rxn<int> indexCommentDetail = Rxn(0);
  Rxn<int> indexComment = Rxn(0);
  ScrollController scrollControllerAllReview = ScrollController();
  Rx<int> perPage = Rx(10);
  RxList<Map<String,dynamic>> imageComments = RxList();

  // final dio = Dio();
  @override
  void refresh() async {
    // TODO: implement refresh
    super.refresh();
    await logicCart.getCart();
    await getProductById(getProductByIdRsp.value?.data?.id.toString()??"");

    await getComment();
    getProductByBrands();
    getProductByIdCategory();

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    imageComments.clear();
  }
  @override
  void onReady() async {
    // TODO: implement onReady
    // await getSliderProd;
    super.onReady();
    await logicCart.getCart();


    await getProductByIdCategory();
    getProductByBrands();
    getProductByIdCategory();
    pageViewController.addListener(() {
      indexCommentDetail.value = 0;
    });
    loadMore();
  }

  Future<GetProductByIdRsp?> getProductById(String id) async {
      Get.to(const ProductDetailPage());
      getProductByIdRsp.value = null;
      getProductByIdRsp.value =
          await tMartServices.getProductByIdRsp(id: id ?? "");
      getProductByIdRsp.refresh();
      await getComment();
      getProductByBrands();
      getProductByIdCategory();

    return getProductByIdRsp.value;
  }

  Future<void> postAddCart(
      {required String productId, required String quantity}) async {
    await userUtils.checkSignIn(intoPage: true);
    await tMartServices.postAddCart(
        body: PostCartRqst(
            // guestSession: "64FF1EABC08F21694441131",
            productId: productId,
            quantity: quantity));
    await logicCart.getCart();
    Fluttertoast.showToast(msg: "Đã thêm vào giỏ hàng");
  }

  Future<void> postAddFavorite() async {
    await userUtils.checkSignIn(intoPage: true);

    await tMartServices.postAddFavorite(
        body: PostAddFavoriteRqst(
            productId: getProductByIdRsp.value?.data?.id?.toInt()));
             getProductById(getProductByIdRsp.value?.data?.id?.toString()??"");
    Fluttertoast.showToast(msg: "Đã thêm vào bộ sưu tập");
  }

  

  Future<void> deleteFavorite() async {
    await tMartServices.deleteFavorite(
        body: PostAddFavoriteRqst(
            productId:
                int.parse(getProductByIdRsp.value?.data?.id.toString() ?? "")));
    getProductById(getProductByIdRsp.value?.data?.id?.toString()??"");
    Fluttertoast.showToast(msg: "Đã xóa khỏi bộ sưu tập");
  }

  Future<void> buyNow(
      {required String productId, required String quantity}) async {
    await userUtils.checkSignIn(intoPage: true);

    await postAddCart(productId: productId, quantity: quantity);
    await logicCart.getCart();
    Get.to(const CartPage());
  }

  Future<GetProductRsp?> getProductByIdCategory() async {
    final id = (getProductByIdRsp.value?.data?.categoryId) ?? 0;
    getProductRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(categoryId: [id.toString()]));
    getProductRsp.refresh();
    return getProductRsp.value;
  }

  Future<GetProductRsp?> getProductByBrands() async {
    final brands = (getProductByIdRsp.value?.data?.manufacturerId) ?? 0;
    getProductByBrandRsp.value = await tMartServices.getProductRsp(
        query: GetProductRqQuery(manufacturerId: [brands.toString()]));
    getProductByBrandRsp.refresh();
    return getProductByBrandRsp.value;
  }

  Future<GetCommentResponse?> getComment() async {
    getCommentRsp.value = await tMartServices.getCommentRsp(
        query:
            GetCommentQueries(perPage: perPage.value.toString(), productId: getProductByIdRsp.value?.data?.id.toString() ?? ""));
    await getImageComment();
    return getCommentRsp.value;
  }

  Future<void> loadMore() async {
    scrollControllerAllReview.addListener(() async {
      if (scrollControllerAllReview.position.maxScrollExtent ==
          scrollControllerAllReview.offset) {
        if (perPage.value < (getCommentRsp.value?.meta?.total ?? 0)) {
          perPage.value += 10;
          print(">>>>page: ${perPage.value}");

          getCommentRsp.value = await tMartServices.getCommentRsp(
              query: GetCommentQueries(
                  perPage: perPage.value.toString(), productId:  getProductByIdRsp.value?.data?.id.toString() ?? ""));

          getCommentRsp.refresh();
        }
      }
    });
  }

  Future<void>getImageComment()async{
    imageComments.clear();
    final commentLength = getCommentRsp.value?.data?.length??0;
    for(var i =0 ; i<commentLength;i++){
      final images = getCommentRsp.value?.data?[i].imageUrl;


       if(images?.isNotEmpty==true){
         final Map<String,dynamic>  imageMap = {
           "id":getCommentRsp.value?.data?[i].id,
           "avatar":getCommentRsp.value?.data?[i].userAvatar,
           "fullName":getCommentRsp.value?.data?[i].user,
           "content":getCommentRsp.value?.data?[i].text,
           "rating":getCommentRsp.value?.data?[i].rating,
           "createdAt":getCommentRsp.value?.data?[i].createdAt,
           "imageUrl":images
         };
         imageComments.add(imageMap);
       }
      }
    print(">>>>>>>>>>${jsonEncode(imageComments)}");
    }



}
