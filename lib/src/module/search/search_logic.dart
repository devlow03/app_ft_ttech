import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLogic extends GetxController {
  TextEditingController keyController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        // Gọi hàm showKeyboard() để hiển thị bàn phím
        showKeyboard;
      }
    });
  }

  void showKeyboard(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }
}
