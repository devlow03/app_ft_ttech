import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:app_ft_tmart/src/module/order/order_view.dart';
import 'package:app_ft_tmart/src/module/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/module/profile/profile_detail/profile_detail_logic.dart';
import 'package:app_ft_tmart/src/module/profile/profile_detail/profile_detail_page.dart';
import 'package:app_ft_tmart/src/module/profile/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../authentication/sign_in/sign_in_logic.dart';
import '../order_history/order_history_view.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileLogic());
    final logicSignin = Get.put(SignInLogic());
    final logicProfile = Get.put(ProfileDetailLogic());

    final List<Map<String, dynamic>> itemListTiTile = [
      {
        'icon': Icons.person,
        'title': "Thông tin cá nhân",
        'onTap': const ProfileDetailPage()
      },
      {
        'icon': Icons.bookmark_border,
        'title': "Sổ địa chỉ",
        'onTap': const AddressBookPage()
      },
      {
        'icon': Icons.list_alt_outlined,
        'title': "Đơn hàng",
        'onTap': const OrderHistoryPage()
      },
      {
        'icon': Icons.settings_outlined,
        'title': "Thiết lập tài khoản",
        'onTap': const SettingPage()
      },
      {
        'icon': Icons.logout_outlined,
        'title': "Đăng xuất",
        // 'onTap': logicSignin.signOut()
      },
    ];

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() {
          return RefreshIndicator(
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

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
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
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  itemListTiTile[index]['icon'],
                                  color: XColor.primary,
                                  size: 30,
                                ),
                              )),
                          title: Text(
                            itemListTiTile[index]['title'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Visibility(
                              visible: index == 2,
                              child: const Text("Xem lịch sử mua hàng")),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 20,
                          thickness: 1,
                          color: Colors.grey.shade100,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
