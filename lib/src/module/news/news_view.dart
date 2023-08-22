import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'news_logic.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NewsLogic());

    return Container();
  }
}
