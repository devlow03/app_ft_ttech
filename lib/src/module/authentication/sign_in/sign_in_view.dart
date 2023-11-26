import 'package:app_ft_tmart/src/module/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart'
    as uifb;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart' as uigg;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Welcome, \n",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color(0xff3640E0),
                              fontWeight: FontWeight.bold,
                              height: 1)),
                      TextSpan(
                          text: "login to start with TMART 👋",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))
                    ])),
              ),
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
                            controller: logic.phoneControl,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: XColor.primary,
                            ),
                            hint: 'Nhập số điện thoại',
                            validator: Validator.phone,
                            textInputType: TextInputType.emailAddress,
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GlobalTextField(
                            controller: logic.passControl,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: XColor.primary,
                            ),
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
                            horizontal: 10, vertical: 50),
                        child: SizedBox(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: Color(0xff3640E0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * .4,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Text(
                    "Hoặc",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * .4,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 5,),
              ui.AuthStateListener(
                listener: (oldState, state, controller) {
                  if (state is ui.UserCreated) {
                    logic.socialSignin(
                      state.credential.user,
                    );
                  }
                  if (state is ui.SignedIn) {
                    logic.socialSignin(
                      state.user,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .92,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ui.OAuthProviderButton(
                          provider: uigg.GoogleProvider(
                              clientId:
                                  '392911829696-k7nv4b8c6cm0p3gi4jcmite6cj59vo5a.apps.googleusercontent.com'),
                        ),
                      ),

                      // Container(
                      //   width: MediaQuery.of(context).size.width*.95,
                      //   child: ui.OAuthProviderButton(
                      //     provider: uifb.FacebookProvider(clientId: '277551901591822', redirectUri: 'https://gas-luxen.firebaseapp.com/__/auth/handler'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản ?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 3),
                  TextButton(
                      onPressed: () {
                        Get.to(SignupPage());
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
                child: Center(
                    child: Text(
                  "Trở về",
                  style: TextStyle(color: Colors.black),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
