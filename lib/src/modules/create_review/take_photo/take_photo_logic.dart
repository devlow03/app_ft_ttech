import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoLogic extends GetxController {
  RxList<File?> images = RxList();
  Rxn<int> itemCount = Rxn(0);
  TextEditingController noteController = TextEditingController();

  Future<void> takePhoto() async {
    final selectedImg =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (selectedImg != null) {
      File convertedFile = File(selectedImg.path);
      images.add(convertedFile);
    }
  }

  Future<void> getPhoto() async {
    final selectedImg =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedImg != null) {
      File convertedFile = File(selectedImg.path);
      images.add(convertedFile);
    }
  }

  Future<void> pickImage() async {
    Get.dialog(CupertinoAlertDialog(
      title: const Text(
        "Tải ảnh lên",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text("Vui lòng chọn phương thức tải ảnh lên"),
      actions: [
        CupertinoDialogAction(
          child: const Text("Camera",style: TextStyle(color: Colors.black),),
          onPressed: () async {
            Get.back();
            await takePhoto();


          },
        ),
        CupertinoDialogAction(
          child: const Text("Thư viện ảnh",style: TextStyle(color: Colors.black)),
          onPressed: () async {
            Get.back();
            await getPhoto();


          },
        ),
        CupertinoDialogAction(
          child: const Text("Quay lại",style: TextStyle(color: Colors.black)),
          onPressed: () => Get.back(),
        ),
      ],
    ));
  }
}
