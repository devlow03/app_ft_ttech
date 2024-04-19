import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
// import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart' as uifb;
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart' as uigg;
import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import '../../index/index_view.dart';
import 'form_sign_up_logic.dart';

class FormSignUpPage extends StatelessWidget {
  final String? phoneNumber;

  const FormSignUpPage({Key? key, this.phoneNumber,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FormSignUpLogic());
    logic.phoneNumber.value = phoneNumber;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                            text: 'Tạo tài khoản mới',
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
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    )
                ),
                height: MediaQuery.of(context).size.height*.8,
                child: Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Form(
                        key: logic.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 25,),
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
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: ElevatedButton(
                                      onPressed:()async{
                                        if(logic.formKey.currentState?.validate()==true){
                                          await logic.register();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30)),
                                        backgroundColor: XColor.primary,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Bạn đã có tài khoản ?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 3),
                                      TextButton(
                                          onPressed: () {
                                            Get.to(const SignInPage());
                                          },
                                          child: Text(
                                            'Đăng nhập',
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

                                      Get.offAll(IndexPage());

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



                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
