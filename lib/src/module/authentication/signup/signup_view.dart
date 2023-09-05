import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_textfield.dart';
import '../otp/otp_view.dart';
import 'signup_logic.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SignupLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(child: SvgPicture.asset("assets/images/register.svg",
            height: MediaQuery.of(context).size.height*.6,
            )),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("Nhập Số Điện Thoại",
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
                  child: GlobalTextField(
                    controller: logic.phoneController,
                    hint: 'Số điện thoại',
                    prefixIcon: Icon(Icons.phone,color: XColor.primary,),
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await logic.sendOtp();
                        // Get.to(OtpPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Gửi mã xác thực",
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
