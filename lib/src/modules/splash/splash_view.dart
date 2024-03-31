import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/xcolor.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SplashLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset("assets/images/tmart.svg"),
      )
    );
  }
}
