import 'package:app_ft_tmart/src/module/authentication/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart' as uifb;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart' as uigg;

import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SignInLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(child: Image.asset("assets/images/splash.png",
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .35,
            )),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Đăng nhập",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          Form(
            // key: logic.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:GlobalTextField(
                    prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                    hint: 'Nhập số điện thoại',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validator.phone,
                    textInputType: TextInputType.phone,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GlobalTextField(
                    prefixIcon: Icon(Icons.lock,color: XColor.primary,),
                    hint: 'Nhập mật khẩu',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validator.password,
                    textInputType: TextInputType.visiblePassword,
                    // validator: Validator.password,
                    security: true,

                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ElevatedButton(
                      onPressed: () async {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .4,
                  color: Colors.grey.shade200,
                ),
              ),
              Text("Hoặc",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .4,
                  color: Colors.grey.shade200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
          ui.AuthStateListener(
            listener: (oldState, state, controller) {
              if (state is ui.UserCreated) {
                logic.socialSignin(state.credential.user,);
              }
              if (state is ui.SignedIn) {
                logic.socialSignin(state.user,);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [

                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .95,

                    child: ui.OAuthProviderButton(
                      provider: uigg.GoogleProvider(
                          clientId: '392911829696-vuq8nl9rbd3t1ds498avsfussob98dod.apps.googleusercontent.com'),
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
              Text("Bạn chưa có tài khoản ?"),
              const SizedBox(width: 3),
              TextButton(
                  onPressed: () {
                    Get.to(SignupPage());
                  }, child: Text('Đăng ký',
                style: TextStyle(
                    color: XColor.primary
                ),
              )
              )
            ],
          ),
          const SizedBox(height: 5,),
          InkWell(
            onTap: (){
              // Get.back();
              Get.back();
            },
            child: Center(
                child: Text("Trở về")),
          ),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}
