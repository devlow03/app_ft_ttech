import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../address_bottom_sheet/address_bottom_sheet_view.dart';
import 'edit_address_book_logic.dart';
import '../../../../data/repositories/get_address_book_rsp.dart';

class EditAddressBookPage extends StatelessWidget {
  final Data? data;
  const EditAddressBookPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EditAddressBookLogic());
    logic.setAddressBook(data: data);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Sửa địa chỉ',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Thông tin liên hệ"),
          ),
          TextFormField(
            controller: logic.fullNameControl,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Họ và tên',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          TextFormField(
            controller: logic.phoneControl,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Điện thoại',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
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
            maxLines: 2,
            controller: logic.fullAddressControl,
            onTap: () {
              Get.bottomSheet(
                  isScrollControlled: true,
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.7,
                    child: AddressBottomSheetPage(
                      cityId: logic.cityId.value,
                      districtId: logic.districtId.value,
                      wardId: logic.wardId.value,
                    ),
                  )
              );
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
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          TextFormField(
            controller: logic.fullAddressControl,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Tên đường, Tòa nhà, Số nhà',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Thiết lập"),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Đặt làm địa chỉ mặc định"),
                ),
                Switch(value: true, onChanged: (val) {})
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async{
                  // await logic.postCreateAddressBook();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Hoàn thành"),
                )),
          )
        ],
      ),
    );
  }
}
