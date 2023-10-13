import 'dart:convert';

import 'package:get/get.dart';

class AddressBookLogic extends GetxController {
  Rxn<String> selectValue = Rxn();
  List<Map<String, String>> address = [
    {
      "id": "1",
      "status":"",
      "name": "Quang Thiện",
      "address": "149 Nguyễn Đệ, Phường An Hòa, Quận Ninh Kiều, Cần Thơ",
      "phoneNumber": "776506112"
    },
    {
      "id": "2",
      "status":"(Địa chỉ mặc định)",
      "name": "Nguyễn Văn A",
      "address": "Phường An Hòa, Quận Bình Thủy, Cần Thơ",
      "phoneNumber": "555-5678"
    },
    {
      "id": "3",
      "status":"",
      "name": "Nguyễn Văn B",
      "address": "Phường An Hòa, Quận Bình Thủy, Cần Thơ",
      "phoneNumber": "555-5678"
    }
  ];
}
