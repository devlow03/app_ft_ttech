import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/profile/setting/reset_password/reset_password_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/global_textfield.dart';
import '../../../index/index_view.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ResetPasswordLogic());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: logic.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: GlobalTextField(
                          title: "Mật khẩu cũ",

                          controller: logic.oldPasswordController,
                          // prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                          hint: 'Nhập mật khẩu cũ',
                          validator: Validator.password,
                          textInputType: TextInputType.visiblePassword,
                          security: true,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: GlobalTextField(
                          controller: logic.passwordController,

                          title: "Mật khẩu mới",
                          // prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                          hint: 'Nhập mật khẩu mới',
                          validator: Validator.password,
                          textInputType: TextInputType.visiblePassword,
                          security: true,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: GlobalTextField(
                          controller: logic.rePasswordController,
                          title: "Nhập lại mật khẩu mới",
                          hint: 'Nhập lại mật khẩu mới',
                          validator: (value) {
                            Validator.rePassword(
                                value, logic.passwordController.text);
                          },
                          textInputType: TextInputType.visiblePassword,
                          // validator: Validator.password,
                          security: true,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (logic.formKey.currentState?.validate() ==
                                true) {
                              await logic.putChangePassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: XColor.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Xác nhận",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
