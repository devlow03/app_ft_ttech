import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
                      flex: 1,
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
                          child: Column(
                            children: [
                              const Icon(LineIcons.addToShoppingCart,size: 35,color: Colors.black,),
                              Text("Thêm vào giỏ",style: TextStyle(fontSize: 12),)
                            ],
                          ))),
                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5,vertical: 5),
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