import 'package:app_ft_tmart/src/data/respository/get_product_rsp.dart';
import 'package:app_ft_tmart/src/data/respository/post_update_cart_detail_rqst.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/config.dart';
import '../respository/get_banner_rsp.dart';
import '../respository/get_cart_rsp.dart';
import '../respository/get_category_rsp.dart';
import '../respository/get_product_by_category_rsp.dart';
import '../respository/get_product_by_id_rsp.dart';
import '../respository/get_search_rsp.dart';
import '../respository/get_session_rsp.dart';
import '../respository/get_slider_prod_rsp.dart';
import '../respository/post_cart_rqst.dart';
part 'service.g.dart';



@RestApi(baseUrl: EnvironmentConfig.baseUrl)
abstract class Services{
  factory Services(Dio dio,{String baseUrl}) = _Services;

  @GET('auth/get_products?perPage={page}')
  Future<GetProductRsp>getProductRsp({@Path('page') required int page});
  @GET('auth/banners')
  Future<GetBannerRsp>getBannerRsp();
  @GET("auth/get_product_by_id/{id}")
  Future<GetProductByIdRsp>getProdutByIdRsp({@Path('id') required String id});
  @GET("auth/categories")
  Future<GetCategoryRsp>getCategoryRsp();
  @GET("auth/get_products?product_name={name}&perPage={page}")
  Future<GetProductRsp>getSearchRsp({@Path('name') required String name, @Path('page') required int page});
  @GET("auth/get_products/?category_id={categoryId}&perPage=10")
  Future<GetProductRsp>getProductByIdCategoryRsp({@Path('categoryId') required int categoryId});
  @GET("normal/set_session")
  Future<GetSessionRsp>getSessionRsp();
  @POST("normal/add_to_cart")
  Future postAddCart({@Body() required  PostCartRqst body});
  @GET("normal/get_cart?guest_session={session}")
  Future<GetCartRsp>getCartRsp({@Path('session') required String session});
  @PUT("normal/update_cart_detail/{id_cart}")
  Future postUpdateCartDetailRsp({@Path('id_cart')required String idCart, @Body() required PostUpdateCartDetailRqst body});
  @DELETE("normal/remove_cart_detail/{id_cart}")
  Future deleteCartDetails({@Path('id_cart') required String idCart});











}