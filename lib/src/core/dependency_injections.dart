
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart'as GET;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/index/index_view.dart';


class DependencyInjections implements GET.Bindings {
  @override
  Future<void> dependencies() async {
    final encryptedSharedPreferences = await GET.Get.putAsync(_encryptedSharedPreferences);
    final dio = await GET.Get.putAsync(() => _dio(encryptedSharedPreferences));
    GET.Get.put(Services(dio));



  }

  Future<Dio> _dio(EncryptedSharedPreferences encryptedSharedPreferences) async {
    var dio = Dio();
    if(kDebugMode){
      dio.interceptors.add(CurlLoggerDioInterceptor(
          printOnSuccess: true
      ));
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }


      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          var fileResponse = await DefaultCacheManager().getFileFromCache(options.uri.toString());
          if (fileResponse != null && fileResponse.file.existsSync()) {
            handler.resolve(Response(
              requestOptions: options,
              statusCode: 200,
              data: await fileResponse.file.readAsBytes(),

            ));
          } else {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            String token =  prefs.getString(GlobalData.token)!=null? prefs.getString(GlobalData.token)??"":GlobalData.storeToken;
            options.headers = {
              "Access-Control-Allow-Origin": "*",
              "Authorization": "Bearer $token",

              ...options.headers,
            };
            handler.next(options);
          }

        },
          onError: ( error, handler) async{
          if(error.response?.statusCode == HttpStatus.unauthorized){
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            
            if(prefs.get(GlobalData.token)!= null){
              prefs.remove(GlobalData.token);
            GET.Get.offAll( IndexPage());
            Fluttertoast.showToast(msg: "Tài khoản này đã đăng nhập ở thiết bị khác!");
            handler.next(error);
            }
            else{
              handler.next(error);
            }
          }
          else{
            handler.next(error);
          }


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
