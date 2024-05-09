import 'dart:io';

import 'package:app_ft_tmart/src/data/repositories/get_%20comment_queries.dart';
import 'package:app_ft_tmart/src/data/repositories/get_comment_response.dart';
import 'package:app_ft_tmart/src/data/repositories/get_order_by_id_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_product_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_voucher_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/post_add_comment_rqst.dart';
import 'package:app_ft_tmart/src/data/repositories/post_add_voucher.dart';
import 'package:app_ft_tmart/src/data/repositories/post_check_phone_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/repositories/post_confirm_order_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/repositories/post_register_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/repositories/post_signin_rqst.dart';
import 'package:app_ft_tmart/src/data/repositories/post_update_cart_detail_rqst.dart';
import 'package:app_ft_tmart/src/data/repositories/put_update_address_book_rqst.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/global_data.dart';
import '../repositories/get_address_book_rsp.dart';
import '../repositories/get_banner_rsp.dart';
import '../repositories/get_brand_rsp.dart';
import '../repositories/get_cart_rsp.dart';
import '../repositories/get_category_rsp.dart';
import '../repositories/get_order_rqst.dart';
import '../repositories/get_order_rsp.dart';
import '../repositories/get_product_by_category_rsp.dart';
import '../repositories/get_product_by_id_rsp.dart';
import '../repositories/get_product_rq_query.dart';
import '../repositories/get_search_rsp.dart';
import '../repositories/get_session_rsp.dart';
import '../repositories/get_slider_prod_rsp.dart';
import '../repositories/get_user_profile_rsp.dart';
import '../repositories/post_add_favorite_rqst.dart';
import '../repositories/post_cart_rqst.dart';
import '../repositories/post_check_phone_rsp.dart';
import '../repositories/post_confirm_order_rsp.dart';
import '../repositories/post_create_address_book_rqst_bodies.dart';
import '../repositories/post_create_shipping_order.dart';
import '../repositories/post_create_shipping_order_rsp.dart';
import '../repositories/post_create_vnpay_rqst_bodies.dart';
import '../repositories/post_create_vnpay_rsp.dart';
import '../repositories/post_repurchase_rqst.dart';
import '../repositories/post_set_default_address_rqst.dart';
import '../repositories/post_signin_rsp.dart';
import '../repositories/put_change_password_rqst.dart';
import '../repositories/put_update_user_rqst.dart';
part 'service.g.dart';

@RestApi(baseUrl: GlobalData.baseUrl)
abstract class Services {
  factory Services(Dio dio, {String baseUrl}) = _Services;

  @GET('api/auth/get_products')
  Future<GetProductRsp> getProductRsp({@Body() required GetProductRqQuery query});

  @GET('api/auth/banners')
  Future<GetBannerRsp> getBannerRsp();

  @GET("api/auth/get_product_by_id/{id}")
  Future<GetProductByIdRsp> getProductByIdRsp({@Path('id') required String id});

  @GET("api/auth/categories")
  Future<GetCategoryRsp> getCategoryRsp();
  @GET("api/auth/get_products?product_name={name}&perPage={page}")


  @GET("api/auth/get_products/?category_id={categoryId}&perPage=10")
  Future<GetProductRsp> getProductByIdCategoryRsp(
      {@Path('categoryId') required int categoryId});

  @GET("api/auth/get_manufacturers?perPage=23")
  Future<GetBrandRsp>getBrandRsp();

  // @GET("api/normal/set_session")
  // Future<GetSessionRsp> getSessionRsp();

  @POST("api/normal/add_to_cart")
  Future postAddCart({@Body() required PostCartRqst body});

  @GET("api/normal/get_cart")
  Future<GetCartRsp> getCartRsp();

  @PUT("api/normal/update_cart_detail/{id_cart}")
  Future postUpdateCartDetailRsp(
      {@Path('id_cart') required String idCart,
      @Body() required PostUpdateCartDetailRqst body});


  @DELETE("api/normal/remove_cart_detail/{id_cart}")
  Future deleteCartDetails({@Path('id_cart') required String idCart});

  @GET("api/normal/get_vouchers")
  Future<GetVoucherRsp> getVoucherRsp();

  @POST("api/normal/add_voucher")
  Future postAddVoucher({@Body() required PostAddVoucher body});

  @DELETE("api/normal/remove_voucher/{cartId}")
  Future deleteVoucher({@Path('cartId') required int cartId});

  @POST("auth/login")
  Future<PostSigninRsp> postSigninRsp({@Body() required PostSigninRqst body});

  @POST("api/auth/user/check-phone")
  Future<PostCheckPhoneRsp>postCheckPhoneRsp({@Body() required PostCheckPhoneRqstBodies body});

  @POST("auth/register")
  Future postRegister({@Body() required PostRegisterRqstBodies body});

  @GET("api/auth/view-user")
  Future<GetUserProfileRsp>getUserProfileRsp();

  @POST("api/auth/create_address_books")
  Future postCreateAddressBook({@Body() required PostCreateAddressBookRqstBodies body});

  @GET("api/auth/get_address_books")
  Future<GetAddressBookRsp>getAddressBookRsp();

  @PUT("api/auth/update_address_books/{id}")
  Future putUpdateAddressBook({@Path("id") required String id, @Body() required PostCreateAddressBookRqstBodies body });

  @POST("api/auth/confirm_address_books")
  Future confirmAddressBook({@Body() required PutUpdateAddressBookRqst? body});

  @POST("api/auth/create_shipping_order")
  Future<PostCreateShippingOrderRsp>postCreateShippingOrder({@Body() required PostCreateShippingOrder body});

  @POST("api/auth/confirm_order")
  Future<PostConfirmOrderRsp> postConfirmOrder({@Body() required PostConfirmOrderRqstBodies body});

  @GET("api/auth/get_order_by_user_id")
  Future<GetOrderRsp>getOrderRsp({@Queries() required GetOrderRqst query});

  @POST("api/auth/vnpay_create_payment")
  Future<PostCreateVnpayRsp>createVnPay({@Body() required PostCreateVnpayRqstBodies body});

  @DELETE("api/normal/remove_cart/{id}")
  Future deleteRemoveCart({@Path('id') required String id});

  @PUT("api/auth/cancel_order/{id}")
  Future cancelOrder({@Path('id') required String id});

  @POST("api/auth/upload_avatar")
  @MultiPart()
  Future uploadImage(@Part() File image);
  
  @PUT("api/auth/update-user")
  Future putUpdateUser({@Body() required PutUpdateUserRqst body });

  @POST("api/auth/add_to_favorite")
  Future postAddFavorite({@Body() required PostAddFavoriteRqst body  });

  @DELETE("api/auth/remove_product_from_favorites")
  Future deleteFavorite({@Body() required PostAddFavoriteRqst body  });

  @GET("api/auth/get_favorite_product")
  Future<GetProductRsp> getProductFavoriteRsp({@Body() required GetProductRqQuery query});

  @PUT("api/auth/users/change-password")
  Future putChangePassword({@Body() required PutChangePasswordRqst body});

  @POST("api/auth/set_default_address")
  Future postSetDefaultAddress({@Body() required PostSetDefaultAddressRqst body});

  @POST("api/normal/add_to_product_cart")
  Future postRepurchase({@Body() required PostRepurchaseRqst body});

  @GET("api/auth/get_order_by_id/{id}")
  Future<GetOrderByIdRsp>getOrderByIdRsp({@Path('id') required String? id});

  @GET("api/auth/get_comments")
  Future<GetCommentResponse>getCommentRsp({@Queries() required GetCommentQueries query});

  @POST("api/auth/add_comment")
  Future postAddComment({@Body() required PostAddCommentRqst bodies});
}
