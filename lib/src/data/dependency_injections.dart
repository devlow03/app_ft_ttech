
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/data/services/tiki_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart'as GET;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjections implements GET.Bindings {
  @override
  Future<void> dependencies() async {
    final encryptedSharedPreferences = await GET.Get.putAsync(_encryptedSharedPreferences);
    final dio = await GET.Get.putAsync(() => _dio(encryptedSharedPreferences));
    GET.Get.put(Services(dio));
    GET.Get.put(TikiService(dio));


  }

  Future<Dio> _dio(EncryptedSharedPreferences encryptedSharedPreferences) async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = await prefs.getString("token")??"";
          var fileResponse = await DefaultCacheManager().getFileFromCache(options.uri.toString());
          if (fileResponse != null && fileResponse.file.existsSync()) {
            handler.resolve(Response(
              requestOptions: options,
              statusCode: 200,
              data: await fileResponse.file.readAsBytes(),
            ));
          } else {
            handler.next(options);
          }
          // options.headers = {
          //   // "Authorization": "Bearer $token",
          //   // ...options.headers,
          // };
          // handler.next(options);
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
