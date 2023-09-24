import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/xcolor.dart';
import 'address_bottom_sheet_logic.dart';

class AddressBottomSheetPage extends StatelessWidget {
  final TextEditingController addressControl;
  const AddressBottomSheetPage({Key? key, required this.addressControl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));

    return Scaffold(

        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Địa chỉ",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        body: Obx(() {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)
                      )
                  ),
                  child: TabBar(
                    indicatorColor: XColor.primary,
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w700),
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    tabs: [
                      Tab(
                        child: Visibility(
                          visible: logic.cityTxt.value?.isNotEmpty==true,
                            replacement: Text('Chọn tỉnh',),
                          child: Text('${logic.cityTxt.value}',
                          style: TextStyle(
                            color: XColor.primary
                          ),
                          ),

                        ),
                      ),
                      Visibility(
                        visible: logic.getDistrictRsp.value?.results
                            .isNotEmpty == true,
                        child: Tab(
                          child: Visibility(
                            visible: logic.disTxt.value?.isNotEmpty==true,
                            replacement: Text('Chọn huyện',),
                            child: Text('${logic.disTxt.value}',
                              style: TextStyle(
                                  color: XColor.primary
                              ),
                            ),

                          ),
                        ),
                      ),
                      Visibility(
                        visible: logic.getWardRsp.value?.results?.isNotEmpty ==
                            true,
                        child: Tab(
                          child: Visibility(
                            visible: logic.wardTxt.value?.isNotEmpty==true,
                            replacement: Text('Chọn xã',),
                            child: Text('${logic.wardTxt.value}',
                              style: TextStyle(
                                  color: XColor.primary
                              ),
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(

                    children: [
                      AddressCityPage(),
                      AddressDistrictPage(),
                      AddressWardPage(addressControl: addressControl,)
                    ],
                  ),
                )
              ],
            ),
          );
        })
    );
  }
}

class AddressCityPage extends StatelessWidget {
  final String? cityText;

  const AddressCityPage({Key? key, this.cityText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));

    return Obx(() {
      return ListView.separated(
        itemCount: logic.getProvinceRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              logic.cityTxt.value = '${logic.getProvinceRsp.value?.results[index].name}';
              logic.disTxt.value=null;
              print(">>>>>>>>>>>>>tabIndex: ${logic.addressIndex.value}");
              await logic.getDistrict(
                  logic.getProvinceRsp.value?.results[index].code ?? "");
              DefaultTabController.of(context).animateTo(1);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${logic.getProvinceRsp.value?.results[index].name}'),
                  Icon(Icons.arrow_forward_ios_outlined, size: 18,
                    color: Colors.grey,)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 5,
            color: Colors.grey.shade400,
          );
        },
      );
    });
  }
}

class AddressDistrictPage extends StatelessWidget {
  final String? idCity;

  const AddressDistrictPage({Key? key, this.idCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));

    logic.getDistrict(idCity ?? "");
    return Obx(() {
      return ListView.separated(
        itemCount: logic.getDistrictRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              logic.disTxt.value = '${logic.getDistrictRsp.value?.results[index].name}';
              logic.wardTxt.value=null;
              await logic.getWard(
                  logic.getDistrictRsp.value?.results[index].code ?? "");
              DefaultTabController.of(context).animateTo(2);
            },
            child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${logic.getDistrictRsp.value?.results[index].name}'),
                  Icon(Icons.arrow_forward_ios_outlined, size: 18,
                    color: Colors.grey,)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 10,
            color: Colors.grey,
          );
        },
      );
    });
  }
}

class AddressWardPage extends StatelessWidget {
  final String? idDis;
  final TextEditingController addressControl;

  const AddressWardPage({Key? key, this.idDis, required this.addressControl,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));



    return Obx(() {
      return ListView.separated(
        itemCount: logic.getWardRsp.value?.results?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              logic.wardTxt.value = '${logic.getWardRsp.value?.results?[index].name}';
              addressControl.text = "${logic.wardTxt.value}, ${logic.disTxt.value}, ${logic.cityTxt.value}";
              Get.back();
            },
            child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${logic.getWardRsp.value?.results?[index].name}'),
                  Icon(Icons.arrow_forward_ios_outlined, size: 18,
                    color: Colors.grey,)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 10,
            color: Colors.grey,
          );
        },
      );
    });
  }
}
