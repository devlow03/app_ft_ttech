import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_android/local_auth_android.dart';


class SettingLogic extends GetxController {
  final localAuth = LocalAuthentication();
  Rx<bool> onLocalAuth = Rx(false);
  Rx<bool> checkAuth = Rx(false);
  Rxn<String> biometric = Rxn();
  final TextEditingController passwordController = TextEditingController();
  Rxn<bool> onButton = Rxn(false);
  

  @override
  void onReady() async {
    super.onReady();
    await checkBiometric();
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("biometric")=="finger"){
          biometric.value = "finger";
        }
    else if(prefs.getString("biometric")=="faceID"){
          biometric.value = "faceID";
    }
    await checkOnLocalAuth();
  }

  Future<void> checkOnLocalAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("onLocalAuth") == "true") {
      onLocalAuth.value = true;
    } else {
      onLocalAuth.value = false;
    }
  }

  Future<void> checkBiometric() async {
    final localAuth = LocalAuthentication();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      checkAuth.value = await localAuth.isDeviceSupported();
      prefs.setString("checkAuth", "${checkAuth.value}");

      if (!checkAuth.value) {
        return;
      } else {
        final List<BiometricType> availableBiometrics =
            await localAuth.getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.face)) {
          await prefs.setString('biometric', 'faceID');
          
        } else {
          await prefs.setString('biometric', 'finger');
          
        }
      }
    } catch (e) {
      print('Lỗi trong quá trình kiểm tra local authentication: $e');
    }
  }

  Future<void> signInwithBiometric() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Vui lòng xác thực để tiếp tục',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
              signInTitle: "Xác thực bằng vân tay", cancelButton: "Thoát"),

        ],
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true)
        // Thông điệp hiển thị cho người dùng

        );

    if (isAuthenticated) {
      onLocalAuth.value = true;
      await prefs.setString("onLocalAuth", 'true');
      Fluttertoast.showToast(msg: "Xác thực thành công");
    } else {
      onLocalAuth.value = false;
      await prefs.setString("onLocalAuth", 'false');
      Fluttertoast.showToast(msg: "Xác thực thất bại vui lòng thử lại");
    }
  }

  void disableLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    onLocalAuth.value = false;
    await prefs.setString("onLocalAuth", 'false');
    await prefs.remove("onLocalAuth");
  }

  void confirmPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (passwordController.text == prefs.get("password")) {
      Get.back();
      signInwithBiometric();
    } else {
      Fluttertoast.showToast(
          msg: "Mật khẩu không đúng vui lòng thử lại!",
          backgroundColor: Colors.red);
    }
  }
}
