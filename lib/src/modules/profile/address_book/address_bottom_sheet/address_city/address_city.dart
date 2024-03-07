import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../address_bottom_sheet_logic.dart';
class AddressCityPage extends StatelessWidget {
  final String? cityName;
  final String? cityId;


  const AddressCityPage({Key? key, this.cityName, this.cityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));

    return Obx(() {
      logic.setAddress();
      return ListView.separated(
        itemCount: logic.getProvinceRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              // DefaultTabController.of(context).dispose();
              // logic.cityTxt.value = '';
              logic.disOld.value='';
              // logic.wardOld.value = '';
              logic.disTxt.value='';
              logic.wardTxt.value = '';

              logic.cityTxt.value = '${logic.getProvinceRsp.value?.results[index].name}';

              await logic.logicAdd.setCity(
                  cityNames: '${logic.getProvinceRsp.value?.results[index].name}',
                  cityIds: '${logic.getProvinceRsp.value?.results[index].code}'
              );
              print(">>>>>>>>>>>>>tabIndex: ${logic.addressIndex.value}");
              await logic.getDistrict(logic.logicAdd.cityId.value??"");
              DefaultTabController.of(context).animateTo(1);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${logic.getProvinceRsp.value?.results[index].name}'),
                  const Icon(Icons.arrow_forward_ios_outlined, size: 18,
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