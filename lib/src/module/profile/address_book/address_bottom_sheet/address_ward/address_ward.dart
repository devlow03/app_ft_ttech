import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../address_bottom_sheet_logic.dart';
class AddressWardPage extends StatelessWidget {
  final String? idDis;


  const AddressWardPage({Key? key, this.idDis, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBottomSheetLogic(Get.find()));


    return Obx(() {
      return ListView.separated(
        itemCount: logic.getWardRsp.value?.results?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async{

              logic.wardTxt.value = '${logic.getWardRsp.value?.results?[index].name}';
              // addressControl.text = "${logic.wardTxt.value}, ${logic.disTxt.value}, ${logic.cityTxt.value}";
              logic.logicAdd.fullAddressControl.clear();
              await logic.logicAdd.setWard(
                  wardNames: '${logic.getWardRsp.value?.results?[index].name}',
                  wardIds: '${logic.getWardRsp.value?.results?[index].code}'
              );
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