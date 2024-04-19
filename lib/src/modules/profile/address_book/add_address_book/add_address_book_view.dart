import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/profile/address_book/address_bottom_sheet/address_bottom_sheet_view.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../address_bottom_sheet/address_bottom_sheet_logic.dart';
import 'add_address_book_logic.dart';
import '../../../../data/repositories/get_address_book_rsp.dart';

class AddAddressBookPage extends StatelessWidget {
  final Data? data;
  final bool? onUpdate;

  const AddAddressBookPage({Key? key, this.data, this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddAddressBookLogic());
    final logicBottom = Get.put(AddressBottomSheetLogic(Get.find()));
    logic.setOnDefault(data?.isDefault??0);
    logic.data.value = data;
    logic.onUpdate.value = onUpdate;
    
    return WillPopScope(
      onWillPop: () async {
        logic.onUpdate.isFalse;
        logic.fullAddressControl.text = "";
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Obx(() {
            return Visibility(
              visible: logic.onUpdate.value == false,
              replacement: const Text(
                'Sửa địa chỉ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              child: const Text(
                'Thêm địa chỉ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            );
          }),
          centerTitle: true,
        ),
        body: Form(
          key: logic.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Thông tin liên hệ"),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Vui lòng nhập họ tên";
                  }
                  return null;
                },
                controller: logic.fullNameControl,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Họ và tên',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              const Divider(
                height: 0.1,

                color: Color(0xffADADAD),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Vui lòng nhập số điện thoại Việt Nam';
                  }
                  if (value?.trim().length != 10) {
                    return 'Vui lòng nhập đúng 10 số điện thoại';
                  }
                  if (!RegExp(r'^0?[3|5|7|8|9][0-9]{8}$')
                      .hasMatch(value ?? "")) {
                    return 'Vui lòng nhập đúng số điện thoại Việt Nam';
                  }
                  return null;
                },
                controller: logic.phoneControl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Điện thoại',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Địa chỉ"),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Vui lòng chọn địa chỉ";
                  }
                  return null;
                },
                maxLines: 2,
                controller: logic.fullAddressControl,
                onTap: () {
                  Get.bottomSheet(
                      isScrollControlled: true,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .7,
                        child: AddressBottomSheetPage(
                          cityName: logic.cityName.value,
                          districtName: logic.districtName.value,
                          wardName: logic.wardName.value,
                          cityId: logic.cityId.value,
                          districtId: logic.districtId.value,
                          wardId: logic.wardId.value,
                        ),
                      ));
                },
                readOnly: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Tỉnh/Thành phố, Quận/Huyện, Phường/Xã',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              const Divider(
                height: 0.1,
                color: Color(0xffADADAD),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Vui lòng nhập địa chỉ";
                  }
                  return null;
                },
                controller: logic.streetControl,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Tên đường, Tòa nhà, Số nhà',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              
              Visibility(
                visible: data?.id!=null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Thiết lập"),
              ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Đặt làm địa chỉ mặc định"),
                          ),
                          Obx(() => Visibility(
                            visible: data?.isDefault!=1,
                            replacement: Switch(
                              activeColor: XColor.primary,
                                value: true,
                                onChanged: (val) async{
                                  Get.dialog(
                                    AlertDialog(
                                      content: const Text("Để hủy địa chỉ mặc định này, vui lòng chọn địa chỉ khác làm địa chỉ mặc định mới",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: ()=>Get.back(),
                                           child: const Text("Đồng ý")
                                           )
                                      ],
                                    )
                                  );
                                }),
                            child: Switch(
                                value: logic.onDefault.value,
                                onChanged: (val) async{
                                  if(logic.onDefault.value==true){
                                    logic.onDefault.value = false;
                                    print(">>>>>>>>>>>>>${logic.onDefault.value}");
                                  }
                                  else {
                                    logic.onDefault.value = true;
                                    await logic.postSetDefaultAddress(data?.id);
                                     print(">>>>>>>>>>>>>${logic.onDefault.value}");
                                  }
                                }),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .85,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                    onPressed: () async {
                      if (logic.formKey.currentState?.validate() == true) {
                        await logic.onPressed();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text("Hoàn thành",style: TextStyle(
                        color: Colors.white
                      ),),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
