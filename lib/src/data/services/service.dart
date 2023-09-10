import 'package:app_ft_tmart/src/data/respository/get_product_rsp.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/config.dart';
import '../respository/get_banner_rsp.dart';
import '../respository/get_category_rsp.dart';
import '../respository/get_product_by_category_rsp.dart';
import '../respository/get_product_by_id_rsp.dart';
import '../respository/get_search_rsp.dart';
import '../respository/get_slider_prod_rsp.dart';
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










}