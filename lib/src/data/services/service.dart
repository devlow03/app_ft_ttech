import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/config.dart';
import '../respository/get_banner_rsp.dart';
import '../respository/get_category_rsp.dart';
import '../respository/get_product_by_category_rsp.dart';
import '../respository/get_search_rsp.dart';
import '../respository/get_slider_prod_rsp.dart';
part 'service.g.dart';



@RestApi(baseUrl: EnvironmentConfig.baseUrl)
abstract class Services{
  factory Services(Dio dio,{String baseUrl}) = _Services;

  @GET('api/v1/banner')
  Future<GetBannerRsp>getBanner();
  @GET('api/v1/category/{id}')
  Future<GetProductByCategoryRsp>getProductCategory({@Path('id') required String id });
  @GET('api/v1/category')
  Future<GetCategoryRsp>getCategory();
  @GET('api/v1/prod/slider/{id}')
  Future<GetSliderProdRsp>getSlider({@Path('id') required String id});
  @GET('api/v1/search/{name}')
  Future<GetSearchRsp>getSearch({@Path('name') required String name});





}