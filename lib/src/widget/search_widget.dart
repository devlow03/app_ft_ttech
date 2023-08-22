import 'package:flutter/material.dart';
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
          //     color: Colors.grey.shade50,
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 2), // changes position of shadow
          //   ),
          // ],
        ),
        child: TextField(
          onTap: (){
            // Get.to(SearchPage());
          },
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Tìm sản phẩm',
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            suffixIcon: Icon(Icons.search,color: Colors.black,size: 30,),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: Colors.transparent
              ),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: Colors.transparent
              ),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
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
