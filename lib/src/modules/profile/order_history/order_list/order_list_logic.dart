import 'package:app_ft_tmart/src/data/repositories/get_order_rqst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order_history_logic.dart';

class OrderListLogic extends GetxController {
  final logic = Get.put(OrderHistoryLogic());
  final ScrollController controller = ScrollController();
  

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadMore();
  }

  Future<void> loadMore() async {
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (logic.page.value < (logic.getOrderRsp.value?.meta?.total ?? 0)) {
          logic.page.value += 10;
          
            logic.getOrderRsp.value = await logic.tMartServices.getOrderRsp(
                query: GetOrderRqst(
                    perPage: logic.page.value.toString(),
                    statusCode:
                        "${logic.tabIndex.value != null ? (logic.tabOrder[logic.tabIndex.value ?? 0]["value"]) : (logic.tabOrder[0]["value"])}"));
            
            logic.getOrderRsp.refresh();
          }
        }
      
    });
  }
}
