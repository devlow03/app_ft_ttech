import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../order/order_logic.dart';
import 'address_logic.dart';
class AddressPage extends StatelessWidget {
  final String? cityText ;
  final String? disText ;
  final String? wardText ;
   AddressPage({super.key, this.cityText, this.disText, this.wardText});
  final List<Widget> pages = [
    AddressCityPage(),
    AddressDistrictPage(),
    AddressWardPage()
  ];

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(AddressLogic(Get.find()));

      return pages[logic.addressIndex.value];

  }
}


class AddressCityPage extends StatelessWidget {
  final String? cityText ;
  const AddressCityPage({Key? key, this.cityText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressLogic(Get.find()));
    final logicOder = Get.put(OrderLogic());
    return Obx(() {
      return ListView.separated(
        itemCount: logic.getProvinceRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()async{
              logicOder.cityControl.text = logic.getProvinceRsp.value?.results[index].name??"";
              Get.back();
              await logic.getDistrict(logic.getProvinceRsp.value?.results[index].code??"");
              Get.bottomSheet(
                isScrollControlled: true,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: AddressDistrictPage(),
                ),
              );

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text('${logic.getProvinceRsp.value?.results[index].name}')),
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

class AddressDistrictPage extends StatelessWidget {
  final String? idCity;
  const AddressDistrictPage({Key? key, this.idCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressLogic(Get.find()));
    final logicOder = Get.put(OrderLogic());
    logic.getDistrict(idCity??"");
    return Obx(() {
      return ListView.separated(
        itemCount: logic.getDistrictRsp.value?.results.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()async{
              logicOder.disControl.text = logic.getDistrictRsp.value?.results[index].name??"";
              Get.back();
              await logic.getWard(logic.getDistrictRsp.value?.results[index].code??"");
              Get.bottomSheet(
                  isScrollControlled: true,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: AddressWardPage(idDis: logic.getDistrictRsp.value?.results[index].code??"",),
                  ),
                );


            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text('${logic.getDistrictRsp.value?.results[index].name}')),
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
  const AddressWardPage({Key? key, this.idDis,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressLogic(Get.find()));
    final logicOder = Get.put(OrderLogic());
    logic.getWard(idDis??"");

    return Obx(() {
      return ListView.separated(
        itemCount: logic.getWardRsp.value?.results?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              logicOder.wardControl.text = logic.getWardRsp.value?.results?[index].name??"";
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text('${logic.getWardRsp.value?.results?[index].name}')),
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
