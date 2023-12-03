import 'package:app_ft_tmart/src/module/profile/address_book/add_address_book/add_address_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import 'address_book_logic.dart';


class AddressBookPage extends StatelessWidget {
  final bool? intoOrder;
  const AddressBookPage({Key? key, this.intoOrder, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBookLogic());
    logic.intoOrder.value = intoOrder;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Sổ địa chỉ',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: ()async{
           logic.onReady();
        },
        child: ListView(
          // shrinkWrap: true,
          children: [
            const SizedBox(height: 10,),
      
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  if(logic.getAddressBookRsp.value?.data?.isEmpty==true){
                    return const Center(
                      child: Text("chưa có sổ địa chỉ!"),
                    );
                  }
      
                  return Column(
                    children: logic.getAddressBookRsp.value?.data?.map((e ){
                      return Column(
                        children: [
                          Visibility(
                            visible: logic.intoOrder.value==true,
                            replacement: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
      
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(e.fullName??"",
                                            style:const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Colors.black,
                                                letterSpacing: 1
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: (){
                                                Get.to(AddAddressBookPage(data: e,onUpdate: true,));
                                              },
                                              child: const Text("Sửa")
                                          )
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Địa chỉ: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "${e.fullAddress}, ${e.wardName}, ${e.districtName}, ${e.cityName}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                      height: 1.5
                                                  )
                                              )
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Điện thoại: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "${e.phone}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                      height: 1.5
                                                  )
                                              )
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
      
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RadioListTile(
                                    value: e,
                                    groupValue: logic.selectAddressBook.value,
                                    onChanged: (value)async{
                                     await logic.selectAddress(value);
                                    },
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(e.fullName??"",
                                           style:const TextStyle(
                                               fontWeight: FontWeight.w700,
                                               fontSize: 16,
                                               color: Colors.black,
                                               letterSpacing: 1
                                           ),
                                         ),
                                         TextButton(
                                             onPressed: (){
                                               Get.to(AddAddressBookPage(data: e,onUpdate: true,));
                                             },
                                             child: const Text("Sửa")
                                         )
                                       ],
                                     ),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Địa chỉ: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "${e.fullAddress}, ${e.wardName}, ${e.districtName}, ${e.cityName}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                      height: 1.5
                                                  )
                                              )
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Điện thoại: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "${e.phone}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                      height: 1.5
                                                  )
                                              )
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade300,
                          )
                        ],
                      );
                    }).toList()??[],
                  );
      
      
                })
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white
          ),
          onPressed: () {
            Get.to(const AddAddressBookPage(onUpdate: false,));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.add_circle_outline, color: XColor.primary,)
                    ),
                    TextSpan(
                        text: " Thêm địa chỉ mới",
                        style: TextStyle(
                            fontSize: 14,
                            color: XColor.primary
                        )
                    )
                  ]
              ),
            ),
          ),

        ),
      ),
    );
  }
}
