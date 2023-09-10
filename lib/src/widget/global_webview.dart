import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class GlobalWebview extends StatefulWidget {
  final String? tittleWeb;
  final String? linkWeb;
  const GlobalWebview({Key? key, this.tittleWeb, this.linkWeb}) : super(key: key);

  @override
  State<GlobalWebview> createState() => _GlobalWebviewState();
}

class _GlobalWebviewState extends State<GlobalWebview> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.

  }

  @override
  Widget build(BuildContext context) {
   WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.

          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

        ),
      )
      ..loadRequest(Uri.parse(widget.linkWeb??""));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.tittleWeb??'',style: const TextStyle(color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Get.back();
          },
        ),


      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
