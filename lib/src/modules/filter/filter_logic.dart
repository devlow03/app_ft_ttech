import 'package:app_ft_tmart/src/data/repositories/get_brand_rsp.dart';
import 'package:app_ft_tmart/src/data/repositories/get_category_rsp.dart';
import 'package:app_ft_tmart/src/data/services/service.dart';
import 'package:get/get.dart';

class FilterLogic extends GetxController {
  final Services tMartServices = Get.find();
  Rxn<int>itemCount = Rxn();
  Rxn<String>keyword = Rxn();
  Rxn<GetCategoryRsp>getCategoryRsp = Rxn();
  Rxn<GetBrandRsp>getBrandRsp = Rxn();
  final RxList<String> selectedCategoryTypes = <String>[].obs;
  final RxList<String> selectedBrandTypes = <String>[].obs;
  final RxList<Map<String, String>> priceRange = RxList<Map<String, String>>();
  List<Map<String, String>> priceRangeList = [
    {
      "id": "2",
      "title": "Dưới 2 triệu",
    },
    {
      "id": "2-4",
      "title": "Từ 2 - 4 triệu",
    },
    {
      "id": "4-7",
      "title": "Từ 4 - 7 triệu",
    },
    {
      "id": "7-13",
      "title": "Từ 7 - 13 triệu",
    },
    {
      "id": "13-20",
      "title": "Từ 13 - 20 triệu",
    },
    {
      "id": "20",
      "title": "Trên 20 triệu",
    }
  ];

  // List<Map<String,dynamic>>filterComponent = [
  //   {
  //
  //     "widget":const FilterPrice()
  //   },
  //   {
  //
  //     "widget":const FilterCategory()
  //   },
  //   {
  //     "widget":const FilterBrand()
  //   }
  // ];


  final RxList<String> selectedPriceRange = <String>[].obs;

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    priceRange.addAll(priceRangeList);
    await getCategory();
    await getBrand();
  }
  Future<GetCategoryRsp?>getCategory()async{

    getCategoryRsp.value = await tMartServices.getCategoryRsp();

    return getCategoryRsp.value;
  }

  Future<GetBrandRsp?>getBrand()async{
    getBrandRsp.value = await tMartServices.getBrandRsp();
    return getBrandRsp.value;
  }

}
