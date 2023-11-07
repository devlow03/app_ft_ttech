import 'package:app_ft_tmart/src/module/profile/address_book/add_address_book/add_address_book_view.dart';
import 'package:app_ft_tmart/src/module/profile/address_book/edit_address_book/edit_address_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import 'address_book_logic.dart';


class AddressBookPage extends StatelessWidget {

  const AddressBookPage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddressBookLogic());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Sổ địa chỉ',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: ListView(
        // shrinkWrap: true,
        children: [
          const SizedBox(height: 10,),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Obx(() {
                if(logic.getAddressBookRsp.value?.data?.isEmpty==true){
                  return Center(
                    child: Text("chưa có sổ địa chỉ!"),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: logic.getAddressBookRsp.value?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = logic.getAddressBookRsp.value?.data?[index];
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.to(EditAddressBookPage(data: data,)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(
                                  //     color: Colors
                                  //         .grey.shade500,
                                  //     width: 1
                                  //
                                  // )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle
                                            .of(context)
                                            .style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "${data?.fullName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Colors.black,
                                                letterSpacing: 1
                                            ),
                                          ),

                                          // TextSpan(
                                          //   text: '${logic
                                          //       .address[index]["status"]}',
                                          //   style: TextStyle(
                                          //
                                          //     fontSize: 14,
                                          //     color: XColor.primary,
                                          //   ),
                                          // ),
                                        ],
                                      ),),
                                    const SizedBox(height: 10,),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Địa chỉ: ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                )
                                            ),
                                            TextSpan(
                                                text: "${data?.fullAddress}",
                                                style: TextStyle(
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
                                            TextSpan(
                                                text: 'Điện thoại: ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                )
                                            ),
                                            TextSpan(
                                                text: "${data?.phone}",
                                                style: TextStyle(
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
                        Obx(() {
                          return Radio(
                            value: logic.getAddressBookRsp.value?.data?[index].id,
                            activeColor: XColor.primary,
                            groupValue: logic.selectValue.value,
                            onChanged: (value) {
                              // logic.selectValue.value = value;
                              print(">>>>>>>${logic.selectValue.value}");
                            },
                          );
                        }),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20,);
                  },

                );
              })
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white
          ),
          onPressed: () {
            Get.to(AddAddressBookPage());
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
