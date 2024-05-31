import 'package:app_ft_tmart/src/widget/dialog/error_dialog.dart';
import 'package:app_ft_tmart/src/widget/dialog/success_dialog.dart';
import 'package:flutter/material.dart';


class CustomDialogWidget{
  static Widget successDialog({required String title})=>SuccessDialog(title: title,);

  static Widget errorDialog({required String title})=>ErrorDialog(title: title);
}