import 'dart:convert';

import 'package:app_ft_tmart/src/widget/utils.dart';
import 'package:get/get.dart';

import '../../../data/repositories/get_address_book_rsp.dart';
import '../../../data/services/service.dart';

class AddressBookLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<String> selectValue = Rxn();
  Rxn<GetAddressBookRsp>getAddressBookRsp = Rxn();
  @override
  void onReady()async{
    super.onReady();
    await getAddressBook();
  }
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

  Future<GetAddressBookRsp?>getAddressBook()async{
    Utils.loading(()async{
      getAddressBookRsp.value = await tMartServices.getAddressBookRsp();

    });
    return getAddressBookRsp.value;


  }
}
