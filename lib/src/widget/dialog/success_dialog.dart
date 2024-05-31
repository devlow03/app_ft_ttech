
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  const SuccessDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
     icon: Lottie.asset("assets/images/success.json",
     height: 100,
       width: 300,

     ),
     title: Text(title),

   );
  }
}
