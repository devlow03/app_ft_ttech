import 'package:app_ft_tmart/src/module/authentication/sign_in/sign_in_view.dart';
import 'package:app_ft_tmart/src/module/authentication/signup/signup_view.dart';
import 'package:app_ft_tmart/src/module/cart/cart_view.dart';
import 'package:app_ft_tmart/src/module/order/order_view.dart';
import 'package:app_ft_tmart/src/module/profile/address_book/address_book_view.dart';
import 'package:app_ft_tmart/src/module/profile/setting/setting_view.dart';
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
    final logicSignin = Get.put(SignInLogic());

    final List<Map<String,dynamic>>itemListTiTile = [
      {
        'icon':Icons.shopping_cart_outlined,
        'title': "Giỏ hàng",
        'onTap': const CartPage()
      },

      {
        'icon':Icons.bookmark_border,
        'title': "Sổ địa chỉ",
        'onTap': const AddressBookPage()
      },

      {
        'icon':Icons.list_alt_outlined,
        'title': "Đơn hàng",
        'onTap': const OrderPage()
      },

      {
        'icon':Icons.settings_outlined,
        'title': "Thiết lập",
        'onTap': const SettingPage()
      },

      {
        'icon':Icons.logout_outlined,
        'title': "Đăng xuất",
        // 'onTap': logicSignin.signOut()
      },

    ];



    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() {
          return Visibility(
            visible: logic.onSignIn.value==true,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
                                    ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                 Text("Xin chào!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 2
                                  ),
                                ),

                                 Text("${logic.getUserProfileRsp.value?.data?.fullName}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      height: 1.5
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit_outlined, color: Colors.black, size: 30,),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemListTiTile.length,
                      itemBuilder: (context,index){
                        return  ListTile(
                          onTap: ()async{
                            if(index == 4){
                              await logicSignin.signOut();
                            }
                            else{
                              Get.to(itemListTiTile[index]['onTap']);
                            }
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(itemListTiTile[index]['icon'],color: XColor.primary,size: 30,),
                              )),
                          title: Text(itemListTiTile[index]['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
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
        })
    );
  }
}
