import 'package:app_ft_tmart/src/module/profile/setting/setting_logic.dart';
import 'package:app_ft_tmart/src/widget/global_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmPasswordDialog extends StatelessWidget {
  const ConfirmPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingLogic());
    return WillPopScope(
      onWillPop: ()async{
        logic.passwordController.text.isEmpty;
        return true;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: AlertDialog(
          // contentPadding: EdgeInsets.all(20),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Nhập mật khẩu",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Vui lòng nhập mật khẩu để tiếp tục cài đặt",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          insetPadding: EdgeInsets.symmetric(vertical: 10),
          contentPadding: EdgeInsets.all(20),
          content: GlobalTextField(
            controller: logic.passwordController,
            validator: Validator.password,
            hint: "Nhập mật khẩu",
            textInputType: TextInputType.visiblePassword,
            onChanged: (value) {
              if (value.isNotEmpty) {
                logic.onButton.value = true;
              } else {
                logic.onButton.value = false;
              }
            },
            security: true,
          ),
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Get.back(), child: Text("Bỏ qua")),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: 50,
                      child: Obx(() => Visibility(
                            visible: logic.onButton.value == true,
                            replacement: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    primary: Colors.grey),
                                child: Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )),
                            child: ElevatedButton(
                                onPressed: () async{
                                   logic.confirmPassword();

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                child: Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
