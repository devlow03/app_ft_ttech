import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/repositories/get_order_by_id_rsp.dart';
import 'package:app_ft_tmart/src/modules/profile/order_history/order_detail/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_logic.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: const Text(
            'Thông báo',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: Obx(() {
          if (logic.getNotificationRp.value == null) {
            if (logic.getNotificationRp.value?.data?.isEmpty == true) {
              return const Center(
                child: Text(
                  "Không có thông báo nào!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: XColor.primary,
                ),
              );
            }
          }

          // Sắp xếp danh sách theo thời gian mới nhất

          return RefreshIndicator(
            color: XColor.primary,
            onRefresh: () async {
              logic.onReady();
            },
            child: ListView(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logic.getNotificationRp.value?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = logic.getNotificationRp.value?.data?[index];
                    return Container(
                      // width: MediaQuery.of(context).size.width * .95,
                      // height: MediaQuery.of(context).size.height*.18,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(OrderDetailPage(
                                id: data?.orderId?.toString(),
                              ));
                            },
                            leading: Image.network(
                              "${data?.imageUrl}",
                              width: MediaQuery.of(context).size.width * .15,
                              // fit: BoxFit.fill,

                              // fit: BoxFit.fill,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data?.title}',
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data?.timeElapsed}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text('${data?.content}'),

                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 1,
                    );
                  },
                ),
              ],
            ),
          );
        }));
  }
}
