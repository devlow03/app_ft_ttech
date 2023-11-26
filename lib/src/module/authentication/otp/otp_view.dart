import 'package:app_ft_tmart/src/module/authentication/form_sign_up/form_sign_up_logic.dart';
import 'package:app_ft_tmart/src/module/authentication/form_sign_up/form_sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../signup/signup_logic.dart';
import 'otp_logic.dart';

class OtpPage extends StatelessWidget {
  final String? phoneNumber;

  const OtpPage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OtpLogic());
    final logicPhone = Get.put(SignupLogic());
    logic.phoneNumber.value = phoneNumber??"";
    final defaultPinTheme = PinTheme(
      width: MediaQuery
          .of(context)
          .size
          .width * .7,
      height: 56,
      textStyle: TextStyle(fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        // border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade200
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return ListView(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .95,
                child: Form(
                  key: logic.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: SvgPicture.asset("assets/images/verify.svg",
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .5,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Xác Thực OTP",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                          child: Text(
                              "Nhập mã xác thực OTP được gửi đến ${phoneNumber}")),
                      const SizedBox(height: 40,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Pinput(
                            controller: logic.codeController,
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            // focusedPinTheme: focusedPinTheme,
                            // submittedPinTheme: submittedPinTheme,
                            validator: (value) {
                             if(value?.isEmpty == true){
                               return "Mã OTP không được để trống";
                             }
                             if((value?.length??0)<6){
                               return "Nhập đủ mã OTP";
                             }
                             return null;
                            },
                            pinputAutovalidateMode: PinputAutovalidateMode
                                .onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: Text(
                            "00:${logic.seconds.value}"
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Không nhận được mã?"),
                          TextButton(
                              onPressed: () async{
                                await logic.resendOtp(phoneNumber);
                              },
                              child: Text("Gửi lại")
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ElevatedButton(
                            onPressed: () async {
                              //
                              if(logic.formKey.currentState?.validate()==true){
                                await logic.verifyOtp();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Xác thực",
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
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          Get.back();
                          // Get.back();
                        },
                        child: Center(
                            child: Text("Trở về")),
                      )
                    ],
                  ),
                ),
              )

            ],
          );
        })
    );
  }
}
