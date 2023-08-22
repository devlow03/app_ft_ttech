import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favourites_logic.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FavouritesLogic());

    return Container();
  }
}
