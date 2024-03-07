import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Visibility(
                visible: logic.viewAll.value == false,
                replacement: HtmlWidget(
                  logic.getProductByIdRsp.value?.data?.desctiption ?? "",
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: ClipRRect(
                        child: HtmlWidget(
                          logic.getProductByIdRsp.value?.data?.desctiption ??
                              "",
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: 1,
                        child: Container(
                          height: 128,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              colors: [
                                Color(0x00ffffff),
                                Colors.white,
                                Colors.white,
                              ],
                              stops: [
                                0,
                                0.9,
                                1,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Visibility(
                  visible: logic.viewAll.value == false,
                  replacement: TextButton(
                      onPressed: () {
                        logic.viewAll.value = false;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Thu gọn",
                            style: TextStyle(fontSize: 14),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up,
                            color: XColor.primary,
                          )
                        ],
                      )),
                  child: TextButton(
                      onPressed: () {
                        logic.viewAll.value = true;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Xem thêm",
                            style: TextStyle(fontSize: 14),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: XColor.primary,
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}