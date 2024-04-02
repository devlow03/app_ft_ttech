import 'package:app_ft_tmart/src/modules/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
// import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart'
//     as uifb;
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart' as uigg;

import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatelessWidget {
  final bool? intoCart;
  const SignInPage({Key? key, this.intoCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SignInLogic());
    logic.intoCart.value = intoCart;
    return WillPopScope(
      onWillPop: () async {
        if (logic.intoCart.value == true) {
          Get.back();
        } else {
          Get.offAll(IndexPage());
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 40,),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Xin chào!\n',
                        style: TextStyle(
                            fontSize: 43,
                            color: XColor.primary,
                            fontWeight: FontWeight.w900,
                            height: 1.5
                        )),

                        const TextSpan(
                          text: 'Đăng nhập để tiếp tục',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5
                        ))

                      ]
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(

                  // decoration: const BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(30),
                  //     topRight: Radius.circular(30)
                  //   )
                  // ),
                  height: MediaQuery.of(context).size.height*.8,
                  child: Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 25,),
                        Form(
                          key: logic.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: GlobalTextField(
                                    controller: logic.phoneControl,

                                    title: 'Điện thoại',
                                    // prefixIcon: Icon(
                                    //   Icons.phone,
                                    //   color: XColor.primary,
                                    // ),
                                    hint: 'Nhập số điện thoại',
                                    validator: Validator.phone,
                                    textInputType: TextInputType.emailAddress,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: GlobalTextField(
                                    controller: logic.passControl,
                                   title: 'Mật khẩu',
                                    hint: 'Nhập mật khẩu',
                                    validator: Validator.password,
                                    textInputType: TextInputType.visiblePassword,
                                    // validator: Validator.password,
                                    security: true,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Quên mật khẩu?",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: XColor.primary,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (logic.formKey.currentState?.validate() ==
                                              true) {
                                            await logic.signIn(
                                                phone: logic.phoneControl.text,
                                                password: logic.passControl.text);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30)),
                                          primary: XColor.primary,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Đăng nhập",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Bạn chưa có tài khoản ?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 3),
                                        TextButton(
                                            onPressed: () {
                                              Get.to(const SignupPage());
                                            },
                                            child: Text(
                                              'Đăng ký',
                                              style: TextStyle(
                                                color: XColor.primary,
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (logic.intoCart.value == true) {
                                          Get.back();
                                        } else {
                                          Get.offAll(IndexPage());
                                        }
                                      },
                                      child: const Center(
                                          child: Text(
                                            "Trở về",
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Obx(() => Visibility(
                          visible: logic.onLocalAuth.value == true && logic.checkAuth.value==true,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  logic.signInwithBiometric();
                                },
                                child: Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Obx(() => Visibility(
                                          visible:
                                          logic.biometric.value == "finger",
                                          replacement: Image.asset(
                                            "assets/images/face_id.png",
                                            height: 50,
                                            width: 50,
                                          ),
                                          child: Icon(
                                            Icons.fingerprint,
                                            size: 30,
                                            color: XColor.primary,
                                          ),
                                        )),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: Text(
                                    "${logic.biometric.value == "finger" ? "Đăng nhập bằng vân tay" : "Đăng nhập bằng Face ID"}",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
