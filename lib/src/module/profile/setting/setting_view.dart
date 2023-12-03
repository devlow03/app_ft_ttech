import 'package:app_ft_tmart/src/module/profile/setting/reset_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/xcolor.dart';
import 'confirm_password/confirm_password.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingLogic());

    String? biometric = logic.biometric.value;
    final List<Map<String, dynamic>> itemListTiTile = [
      {
        'icon': Icon(
          Icons.password,
          size: 30,
          color: XColor.primary,
        ),
        'title': "Đổi mật khẩu",
        'onTap': const ResetPasswordPage()
      },
      {
        'icon': Icon(
          Icons.fingerprint,
          size: 30,
          color: XColor.primary,
        ),
        'title': "Đăng nhập bằng vân tay",
        'onTap': ''
      },
      // {
      //   'icon': Image.asset(
      //     "assets/images/face_id.png",
      //     height: 30,
      //     width: 30,
      //   ),
      //   'title': "Đăng nhập bằng faceID",
      //   'onTap': ''
      // }
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thiết lập tài khoản',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  children: [
                    ListTile(
                        onTap: () async {
                          Get.to(const ResetPasswordPage());
                        },
                        leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.password,
                                size: 30,
                                color: XColor.primary,
                              ),
                            )),
                        title: const Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right)),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.grey.shade100,
                    ),
                    Obx(() => ListTile(
                          onTap: () async {
                            Get.dialog(const ConfirmPasswordDialog());
                          },
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Visibility(
                                  visible: logic.biometric.value == "finger",
                                  replacement: Image.asset(
                                    "assets/images/face_id.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  child: Icon(
                                    Icons.fingerprint,
                                    size: 30,
                                    color: XColor.primary,
                                  ),
                                ),
                              )),
                          title: Text(
                            logic.biometric.value == "finger"
                                ? "Đăng nhập bằng vân tay"
                                : "Đăng nhập bằng face ID",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: Obx(() => Visibility(
                                visible: logic.checkAuth.isTrue,
                                replacement: Switch(
                                  value: false,
                                  onChanged: (val) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Vui lòng bật vân tay trên thiết bị của bạn");
                                  },
                                ),
                                child: Switch(
                                    value: logic.onLocalAuth.value,
                                    onChanged: (val) {
                                      if (val == true) {
                                        Get.dialog(
                                            const ConfirmPasswordDialog());
                                      } else {
                                        logic.disableLocal();
                                      }
                                    }),
                              )),
                        ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
