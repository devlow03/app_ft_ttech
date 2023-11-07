import 'package:app_ft_tmart/src/data/repositories/post_create_address_book_rqst_bodies.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/services/service.dart';
import '../../../../widget/utils.dart';
import '../address_book_logic.dart';

class AddAddressBookLogic extends GetxController {
  TextEditingController addressControl = TextEditingController();
  final Services tMartServices = Get.find();
  TextEditingController fullNameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController streetControl = TextEditingController();
  TextEditingController fullAddressControl = TextEditingController();
  Rxn<String>cityName = Rxn();
  Rxn<String>cityId = Rxn();
  Rxn<String>districtName = Rxn();
  Rxn<String>districtId = Rxn();
  Rxn<String>wardName = Rxn();
  Rxn<String>wardId= Rxn();
  final logicAddressBook = Get.put(AddressBookLogic());
  
  Future<void>postCreateAddressBook()async{
    Utils.loading(()async{
      await tMartServices.postCreateAddressBook(body: PostCreateAddressBookRqstBodies(
        fullName: fullNameControl.text,
        phone: phoneControl.text,
        cityName: cityName.value,
        cityId: num.parse(cityId.value??""),
        districtName: districtName.value,
        districtId: num.parse(districtId.value??""),
        wardName: wardName.value,
        wardId: wardId.value,
        fullAddress: "${streetControl.text}, ${fullAddressControl.text}"
      ));
      await logicAddressBook.getAddressBook();
      Get.back();
    });
  }
}
