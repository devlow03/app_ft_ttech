import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import 'sign_in_logic.dart';

class Sign_inPage extends StatelessWidget {
  const Sign_inPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(Sign_inLogic());

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                SvgPicture.asset("assets/images/login.svg",
                  height: MediaQuery.of(context).size.height*.35,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30,),
                Form(
                  // key: viewModel.formSignin,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Column(
                      children: [
                        GlobalTextField(
                          // controller: emailControl,
                          hint: 'Tài khoản',
                          requireInput: '',
                          prefixIcon: Icon(Icons.person,color: XColor.primary),
                          // validator: Validator.email,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GlobalTextField(
                          // controller: passControl,
                          hint: 'Mật khẩu',
                          requireInput: '',
                          prefixIcon:
                          Icon(Icons.lock_rounded, color: XColor.primary),
                          textInputType: TextInputType.visiblePassword,
                          // validator: Validator.password,
                          security: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                // Get.to(ForgotPassWordScreen());
                              },
                              child: Text(
                                'Quên mật khẩu ?',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () async {

                            },
                            child: Text(
                              'ĐĂNG NHẬP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 1.5),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'HOẶC',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: ()  {},
                    child: Row(

                      children: [
                        Image.asset("assets/images/google_ico.png",
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 50,),
                        Text(
                          'ĐĂNG NHẬP VỚI GOOGLE',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              letterSpacing: 1.5),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary:Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // Container(
                //   width: MediaQuery.of(context).size.width * .9,
                //   height: 55,
                //   child: ElevatedButton(
                //     onPressed: ()  {},
                //     child: Row(
                //
                //       children: [
                //         Image.asset("assets/images/fb_ico.png",
                //           height: 30,
                //           width: 30,
                //         ),
                //         SizedBox(width: 50,),
                //         Text(
                //           'ĐĂNG NHẬP VỚI FACEBOOK',
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.w700,
                //               color: Colors.black,
                //               letterSpacing: 1.5),
                //         ),
                //       ],
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8)),
                //       primary:Colors.white,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản?',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        // Get.to(SignUpScreen());
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                InkWell(
                    onTap: () {
                      Get.back();

                      // Get.offAll(IndexScreen(indexTab: 3));
                    },
                    child: Text(
                      'Trở về',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          letterSpacing: 1),
                    )),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ));
  }
}
