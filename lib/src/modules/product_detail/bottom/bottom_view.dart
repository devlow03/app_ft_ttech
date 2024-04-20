import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/xcolor.dart';

class BottomDetail extends StatelessWidget {
  const BottomDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductDetailLogic(Get.find()));
    return Obx(() {

      return Visibility(
        visible:
        logic.getProductByIdRsp.value?.data?.thumpnailUrl?.isNotEmpty ==
            true,
        child: BottomAppBar(

          height: 100,
          // color: Colors.grey.shade100,
          elevation: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: ()async{
                            await logic.postAddCart(
                                productId: logic
                                    .getProductByIdRsp.value?.data?.id
                                    .toString() ??
                                    "",
                                quantity:
                                logic.quantity.value.toString() ?? "");
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade200,width: 1)
                              ),
                              child: Icon(Icons.add_shopping_cart,size: 25,color: XColor.primary,)))),

                  Expanded(
                    flex: 3,
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          await logic.buyNow(
                              productId: logic
                                  .getProductByIdRsp.value?.data?.id
                                  .toString() ??
                                  "",
                              quantity:
                              logic.quantity.value.toString() ?? "");

                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Mua ngay',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                        )),
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}