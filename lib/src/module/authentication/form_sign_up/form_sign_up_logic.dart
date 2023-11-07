import 'package:app_ft_tmart/src/data/repositories/post_register_rqst_bodies.dart';
import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_logic.dart';
import 'package:app_ft_tmart/src/module/authentication/signup/signup_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/services/service.dart';
import '../../../widget/utils.dart';

class FormSignUpLogic extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Services tMartServices = Get.find();
  TextEditingController fullNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  Rxn<String>phoneNumber = Rxn();
  final logicSignIn = Get.put(SignInLogic());
  final logicSignUp = Get.put(SignupLogic());

  Future<void>register()async{
    Utils.loading(()async{
      await tMartServices.postRegister(body: PostRegisterRqstBodies(
        phone: phoneNumber.value,
        name: fullNameControl.text,
        password: passControl.text,
        email: emailControl.text
      ));
      await logicSignIn.signIn();

    });
  }
}
