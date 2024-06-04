import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/xcolor.dart';
import '../../../widget/global_product.dart';
import '../../search/list_product/list_product_view.dart';
import '../../product_detail/product_detail_view.dart';
import '../home_logic.dart';

class ProductByCategoryPage extends StatelessWidget {
  const ProductByCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Obx(() {
      bool? isNotEmpty = logic.getProductByCategoryRsp.value?.data != null;
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: isNotEmpty
              ? (logic.getProductByCategoryRsp.value?.data?.length ?? 0)
              : 6,
          (context, ind) {
            logic.indexPage.value = ind;
            final data = logic.getProductByCategoryRsp.value?.data?[ind];
            return Visibility(
              visible: isNotEmpty,
              replacement: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                child: Container(
                  height: MediaQuery.of(context).size.height * .25,
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * .4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.red),

                    color: Colors.grey.shade200,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              child: GlobalProduct(
                productId: data?.id.toString() ?? "",
                imageLink: data?.thumpnailUrl,
                defaultPrice: '${data?.defaultPrice}',
                // price:NumberFormat("###,###.# đ").format(snapshot.data?.products?[index].price),
                price: '${data?.price}',
                nameProduct: data?.productName,
                rating: double.parse(data?.averageRating ?? "0"),
                isFavorites: data?.favorite,
              ),
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 3 / 5,
        ),
      );
    });
  }
}
