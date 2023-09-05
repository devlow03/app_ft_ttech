import 'package:app_ft_tmart/src/data/respository/get_product_rsp.dart';
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

  @GET('auth/get_products?perPage=20')
  Future<GetProductRsp>getProductRsp();







}