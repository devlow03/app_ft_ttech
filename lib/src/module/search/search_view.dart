import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchLogic());

    return Container();
  }
}
