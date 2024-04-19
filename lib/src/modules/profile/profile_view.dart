import 'package:app_ft_tmart/src/modules/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/modules/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/modules/cart/cart_view.dart';
import 'package:app_ft_tmart/src/modules/order/order_view.dart';
import 'package:app_ft_tmart/src/modules/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_detail/profile_detail_logic.dart';
import 'package:app_ft_tmart/src/modules/profile/profile_detail/profile_detail_page.dart';
import 'package:app_ft_tmart/src/modules/profile/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../authentication/sign_in/sign_in_logic.dart';
import 'order_history/order_history_view.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);
  final logic = Get.put(ProfileLogic());

  @override
  Widget build(BuildContext context) {

    final logicSignin = Get.put(SignInLogic());
    final logicProfile = Get.put(ProfileDetailLogic());

    final List<Map<String, dynamic>> itemListTiTile = [
      {
        'icon': Icons.person,
        'title': "Thông tin cá nhân",
        'sub':"Chỉnh sửa thông tin",
        'onTap': const ProfileDetailPage()
      },
      {
        'icon': Icons.bookmark_border,
        'title': "Sổ địa chỉ",
        'sub':"Xem sổ địa chỉ",
        'onTap': const AddressBookPage()
      },
      {
        'icon': Icons.list_alt_outlined,
        'title': "Đơn hàng",
        'sub':"Xem lịch sử mua hàng",
        'onTap': const OrderHistoryPage()
      },
      {
        'icon': Icons.settings_outlined,
        'title': "Thiết lập tài khoản",
        'sub':"Đổi mật khẩu, vân tay",
        'onTap': const SettingPage()
      },
      {
        'icon': Icons.logout_outlined,
        'title': "Đăng xuất",
        'sub':'Thoát khỏi tài khoản '
        // 'onTap': logicSignin.signOut()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text("Cá nhân",style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black),),
        centerTitle: true,
      ),
        backgroundColor: Colors.white,
        body: Obx(() {
          return RefreshIndicator(
        color: XColor.primary,
            onRefresh: ()async{
              logic.onReady();
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Obx(() => CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                "${logic.getUserProfileRsp.value?.data?.avatar!=null?(logic.getUserProfileRsp.value?.data?.avatar):(logicProfile.networkImage.value)}"),
                          )),
                    ),
                    const SizedBox(height: 5,),
                        Text(
                          "${logic.getUserProfileRsp.value?.data?.fullName}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.5,
                              height: 1),
                        ),



                      ],
                    ),
                  ),
                ),

                Container(
                  margin:const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemListTiTile.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          if (index == 4) {
                            await logicSignin.signOut();
                          } else {
                            Get.to(itemListTiTile[index]['onTap']);
                          }
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            itemListTiTile[index]['icon'],
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          itemListTiTile[index]['title'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle:  Text(itemListTiTile[index]['sub']),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10,);
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
