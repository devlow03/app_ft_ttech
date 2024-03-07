import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(
      () => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thông số kĩ thuật',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 20,
              ),
              HtmlWidget(logic.getProductByIdRsp.value?.data?.detail ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
