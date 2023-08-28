import 'package:app_ft_tmart/src/data/tiki_respository/get_tiki_banner_rsp.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/config.dart';
import '../tiki_respository/get_tiki_top_seller_rsp.dart';
part 'tiki_service.g.dart';
@RestApi(baseUrl:EnvironmentConfig.tikiBanner)

abstract class TikiService{
  factory TikiService(Dio dio,{String baseUrl}) = _TikiService;

  @GET('widget/api/v1/banners-group?group=home_banner_main_v2')
  Future<GetTikiBannerRsp>getBanner();

}
@RestApi(baseUrl:EnvironmentConfig.tikiProd)
abstract class TiKiProd{
  @GET('raiden/v3/widgets/top_selling')
  Future<GetTikiTopSellerRsp>getTopSeller();
}