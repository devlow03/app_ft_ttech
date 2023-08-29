import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width*.9,
        decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage(
                'assets/images/splash.jpg'
              ),


            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300,),
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: XColor.primary,
                  strokeWidth: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
