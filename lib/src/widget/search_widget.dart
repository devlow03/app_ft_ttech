import 'package:app_ft_tmart/src/modules/search/list_product/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/xcolor.dart';
import '../modules/search/search_view.dart';
class SearchWidget extends StatelessWidget {

  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextField(
        onTap: (){
          Get.to(const SearchPage());
        },

        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm sản phẩm',
          hintStyle: const TextStyle(
            color: Colors.grey,

          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          suffixIcon:  Icon(Icons.search,color: Colors.grey,size: 30,),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.transparent
            ),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.transparent
            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.transparent
            ),
          ),

        ),
      ),
    );
  }
}
