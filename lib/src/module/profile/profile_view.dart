import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.black,),
        // ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Tài khoản',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("https://library.sportingnews.com/styles/facebook_1200x630/s3/2023-02/Cristiano_Ronaldo_celebrate_Al-Nassr_Al-Wehda_2023.jpg?itok=UgWJXot3"),
                radius: 50,

              ),
              const SizedBox(height: 10,),
              Text("Quang Thiện",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ),
              ),

            ],
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person,color: XColor.primary,),
                          title: Text('Thông tin cá nhân',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100
                        ),
                        child: ListTile(
                          leading: Icon(Icons.shopping_bag_outlined,color: XColor.primary),
                          title: Text('Giỏ hàng',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100
                        ),
                        child: ListTile(
                          leading: Icon(Icons.list_alt,color: XColor.primary),
                          title: Text('Quản lí đơn hàng',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100
                        ),
                        child: ListTile(
                          leading: Icon(Icons.headphones,color: XColor.primary),
                          title: Text('Hỗ trợ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.to(Sign_inPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100
                        ),
                        child: ListTile(
                          leading: Icon(Icons.login,color: XColor.primary),
                          title: Text('Đăng nhập',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),


                ],
              ),
            ),
          ),


          const SizedBox.shrink()
        ],
      )
    );
  }
}
