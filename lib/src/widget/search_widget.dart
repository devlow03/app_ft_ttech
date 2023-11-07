import 'package:app_ft_tmart/src/module/list_product/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../module/search/search_view.dart';
class SearchWidget extends StatelessWidget {

  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(

          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade200,
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 5), // changes position of shadow
          //   ),
          // ],
        ),
        child: TextField(
          onTap: (){
            Get.to(SearchPage());
          },

          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm sản phẩm',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w300
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            prefixIcon: Icon(Icons.search,color: Colors.grey,size: 30,),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.transparent
              ),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.transparent
              ),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.transparent
              ),
            ),

          ),
        ),
      ),
    );
  }
}
