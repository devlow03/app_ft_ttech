import 'package:app_ft_tmart/src/data/repositories/get_product_rq_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_by_category_rsp.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/repositories/get_search_rsp.dart';
import '../../data/services/service.dart';

class ListProductLogic extends GetxController {
  final Services tMartServices;
  ListProductLogic(this.tMartServices);
  TextEditingController keyController = TextEditingController();
  Rxn<GetProductRsp>getSearchRsp = Rxn();
  Rx<int>page = Rx(10);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);



  void onReady() async{
    // TODO: implement onReady
    super.onReady();

      loadMore();


  }

  Future<GetProductRsp?>getSearch({required String name,List<String>? category,List<String>? brand, List<String>? price})async{
    getSearchRsp.value = await tMartServices.getProductRsp(query:
      GetProductRqQuery(
        categoryId: (category?.length??0)!=0?category:null,
        perPage: page.value.toString(),
        productName: name,
        manufacturerId: (brand?.length??0)!=0?brand:null,
        price:(price?.length??0)!=0?price:null
      )
    );
    return getSearchRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){

        if(page.value<(getSearchRsp.value?.meta?.total??0)){
          isLoading.value=true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value+=10;
          await getSearch(name: keyController.text);
        }



      }
    });
    isLoading.value=false;
  }
}
