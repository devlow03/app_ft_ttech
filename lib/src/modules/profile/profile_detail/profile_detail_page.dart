import 'package:app_ft_tmart/src/core/validator.dart';
import 'package:app_ft_tmart/src/modules/profile/address_book/address_bottom_sheet/address_bottom_sheet_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_logic.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pick_image/pick_image_logic.dart';
import 'profile_detail_logic.dart';
import 'text_field_profile/text_field_profile.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileDetailLogic());

    // logic.logicProfile.getUserProfile();
    return WillPopScope(
      onWillPop: ()async{
        logic.readOnly.value = true;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: const Text(
            'Tài khoản',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          actions: [
            Obx(() => Visibility(
                  visible: logic.readOnly.value == true,
                  replacement: IconButton(
                      onPressed: () {
                        logic.readOnly.value = true;
                      },
                      icon: const Icon(Icons.edit_off)),
                  child: IconButton(
                      onPressed: () {
                        logic.readOnly.value = false;
                      },
                      icon: const Icon(Icons.edit)),
                ))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            logic.logicProfile.getUserProfile();
          },
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              Obx(() => Form(
                key: logic.formKey,
                child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: logic.pickImage.image.value != null
                              ? FileImage(
                                  logic.pickImage.image.value!,
                                ) as ImageProvider
                              : NetworkImage(
                                  logic.networkImage.value ?? "",
                                ),
                          child: IconButton(
                              onPressed: () {
                                logic.postUpdateAvatar();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFieldProfile(
                          title: "ID",
                          controller: logic.idController,
                          readOnly: true,
                        ),
                        // TextFieldProfile(
                        //   title: "Tên Người dùng",
                        //   controller: logic.userNameController,
                        //   readOnly: true,
                        // ),
                        TextFieldProfile(
                          title: "Họ tên",
                          controller: logic.fullNameController,
                          readOnly: logic.readOnly.value,
                          validator: Validator.fullname,
                        ),
                        TextFieldProfile(
                          title: "Ngày sinh",
                          controller: logic.birthdayController,
                           readOnly: true,
                           validator: Validator.birthday,
                           suffix: Visibility(
                            visible: logic.readOnly.value == false,
                             child: InkWell(
                              onTap: (){
                                logic.selectDate(context);
                              },
                              child: const Icon(Icons.date_range,size: 20,),
                             ),
                           ),
                          
                        ),
                        TextFieldProfile(
                          title: "Điện thoại",
                          controller: logic.phoneController,
                           readOnly: logic.readOnly.value,
                           validator: Validator.phone,
                           textInputType: TextInputType.phone,
                        ),
                        TextFieldProfile(
                          title: "Email",
                          controller: logic.emailController,
                           readOnly: logic.readOnly.value,
                          // 8
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                            visible: logic.readOnly.value == false,
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .8,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30))),
                                  onPressed: ()async{
                                    if(logic.formKey.currentState?.validate()==true){
                                      await logic.putUpdateUser();
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text("Cập nhật",style: TextStyle(
                                      color: Colors.white
                                    ),),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
