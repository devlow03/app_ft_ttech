import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/xcolor.dart';
import '../../data/respository/prod_category_res.dart';
import 'product_logic.dart';

class ProductPage extends StatelessWidget {
  final ProdCategory? data;

  const ProductPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProductLogic(Get.find()));
    logic.getSliderProd(id: data?.id.toString()??"");
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black38,

                    ),
                    child: const Icon(Icons.arrow_back))

            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark
            ),
            expandedHeight: MediaQuery
                .of(context)
                .size
                .height * .45,
            flexibleSpace: FlexibleSpaceBar(
              background: Obx(() {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      itemCount: logic.getSliderProdRsp.value?.slider
                          ?.length ??
                          0,
                      options: CarouselOptions(
                        aspectRatio: 20 / 21,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        onPageChanged: (index, reason) {
                          logic.activeIndex.value = index;
                        },


                        viewportFraction: 1,
                        // enlargeCenterPage: true,
                        // enableInfiniteScroll: true
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Image.network(
                            logic.getSliderProdRsp.value?.slider?[index]
                                .linkImg ?? '',
                            // width: MediaQuery
                            //     .of(context)
                            //     .size
                            //     .width,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 50,
                      child: Center(
                        // bottom: 2,
                          child: AnimatedSmoothIndicator(
                            count: logic.getSliderProdRsp.value?.slider?.length??0,
                            activeIndex: logic.activeIndex.value ?? 0,
                            effect: ScrollingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 3,
                              dotColor: Colors.grey,
                              activeDotColor: XColor.primary,
                            ),
                          )),
                    ),
                  ],
                );
              }),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            pinned: true,
            stretch: true,
            actions: [
              IconButton(
                  onPressed: () {
                    // Fluttertoast.showToast(
                    //     msg: "Đã thêm sản phẩm vào yêu thích", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
                  },
                  icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black38,

                      ),
                      child: const Icon(Icons.favorite_border))

              ),
              IconButton(
                  onPressed: () {
                    // Get.to(SearchPage());
                  },
                  icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black38,

                      ),
                      child: const Icon(Icons.search))

              ),
              IconButton(
                  onPressed: () {
                    // Get.to(CartPage(),transition: Transition.rightToLeft);
                  },
                  icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black38,

                      ),
                      child: const Icon(Icons.shopping_bag_outlined))
              ),
            ],

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)
                    )
                ),
                child: Container(
                  // width: 40,
                  // height: 5,
                  // decoration: BoxDecoration(
                  //   color: Colors.grey,
                  //   borderRadius: BorderRadius.circular(100)
                  // ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data?.nameType}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text('${data?.name}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow.shade300,),
                          Text('4.5(231)')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text('${data?.descript}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,

                    ),
                    maxLines: 7,
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Giá:'),
                          const SizedBox(width: 3,),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'VI').format(int
                                .parse(data?.price.toString() ?? "")),
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.w500

                            ),

                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Màu sắc: '),
                          const SizedBox(width: 5),
                          Icon(Icons.circle, color: Colors.deepPurple,),
                          Icon(Icons.circle, color: Colors.black,),
                          Icon(Icons.circle, color: Colors.yellow,),
                          Icon(Icons.circle, color: Colors.grey,)
                        ],
                      ),


                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text('Số lượng: '),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [

                            const SizedBox(width: 3,),
                            Icon(Icons.remove, size: 15,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text('1'),
                            ),
                            Icon(Icons.add, size: 15),

                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Phiên bản: '),
                          const SizedBox(width: 2,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,
                                vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: XColor.primary
                                )
                            ),
                            child: Text('256GB',
                              style: TextStyle(color: XColor.primary),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,
                                vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black
                                )
                            ),
                            child: Text('128GB',
                            ),
                          ),


                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {

                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: () async {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Mua ngay",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
