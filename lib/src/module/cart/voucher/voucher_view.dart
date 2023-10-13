import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/widget/search_widget.dart';
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          actions: null,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Get.back();
            },
          ),
          title: SizedBox(
            height: 45,
            child: TextFormField(
              controller: logic.voucherCodeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
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
                            Text(
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
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: XColor.primary
                    ),

                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: XColor.primary
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: XColor.primary
                    ),
                  )

              ),


            ),
          ),
        ),
        body: Obx(() {
          if(logic.getVoucherRsp.value?.data?.isEmpty==true){
            return Center(
              child: CircularProgressIndicator(
                color: XColor.primary,

              ),
            );
          }
          return ListView.separated(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: logic.getVoucherRsp.value?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  logic.addVoucher(
                      cartId: cartId,
                      voucherCode: logic.getVoucherRsp.value?.data?[index]
                          .voucherCode??""
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TicketWidget(
                    borderColor: XColor.primary,
                    width: 100,
                    height: 120,
                    color: XColor.primary.shade50,
                    // isCornerRounded: true,
                    padding: EdgeInsets.all(20),
                    child:  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${logic.getVoucherRsp.value?.data?[index]
                                    .title}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'CODE: ${logic.getVoucherRsp.value?.data?[index]
                                    .voucherCode}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'HSD: ${logic.getVoucherRsp.value?.data?[index]
                                    .voucherDateEnd}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: logic.logicCart.voucherTitle.value!=logic.getVoucherRsp.value?.data?[index]
                                .title,
                            replacement: InkWell(
                              onTap: (){
                                logic.deleteVoucher(cartId: cartId);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
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
                              onTap: (){
                                logic.addVoucher(
                                    cartId: cartId,
                                    voucherCode: logic.getVoucherRsp.value?.data?[index]
                                        .voucherCode??""
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: XColor.primary,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
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
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10,);
            },
          );
        }),
      ),
    );
  }
}
