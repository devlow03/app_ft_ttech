import 'package:app_ft_tmart/src/data/repositories/post_create_address_book_rqst_bodies.dart';
import 'package:app_ft_tmart/src/data/repositories/put_update_address_book_rqst.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/services/service.dart';
import '../../../../widget/utils.dart';
import '../address_book_logic.dart';
import '../../../../data/repositories/get_address_book_rsp.dart';

class AddAddressBookLogic extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  Rxn<String>idAddressBook = Rxn();
  Rxn<bool>onUpdate = Rxn(false);
  Rxn<Data>data = Rxn();

  Future<void>setCity({required String cityNames, required String cityIds})async{
    cityName.value = cityNames;
    cityId.value = cityIds;
  }

  Future<void>setDistrict({required String districtNames, required String districtIds})async{
    districtName.value = districtNames;
    districtId.value = districtIds;
  }

  Future<void>setWard({required String wardNames, required String wardIds})async{
    wardName.value = wardNames;
   wardId.value = wardIds;
    fullAddressControl.text = "${wardName.value}, ${districtName.value}, ${cityName.value}";
  }
  
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
        fullAddress: "${streetControl.text}"
      ));
      await logicAddressBook.getAddressBook();
      Get.back();
    });
  }

  Future<void>setAddressBook()async{
    idAddressBook.value = data.value?.id.toString();
    fullNameControl.text = data.value?.fullName??"";
    phoneControl.text = data.value?.phone??"";
    cityName.value = data.value?.cityName??"";
    cityId.value = data.value?.cityId.toString()??"";
    districtName.value = data.value?.districtName??"";
    districtId.value = data.value?.districtId.toString()??"";
    wardName.value = data.value?.wardName??"";
    wardId.value = data.value?.wardId.toString()??"";
    fullAddressControl.text = data.value?.cityName!=null?"${data.value?.wardName}, ${data.value?.districtName}, ${data.value?.cityName}":'';
    streetControl.text = data.value?.fullAddress??"";

  }

  Future<void>putUpdateAddressBook()async{
   Utils.loading(()async{
     await tMartServices.putUpdateAddressBook(
         id: idAddressBook.value??"",
         body: PutUpdateAddressBookRqst(
             fullName: fullNameControl.text,
             phone: phoneControl.text,
             cityName: cityName.value,
             cityId: num.parse(cityId.value??""),
             districtName: districtName.value,
             districtId: num.parse(districtId.value??""),
             wardName: wardName.value,
             wardId: num.parse(wardId.value??""),
             fullAddress: "${streetControl.text}"
         )
     );
     await logicAddressBook.getAddressBook();
     Get.back();
   });
  }


  Future<void>onPressed()async{
    if(onUpdate.value==false){
      await postCreateAddressBook();
    }
    else{
      await putUpdateAddressBook();
    }
  }

  @override
  void onReady()async{
    super.onReady();
    await setAddressBook();
  }
}
