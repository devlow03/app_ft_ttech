import 'package:app_ft_tmart/src/modules/search/list_product/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../core/xcolor.dart';
import '../modules/search/search_view.dart';
class SearchWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  bool? readOnly;
  bool? autofocus;
   SearchWidget({super.key, this.onTap, this.onSubmitted, this.onChanged,this.readOnly,  this.controller,this.autofocus});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextField(
        autofocus: autofocus??false,
        onTap: onTap,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        controller: controller,
        readOnly: readOnly??false,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm sản phẩm',
          hintStyle:  TextStyle(
            color: Colors.grey,

          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          suffixIcon:  Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FaIcon(FontAwesomeIcons.search,
                color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
                color: Colors.transparent,

            ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              color: Colors.transparent,

            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              color: Colors.transparent,

            ),
          ),

        ),
      ),
    );
  }
}
