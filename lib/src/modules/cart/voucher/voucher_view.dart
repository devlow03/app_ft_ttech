import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_logic.dart';
import 'package:app_ft_tmart/src/widget/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../widget/ticket_widget.dart';
import 'voucher_logic.dart';

class VoucherPage extends StatelessWidget {
  final int cartId;
  const VoucherPage({Key? key, required this.cartId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(VoucherLogic(Get.find()));

    return WillPopScope(
      onWillPop: ()async{
        logic.voucherCodeController.isNull;
        return true;
      },
      child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          resizeToAvoidBottomInset: false,
          // extendBodyBehindAppBar: true,
          extendBody: true,
          
          appBar: AppBar(
            actions: null,
            elevation: 0.0,
            centerTitle: true,
              backgroundColor: Colors.grey.shade100,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: (){
                Get.back();
              },
            ),
            title: const Text("Mã giảm giá",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),)
          ),
          body: Obx(() {
            if(logic.getVoucherRsp.value?.data==null){
              return Center(
                child: CircularProgressIndicator(
                  color: XColor.primary,
      
                ),
              );
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: TextFormField(
                    controller: logic.voucherCodeController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        suffixIcon: InkWell(
                          onTap: (){
                            if(logic.voucherCodeController.text==""){
                              Fluttertoast.showToast(msg: "Vui lòng nhập mã giảm giá");
                            }
                            else{
                              logic.addVoucher(
                                  cartId: cartId,
                                  voucherCode: logic.voucherCodeController.text
                              );
                            }
                          },
                          child: Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              color: XColor.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              // border: Border.all(
                              //   color: Colors.grey
                              // )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Áp dụng",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        hintText: "Nhập mã giảm giá",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: XColor.primary
                          ),

                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: XColor.primary
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: XColor.primary
                          ),
                        )

                    ),


                  ),
                ),
                Visibility(
                  visible: logic.getVoucherRsp.value?.data?.isNotEmpty==true,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: logic.getVoucherRsp.value?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()async{
                          final cart = Get.put(CartLogic());

                          await logic.addVoucher(
                              cartId: cartId,
                              voucherCode: logic.getVoucherRsp.value?.data?[index]
                                  .voucherCode??""
                          );
                          cart.voucherCode.value = logic.getVoucherRsp.value?.data?[index]
                              .voucherCode;
                        },
                        child: TicketWidget(
                          // shadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.1),
                          //     spreadRadius: 5,
                          //     blurRadius: 3,
                          //     offset: Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                          // borderColor: XColor.primary,
                          width: 100,
                          height: 150,
                          color: Colors.white,
                          // isCornerRounded: true,
                          padding: const EdgeInsets.all(20),
                          child:  Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${logic.getVoucherRsp.value?.data?[index]
                                            .title}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'CODE: ${logic.getVoucherRsp.value?.data?[index]
                                            .voucherCode}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'HSD: ${logic.getVoucherRsp.value?.data?[index]
                                            .voucherDateEnd}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Visibility(
                                  visible: logic.logicCart.voucherTitle.value!=logic.getVoucherRsp.value?.data?[index]
                                      .title,
                                  replacement: InkWell(
                                    onTap: ()async{
                                      await logic.deleteVoucher(cartId: cartId);
                                      final cart = Get.put(CartLogic());
                                      cart.voucherCode.value = "Chọn mã giảm giá";
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                          child: Text("Xóa mã",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: ()async{
                                      await logic.addVoucher(
                                          cartId: cartId,
                                          voucherCode: logic.getVoucherRsp.value?.data?[index]
                                              .voucherCode??"",index: index
                                      );
                                     
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: XColor.primary,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                        child: Text("Áp dụng",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500
                                            ),
                                            ),
                                      )
                                      ),
                                    ),
                                  ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10,);
                    },
                  ),
                ),
                const SizedBox(height: 30,)
              ],
            );
          }),
        ),
      ),
    );
  }
}
