import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../address_bottom_sheet_logic.dart';
class AddressDistrictPage extends StatelessWidget {
  final String? idCity;

  const AddressDistrictPage({Key? key, this.idCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));

    // logic.getDistrict(idCity ?? "");

    return Obx(() {

      return ListView.separated(
        itemCount: logic.getDistrictRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              logic.disTxt.value = '';
              logic.wardOld.value = '';
              logic.wardTxt.value='';
              logic.disTxt.value = '${logic.getDistrictRsp.value?.results[index].name}';

              await logic.logicAdd.setDistrict(
                  districtNames: '${logic.getDistrictRsp.value?.results[index].name}',
                  districtIds: '${logic.getDistrictRsp.value?.results[index].code}'
              );
              await logic.getWard(
                  logic.logicAdd.districtId.value ?? "");
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