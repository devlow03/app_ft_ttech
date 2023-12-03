import 'dart:convert';

import 'package:app_ft_tmart/src/data/repositories/put_update_address_book_rqst.dart';
import 'package:app_ft_tmart/src/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/repositories/get_address_book_rsp.dart';
import '../../../data/services/service.dart';
import '../../cart/cart_logic.dart';
import '../../order/order_logic.dart';

class AddressBookLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<Object> selectAddressBook = Rxn();
  Rxn<Map<String, dynamic>> mapAddressBook = Rxn();
  final logicCart = Get.put(CartLogic());
  final logic = Get.put(OrderLogic());
  Rxn<GetAddressBookRsp>getAddressBookRsp = Rxn();
  Rxn<bool>intoOrder = Rxn(false);
  @override
  void onReady()async{
    super.onReady();
    await getAddressBook();

  }


  Future<GetAddressBookRsp?>getAddressBook()async{
    Utils.loading(()async{
      getAddressBookRsp.value = await tMartServices.getAddressBookRsp();

    });
    return getAddressBookRsp.value;


  }

  Future<void>postConfirmAddressBook()async{
    Utils.loading(()async{
      await tMartServices.confirmAddressBook(
          body:PutUpdateAddressBookRqst(
            fullName: mapAddressBook.value?["full_name"],
            cityName: mapAddressBook.value?["city_name"],
            cityId: mapAddressBook.value?["city_id"],
            districtName: mapAddressBook.value?["district_name"],
            districtId: mapAddressBook.value?["district_id"],
            wardName: mapAddressBook.value?["ward_name"],
            wardId: mapAddressBook.value?["ward_id"],
            fullAddress: "${mapAddressBook.value?["full_address"]}, ${mapAddressBook.value?["ward_name"]}, ${mapAddressBook.value?["district_name"]}, ${mapAddressBook.value?["city_name"]} ",
            phone: mapAddressBook.value?["phone"],

          )
      );

        if(intoOrder.value == true){
          await logicCart.getCart();
          await logic.postCreateShipping(action: "p");
          Get.back();
          Fluttertoast.showToast(msg: "Đã chọn địa chỉ nhận hàng",gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_SHORT);
        }
        else{

          Fluttertoast.showToast(msg: "Đã chọn địa chỉ nhận hàng",gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_SHORT);
        }




    });

  }

  Future<void>selectAddress(Object?value)async {
    selectAddressBook.value = value;
    String jsonData = jsonEncode(selectAddressBook.value);
    mapAddressBook.value= json.decode(jsonData);
    await postConfirmAddressBook();


    // print(mapAddressBook.value?["full_name"]);
  }
}
