import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
class GlobalHtml extends StatelessWidget {
  final String html;
  const GlobalHtml({super.key, required this.html});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Mô tả sản phẩm"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close,)

        ),
      ),
      body: ListView(
        children: [
          Html(data: html,
            style: {
              // "body": Style(
              //   fontSize: FontSize(19.0),
              // ),
              "img": Style(
                  width: Width(MediaQuery.of(context).size.width*.95),
                // height: Height(MediaQuery.of(context).size.height*.3)


              )
            },



          ),
        ],
      ),
    );
  }
}
