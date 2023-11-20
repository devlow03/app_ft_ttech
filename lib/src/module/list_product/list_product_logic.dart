import 'package:app_ft_tmart/src/data/repositories/get_product_rq_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/get_product_by_category_rsp.dart';
import '../../data/repositories/get_product_rsp.dart';
import '../../data/repositories/get_search_rsp.dart';
import '../../data/services/service.dart';
import '../search/search_logic.dart';
import 'filter/filter_logic.dart';

class ListProductLogic extends GetxController {
  final Services tMartServices;
  final logic = Get.put(FilterLogic());
  final logicSearch = Get.put(SearchLogic());
  ListProductLogic(this.tMartServices);
  Rxn<GetProductRsp>getSearchRsp = Rxn();
  Rx<int>page = Rx(6);
  Rxn<bool>isLoading = Rxn(false);
  final ScrollController controller = ScrollController();
  Rx<int>indexPage = Rx(0);
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();




  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    getSearchRsp.value = null;
      loadMore();
  }
  @override
  void dispose() {
    // TODO: implement onReady
    super.dispose();
    // keyController.dispose();
  }

  Future<GetProductRsp?>getSearch({String? name,List<String>? category,List<String>? brand, List<String>? price})async{
    if(name!=""){
      logicSearch.keyController.text = name??"";
      getSearchRsp.value = await tMartServices.getProductRsp(query:
      GetProductRqQuery(
          categoryId: (category?.length??0)!=0?category:null,
          perPage: page.value.toString(),
          productName: logicSearch.keyController.text,
          manufacturerId: (brand?.length??0)!=0?brand:null,
          price:(price?.length??0)!=0?price:null
      )
      );
    }
    else{
      getSearchRsp.value = await tMartServices.getProductRsp(query:
      GetProductRqQuery(
          categoryId: (category?.length??0)!=0?category:null,
          perPage: page.value.toString(),
          productName: logicSearch.keyController.text,
          manufacturerId: (brand?.length??0)!=0?brand:null,
          price:(price?.length??0)!=0?price:null
      )
      );
    }
    getSearchRsp.refresh();
    return getSearchRsp.value;
  }

  Future<void>loadMore()async {
    controller.addListener(() async{
      if(controller.position.maxScrollExtent == controller.offset){

        if(page.value<(getSearchRsp.value?.meta?.total??0)){
          isLoading.value=true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>AAAAAAAAAAAAAAAAAA");
          page.value+=10;
          await getSearch(
            name: logicSearch.keyController.text,
            price: logic.selectedPriceRange,
            category: logic.selectedCategoryTypes,
            brand: logic.selectedBrandTypes
          );
        }



      }
    });
    isLoading.value=false;
  }
}
