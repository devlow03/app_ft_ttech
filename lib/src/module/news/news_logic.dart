import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../data/respository/get_news_rsp.dart';

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
    final response = await dio.get("https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=dd382257ae6b4dd9a287a59462eb050a");
    getNewsRsp.value = GetNewsRsp.fromJson(response.data);
    print(jsonEncode(response.data));
    return getNewsRsp.value;
  }
}
