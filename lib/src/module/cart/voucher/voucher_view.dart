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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
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
                            decoration: BoxDecoration(
                              color: XColor.primary,
                              // borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                "Áp dụng",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: "Nhập mã giảm giá",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),

                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: Colors.grey
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
                            visible: logic.logicCart.voucherCode.value!=logic.getVoucherRsp.value?.data?[index]
                                .title,
                            replacement: TextButton(
                                onPressed: (){
                                  logic.deleteVoucher(cartId: cartId);
                                },
                                child:
                                Text("Xóa",
                                  style: TextStyle(
                                      color:Colors.red,
                                      fontSize: 16,

                                  ),
                                )
                            ),
                            child: TextButton(
                                onPressed: (){
                                  logic.addVoucher(
                                      cartId: cartId,
                                      voucherCode: logic.getVoucherRsp.value?.data?[index]
                                          .voucherCode??""
                                  );
                                },
                                child:
                                Text("Áp dụng",
                                style: TextStyle(
                                  color: XColor.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                                )
                            ),
                          )
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
