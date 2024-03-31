import 'package:app_ft_tmart/src/modules/profile/address_book/add_address_book/add_address_book_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/xcolor.dart';

import 'address_bottom_sheet_logic.dart';
import 'address_city/address_city.dart';
import 'address_district/address_district.dart';
import 'address_ward/address_ward.dart';

class AddressBottomSheetPage extends StatelessWidget {
  final String? cityName;
  final String? cityId;
  final String? districtId;
  final String? wardId;
  final String? districtName;
  final String? wardName;

  const AddressBottomSheetPage({Key? key, this.cityId, this.districtId, this.wardId, this.cityName, this.districtName, this.wardName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));
    logic.logicAdd.cityId.value = cityId;
    logic.logicAdd.districtId.value = districtId;
    logic.logicAdd.wardId.value = wardId;
    logic.cityOld.value = cityName??"";
    logic.disOld.value = districtName;
    logic.cityTxt.value = cityName??"";
    logic.disTxt.value = districtName;
    logic.wardTxt.value = wardName;



    return WillPopScope(
      onWillPop: ()async{
        // logic.cityTxt.value = '';
        // logic.disTxt.value = '';
        // logic.wardTxt.value = '';
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
        ),
        child: Scaffold(

            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text("Địa chỉ",
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
                        unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w700),
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                        tabs: [
                          Tab(
                            child: Visibility(
                              visible: logic.cityTxt.value?.isNotEmpty==true,
                                replacement: const Text('Chọn tỉnh',),
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
                                replacement: const Text('Chọn huyện',),
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
                                replacement: const Text('Chọn xã',),
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
                    const Expanded(
                      child: TabBarView(
                        children: [
                          AddressCityPage(),
                          AddressDistrictPage(),
                          AddressWardPage()
                        ],
                      ),
                    )
                  ],
                ),
              );
            })
        ),
      ),
    );
  }
}






