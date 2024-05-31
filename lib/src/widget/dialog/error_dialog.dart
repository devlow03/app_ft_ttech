import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class ErrorDialog extends StatelessWidget {
  final String title;
  const ErrorDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      insetPadding: const EdgeInsets.all(10),

      title: Text(
        title,
      ),
      titleTextStyle: const TextStyle(fontSize: 30,color: Colors.black),
      icon: Lottie.asset("assets/images/error.json",
        height: 100,
        width: 300,

      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width*.9,
          child: ElevatedButton(

              style:
                  ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      backgroundColor: XColor.primary),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Xác nhận",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
