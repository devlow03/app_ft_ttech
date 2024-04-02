import 'package:app_ft_tmart/src/data/repositories/get_product_by_category_rsp.dart';
import 'package:app_ft_tmart/src/modules/all_product_by_category/all_product_by_category_view.dart';
import 'package:app_ft_tmart/src/modules/product_detail/description/description.dart';
import 'package:app_ft_tmart/src/modules/product_detail/info_detai/info_detail.dart';
import 'package:app_ft_tmart/src/modules/product_detail/mini_image_list/mini_image_list.dart';
import 'package:app_ft_tmart/src/modules/product_detail/product_reviews/produc_reviews.dart';
import 'package:app_ft_tmart/src/modules/product_detail/same_type/same_type.dart';
import 'package:app_ft_tmart/src/modules/search/search_view.dart';
import 'package:app_ft_tmart/src/widget/global_html.dart';
import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';

import '../../data/repositories/get_product_rsp.dart';
import '../../widget/global_product.dart';
import '../cart/cart_logic.dart';
import '../cart/cart_view.dart';
import '../search/list_product/list_product_view.dart';
import '../photo/photo_view.dart';
import 'image_slider/image_slider.dart';
import 'info/info.dart';
import 'product_detail_logic.dart';

class ProductDetailPage extends StatelessWidget {
  final String? id;

  const ProductDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicCart = Get.put(CartLogic());
    final logic = Get.put(ProductDetailLogic(Get.find()));
    logic.getProduct(id);

    return WillPopScope(
      onWillPop: () async {
        logic.quantity.value = 1;
        logic.getProductByIdRsp.value = null;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        body: RefreshIndicator(
          onRefresh: () async {
            logic.refresh();
          },
          child: CustomScrollView(
            slivers: [
              Obx(() {
                return SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark),
                  expandedHeight: MediaQuery.of(context).size.height * .45,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: ImageSlider(),
                    stretchModes: [
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                    ],
                  ),
                  pinned: true,
                  stretch: true,
                  actions: [
                    IconButton(
                        onPressed: logic.postAddFavorite,
                        icon: Visibility(
                          visible:
                              logic.getProductByIdRsp.value?.data?.favorite ==
                                  true,
                          replacement: const Icon(Icons.favorite_border),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )),
                    // IconButton(
                    //     onPressed: () {
                    //       Get.to(const SearchPage());
                    //     },
                    //     icon: const Icon(Icons.search)),
                    Obx(() {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await logicCart.getCart();
                              Get.to(const CartPage());
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                          ),
                          Visibility(
                            visible: logicCart.getCartRsp.value?.data
                                    ?.cartDetails?.isNotEmpty ==
                                true,
                            child: Positioned(
                              right: 5,
                              bottom: 25,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: XColor.primary),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "${logicCart.getCartRsp.value?.data?.cartDetails?.length}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })
                  ],
                );
              }),
              SliverToBoxAdapter(child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const MiniImageList(),
                    Visibility(
                      visible:
                          logic.getProductByIdRsp.value?.data.isNull == false,
                      child: Column(
                        children: const [
                          Info(),
                          SizedBox(
                            height: 10,
                          ),
                          InfoDetail(),
                          SizedBox(
                            height: 10,
                          ),
                          DescriptionView(),
                          SizedBox(height: 10,),
                          ProductReviewsPage(),
                          SizedBox(
                            height: 10,
                          ),
                          SameType()
                        ],
                      ),
                    ),
                  ],
                );
              }))
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {

          return Visibility(
            visible:
                logic.getProductByIdRsp.value?.data?.thumpnailUrl?.isNotEmpty ==
                    true,
            child: BottomAppBar(

              height: 150,
              // color: Colors.grey.shade100,
              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*.1/2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Visibility(
                                visible: logic.quantity.value >= 2,
                                replacement: GestureDetector(
                                    onTap: null,
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey.shade200)),
                                      child: const Icon(Icons.remove,
                                          size: 25, color: Colors.grey),
                                    )),
                                child: GestureDetector(
                                  child: Container(
                                    margin:
                                    const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade200)),
                                    child: const Icon(Icons.remove,
                                        size: 25, color: Colors.grey),
                                  ),
                                  onTap: () =>logic.quantity.value--
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 1),
                                child: Text(logic.quantity.value.toString()),
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      border: Border.all(
                                          color: XColor.primary)),
                                  child: const Icon(Icons.add,
                                      size: 25, color: Colors.grey),
                                ),
                                onTap:()=>logic.quantity.value++
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(

                            children: [
                              const Text("Tổng : "),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  NumberFormat.simpleCurrency(locale: 'VI').format(
                                      ((logic.getProductByIdRsp.value?.data
                                                  ?.price ??
                                              0) *
                                          (logic.quantity.value))),
                                  style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: ()async{
                                await logic.postAddCart(
                                    productId: logic
                                        .getProductByIdRsp.value?.data?.id
                                        .toString() ??
                                        "",
                                    quantity:
                                    logic.quantity.value.toString() ?? "");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey.shade200,width: 0.5)
                                  ),
                                  child: Icon(Icons.add_shopping_cart,size: 25,color: XColor.primary,)))),

                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),

                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () async {
                                await logic.buyNow(
                                    productId: logic
                                        .getProductByIdRsp.value?.data?.id
                                        .toString() ??
                                        "",
                                    quantity:
                                    logic.quantity.value.toString() ?? "");

                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'Mua ngay',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                              )),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
