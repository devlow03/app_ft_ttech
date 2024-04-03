import 'dart:ffi';

import 'package:app_ft_tmart/src/modules/profile/profile_detail/profile_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldProfile extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool? readOnly;
  final Widget? suffix;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;

  const TextFieldProfile({super.key, this.title, this.hintText, this.controller, this.readOnly, this.suffix,  this.onTap, this.validator, this.textInputType});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileDetailLogic());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title??"",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: TextFormField(
              onTap: onTap,
              maxLines: 1,
              readOnly: readOnly!,
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                filled: true,
                fillColor: Colors.white,
                suffix: suffix,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade200),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
