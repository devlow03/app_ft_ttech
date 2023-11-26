import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_order_rsp.dart';

class OrderHistoryLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<GetOrderRsp>getOrderRsp = Rxn();
  Rxn<int>tabIndex = Rxn(0);
  final List tabOrder = ['Chờ xác nhận','Chờ lấy hàng', 'Chờ giao hàng', 'Đã giao hàng', 'Đã hủy', 'Trả hàng'];

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
     await getOrderRsp();
  }

  Future<GetOrderRsp?>getOrder()async{
    getOrderRsp.value = await tMartServices.getOrderRsp();
    return getOrderRsp.value;
  }
}
