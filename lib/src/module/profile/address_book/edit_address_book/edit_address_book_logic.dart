import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/post_create_address_book_rqst_bodies.dart';
import '../../../../data/services/service.dart';
import '../../../../widget/utils.dart';
import '../address_book_logic.dart';
import '../../../../data/repositories/get_address_book_rsp.dart';
class EditAddressBookLogic extends GetxController {
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

  Future<void>setAddressBook({required Data? data})async{
    fullNameControl.text = data?.fullName??"";
    phoneControl.text = data?.phone??"";
    cityName.value = data?.cityName??"";
    cityId.value = data?.cityId.toString()??"";
    districtName.value = data?.districtName??"";
    districtId.value = data?.districtId.toString()??"";
    wardName.value = data?.wardName??"";
    wardId.value = data?.wardId.toString()??"";
    fullAddressControl.text = data?.fullAddress??"";
  }
}
