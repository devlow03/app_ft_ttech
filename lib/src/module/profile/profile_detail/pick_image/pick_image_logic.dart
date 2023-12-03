import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class PickImageLogic extends GetxController {

  Rxn<File?> image = Rxn();
  Future selectImage() async {
    final selectImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectImg != null) {
      File convertFile = File(selectImg.path);
        image.value = convertFile;



    }
  }






}
