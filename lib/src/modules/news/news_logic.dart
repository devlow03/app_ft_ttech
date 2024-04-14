import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../data/repositories/get_news_rsp.dart';

class NewsLogic extends GetxController {
  Rxn<GetNewsRsp>getNewsRsp = Rxn();
  final dio = Dio();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getNews();
  }
  @override

  void refresh()async{
    super.refresh();
    await getNews();
  }


  Future<GetNewsRsp?>getNews()async{
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
    final response = await dio.get("https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=dd382257ae6b4dd9a287a59462eb050a");
    getNewsRsp.value = GetNewsRsp.fromJson(response.data);
    print(jsonEncode(response.data));
    return getNewsRsp.value;
  }
}
