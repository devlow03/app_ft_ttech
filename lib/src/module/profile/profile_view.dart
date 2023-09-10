import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../authentication/sign_in/sign_in_logic.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileLogic());
    final logicSignin = Get.put(SignInLogic(Get.find()));

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: Icon(Icons.arrow_back, color: Colors.black,),
          // ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0.0,
          title: Text(
            'Tài khoản',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          // centerTitle: true,
        ),
        body: Obx(() {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: XColor.primary,
                  ),
                  child: Visibility(
                    visible: logicSignin.uid.value!=null,
                    replacement: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  "assets/images/avatar.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )
                                    ),
                                      onPressed: () {
                                        Get.to(SignInPage());
                                      },
                                      child: Text('Đăng nhập',
                                      style: TextStyle(
                                        color: XColor.primary
                                      ),
                                      )
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: Colors.white,
                                              width: 1
                                            )
                                          )
                                      ),
                                      onPressed: () {
                                        Get.to(SignupPage());
                                      },
                                      child: Text('Đăng ký')
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    logicSignin.avatar.value??""
                                      ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Xin chào!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: 2
                                    ),
                                  ),

                                  Text(logicSignin.fullName.value??"",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        height: 1.5
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit, color: Colors.white, size: 30,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(CartPage());
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.shopping_cart_outlined, color: XColor.primary,),
                          title: Text('Giỏ hàng'),
                          subtitle: Text('Xem giỏ hàng'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(
                          Icons.list_alt_outlined, color: XColor.primary,),
                        title: Text('Quản lí đơn hàng'),
                        subtitle: Text("Xem chi tiết đơn hàng"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(
                          Icons.settings_outlined, color: XColor.primary,),
                        title: Text('Cài đặt'),
                        subtitle: Text('Thiết lập ứng dụng'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Visibility(
                        visible: logicSignin.uid.value!=null,
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: ()async{
                               await  logicSignin.signOut();
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.logout_outlined, color: XColor.primary,),
                                title: Text('Đăng xuất'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Chức năng khác",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.headphones_outlined, color: XColor.primary,),
                        title: Text('Hỗ trợ'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(
                          Icons.message_outlined, color: XColor.primary,),
                        title: Text('Phản hồi'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      const SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.info, color: XColor.primary,),
                        title: Text('Thông tin về ứng dụng'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),

                    ],
                  ),
                ),
              )
            ],
          );
        })
    );
  }
}
