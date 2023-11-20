import 'package:app_ft_tmart/src/module/order_history/order_detail/order_detail_view.dart';
import 'package:app_ft_tmart/src/module/order_history/order_list/order_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/xcolor.dart';
import '../../widget/global_image.dart';
import '../search/search_view.dart';
import 'order_history_logic.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(OrderHistoryLogic());
    logic.getOrder();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Đơn hàng',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to( const SearchPage());
              },
              icon:  const Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
          length: logic.tabOrder.length,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300)
                    )
                ),
                child: Center(
                  child: TabBar(

                      indicatorWeight: 5,
                      isScrollable: true,
                      indicatorColor: XColor.primary,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w700),
                      labelColor: XColor.primary,
                      onTap: (index) async {

                      },
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: logic.tabOrder.map((e) {
                        return Tab(
                          text: e,

                        );
                      }).toList()
                  ),
                ),
              ),
               Expanded(child: TabBarView(
                children: logic.tabOrder.map((e) {
                  return const OrderList();
                }).toList()
              ))
            ],
          )
      ),
    );
  }
}
