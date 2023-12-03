import 'package:app_ft_tmart/src/data/repositories/get_order_by_id_rsp.dart';
import 'package:app_ft_tmart/src/module/order_history/order_detail/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_logic.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Thông báo',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            if(logic.dataNotification.isEmpty==true){
              return Center(
                child: Text("Không có thông báo nào"),
              );
            }
            // Sắp xếp danh sách theo thời gian mới nhất
            logic.dataNotification.sort((a, b) {
              // Chuyển đổi thời gian thành DateTime để so sánh
              DateTime timeA = DateTime.parse(a["createdTime"]);
              DateTime timeB = DateTime.parse(b["createdTime"]);
              return timeB.compareTo(timeA);
            });

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: logic.dataNotification.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .95,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Get.to(OrderDetailPage(
                              id: "${logic.dataNotification[index]["orderId"]}",
                            ));
                          },
                          leading: Image.network(
                              "${logic.dataNotification[index]["image"]}",
                              width: MediaQuery.of(context).size.width*.15,
                              // fit: BoxFit.fill,
                              
                              // fit: BoxFit.fill,
                              ),
                          title: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                                '${logic.dataNotification[index]["title"]}',
                                
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${logic.dataNotification[index]["content"]}'),
                                  Text(
                              "${logic.dataNotification[index]["createdTime"]}"),
                            ],
                          ),
                           
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 2,
                  color: Colors.grey.shade100,
                  width: MediaQuery.of(context).size.width,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
