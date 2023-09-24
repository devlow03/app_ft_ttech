import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/respository/get_district_rsp.dart';
import '../../data/respository/get_province_rsp.dart';
import '../../data/respository/get_ward_rsp.dart';
import '../order/order_logic.dart';

class AddressLogic extends GetxController {
  Rxn<GetProvinceRsp>getProvinceRsp = Rxn();
  Rxn<GetDistrictRsp>getDistrictRsp = Rxn();
  Rxn<GetWardRsp>getWardRsp = Rxn();
  final Rx<int> addressIndex = Rx(0);
  final Dio dio;


  AddressLogic(this.dio);

  void onReady()async{
    super.onReady();
    await getProvince();
  }
  Future<GetProvinceRsp?> getProvince() async {
    final response = await dio.get("https://api.mysupership.vn/v1/partner/areas/province");

    // Kiểm tra xem response có dữ liệu không
    if (response.data is Map<String, dynamic>) {
      getProvinceRsp.value = GetProvinceRsp.fromJson(response.data as Map<String, dynamic>);
      print(jsonEncode(getProvinceRsp.value));
      return getProvinceRsp.value;
    } else {
      // Xử lý lỗi hoặc trả về giá trị mặc định khi response không phải là Map
      return null; // Hoặc trả về giá trị khác tùy theo trường hợp của bạn
    }
  }
  
  Future<GetDistrictRsp?>getDistrict(String idProvince)async{

    final response = await dio.get("https://api.mysupership.vn/v1/partner/areas/district?province=$idProvince");
    if (response.data is Map<String, dynamic>) {
      getDistrictRsp.value = GetDistrictRsp.fromJson(response.data as Map<String, dynamic>);
      print(jsonEncode(getProvinceRsp.value));
      return getDistrictRsp.value;
    } else {
      // Xử lý lỗi hoặc trả về giá trị mặc định khi response không phải là Map
      return null; // Hoặc trả về giá trị khác tùy theo trường hợp của bạn
    }
  }
  //
  Future<GetWardRsp?>getWard(String idDistrict)async{
    final response = await dio.get("https://api.mysupership.vn/v1/partner/areas/commune?district=$idDistrict");
    if (response.data is Map<String, dynamic>) {
      getWardRsp.value = GetWardRsp.fromJson(response.data as Map<String, dynamic>);
      print(jsonEncode(getProvinceRsp.value));
      return getWardRsp.value;
    } else {
      // Xử lý lỗi hoặc trả về giá trị mặc định khi response không phải là Map
      return null; // Hoặc trả về giá trị khác tùy theo trường hợp của bạn
    }
  }
}