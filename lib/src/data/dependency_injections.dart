
import 'package:app_ft_tmart/src/core/config.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart'as GET;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DependencyInjections implements GET.Bindings {
  @override
  Future<void> dependencies() async {
    final encryptedSharedPreferences = await GET.Get.putAsync(_encryptedSharedPreferences);
    final dio = await GET.Get.putAsync(() => _dio(encryptedSharedPreferences));
    GET.Get.put(Services(dio));



  }

  Future<Dio> _dio(EncryptedSharedPreferences encryptedSharedPreferences) async {
    var dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(

    ),
    );
    dio.interceptors.add(TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,

        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),);


      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String token  = await prefs.getString(GlobalData.token)??"";
          var fileResponse = await DefaultCacheManager().getFileFromCache(options.uri.toString());
          if (fileResponse != null && fileResponse.file.existsSync()) {
            handler.resolve(Response(
              requestOptions: options,
              statusCode: 200,
              data: await fileResponse.file.readAsBytes(),

            ));
          } else {
            options.headers = {
              "Access-Control-Allow-Origin": "*",
              "Authorization": "Bearer ${token}",

              ...options.headers,
            };
            handler.next(options);
          }

        },
          onError: ( error, handler) {
            // Xử lý lỗi
            handler.next(error);
          },
        onResponse: (response,handler)async{
          if (response.statusCode == 200 && response.data is List<int>) {
            await DefaultCacheManager().putFile(response.requestOptions.uri.toString(), response.data);
          }
          handler.next(response);
        }
      ));
      return dio;

    }



  Future<EncryptedSharedPreferences> _encryptedSharedPreferences() async {
    var shared = EncryptedSharedPreferences(
      mode: AESMode.sic,
      randomKeyKey: 'qt356@TTech',
      randomKeyListKey: 'qt356@TTech',
    );
    return shared;
  }
}
