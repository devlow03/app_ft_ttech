import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingLogic());

    return Container();
  }
}
