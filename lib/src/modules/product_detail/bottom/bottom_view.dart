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

          height: 155,
          // color: Colors.grey.shade100,
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*.1/2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Visibility(
                            visible: logic.quantity.value >= 2,
                            replacement: GestureDetector(
                                onTap: null,
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                  child: const Icon(Icons.remove,
                                      size: 25, color: Colors.grey),
                                )),
                            child: GestureDetector(
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                  child: const Icon(Icons.remove,
                                      size: 25, color: Colors.grey),
                                ),
                                onTap: () =>logic.quantity.value--
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 1),
                            child: Text(logic.quantity.value.toString()),
                          ),
                          GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                        color: XColor.primary)),
                                child: const Icon(Icons.add,
                                    size: 25, color: Colors.grey),
                              ),
                              onTap:()=>logic.quantity.value++
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(

                        children: [
                          const Text("Tổng : "),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              NumberFormat.simpleCurrency(locale: 'VI').format(
                                  ((logic.getProductByIdRsp.value?.data
                                      ?.price ??
                                      0) *
                                      (logic.quantity.value))),
                              style:  TextStyle(
                                  color: Color(0xffD92A1C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),

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