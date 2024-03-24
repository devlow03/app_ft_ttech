import 'package:flutter/material.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage(
                  'assets/images/tmart.png'
              ),



            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 300,),
            Center(
              child: SpinKitWaveSpinner(
                size: 60,
                color: XColor.primary,
              )
            ),
          ],
        ),
      ),
    );
  }
}
