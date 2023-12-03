import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart' as uifb;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart' as uigg;
import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import '../../index/index_view.dart';
import 'form_sign_up_logic.dart';

class FormSignUpPage extends StatelessWidget {
  final String? phoneNumber;
  final PhoneAuthCredential credential;
  const FormSignUpPage({Key? key, this.phoneNumber, required this.credential, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FormSignUpLogic());
    logic.phoneNumber.value = phoneNumber;
    return Scaffold(
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
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Welcome, \n",
                            style: TextStyle(
                                fontSize: 40,
                                color: Color(0xff3640E0),
                                fontWeight: FontWeight.bold,
                                height: 1
                            )
                        ),
                        TextSpan(
                            text: "register to start with TMART 👋",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ]
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: logic.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child:GlobalTextField(
                          title: "Họ tên",

                          controller: logic.fullNameControl,
                          // prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                          hint: 'Nhập họ tên',
                          validator: Validator.fullname,
                          textInputType: TextInputType.name,
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child:GlobalTextField(
                          controller: logic.emailControl,

                          title: "Email",
                          // prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                          hint: 'Nhập email( Không bắt buộc )',
                          validator: (value){
                            if(!value.isEmpty){
                              if (!RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$").hasMatch(value)) {
                                return 'Vui lòng nhập đúng email';
                              }
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                          security: false,

                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: GlobalTextField(
                          controller: logic.passControl,
                          title: "Mật khẩu",
                          hint: 'Nhập mật khẩu',
                          validator: Validator.password,
                          textInputType: TextInputType.visiblePassword,
                          // validator: Validator.password,
                          security: true,

                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ElevatedButton(
                          onPressed:()async{
                            if(logic.formKey.currentState?.validate()==true){
                              await logic.register(credential);
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
                              "Đăng ký",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //       child: Container(
            //         height: 2,
            //         width: MediaQuery
            //             .of(context)
            //             .size
            //             .width * .4,
            //         color: Colors.grey.shade200,
            //       ),
            //     ),
            //     Text("Hoặc",
            //       style: TextStyle(
            //           fontSize: 15,
            //           color: Colors.black
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //       child: Container(
            //         height: 2,
            //         width: MediaQuery
            //             .of(context)
            //             .size
            //             .width * .4,
            //         color: Colors.grey.shade200,
            //       ),
            //     ),
            //   ],
            // ),
            // // const SizedBox(height: 5,),
            // ui.AuthStateListener(
            //   listener: (oldState, state, controller) {
            //     if (state is ui.UserCreated) {
            //       // logic.socialSignin(state.credential.user,);
            //     }
            //     if (state is ui.SignedIn) {
            //       // logic.socialSignin(state.user,);
            //     }
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Column(
            //       children: [

            //         Container(
            //           width: MediaQuery
            //               .of(context)
            //               .size
            //               .width * .92,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(30)
            //           ),

            //           child: ui.OAuthProviderButton(
            //             provider: uigg.GoogleProvider(
            //                 clientId: '392911829696-k7nv4b8c6cm0p3gi4jcmite6cj59vo5a.apps.googleusercontent.com'),

            //           ),
            //         ),

            //         // Container(
            //         //   width: MediaQuery.of(context).size.width*.95,
            //         //   child: ui.OAuthProviderButton(
            //         //     provider: uifb.FacebookProvider(clientId: '277551901591822', redirectUri: 'https://gas-luxen.firebaseapp.com/__/auth/handler'),
            //         //   ),
            //         // ),


            //       ],
            //     ),
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đã có tài khoản ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 3),
                TextButton(
                    onPressed: () {
                      Get.offAll(const SignInPage());
                    }, child: Text('Đăng nhập',
                  style: TextStyle(
                    color: XColor.primary,

                  ),
                )
                )
              ],
            ),
            const SizedBox(height: 5,),
            InkWell(
              onTap: (){
                // Get.back();
                Get.offAll(IndexPage());
              },
              child: Center(
                  child: Text("Trở về",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  )
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
