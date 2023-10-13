import 'package:app_ft_tmart/src/widget/global_image.dart';
import 'package:app_ft_tmart/src/widget/global_webview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/xcolor.dart';
import 'news_logic.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NewsLogic());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Tin tức công nghệ",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() {

        return RefreshIndicator(
          onRefresh: ()async{
            logic.refresh();
          },
          child: ListView(
            children: [
              CarouselSlider.builder(
                  itemCount: logic.getNewsRsp.value?.articles?.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Visibility(
                          child: Visibility(
                            visible:  logic.getNewsRsp.value?.articles?.isNotEmpty==true,
                            replacement: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: (){
                                Get.to(GlobalWebview(
                                  tittleWeb: logic.getNewsRsp.value?.articles?[index].title,
                                  linkWeb: logic.getNewsRsp.value?.articles?[index].url,
                                ));
                              },
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            logic.getNewsRsp.value?.articles?[index]
                                                .urlToImage ?? ""),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.2),
                                            // Màu của box shadow và độ mờ
                                            spreadRadius:
                                            5,
                                            // Điều chỉnh bán kính mở rộng của box shadow
                                            blurRadius:
                                            10,
                                            // Điều chỉnh độ mờ của box shadow
                                            offset: Offset(0,
                                                3), // Điều chỉnh độ dịch chuyển của box shadow
                                          ),
                                        ], borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                logic.getNewsRsp.value?.articles?[index]
                                                    .title ?? "",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.5,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Icon(Icons.person,size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 2,),
                                                  Text(logic.getNewsRsp.value?.articles?[index]
                                                      .author ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),
                                                  ),



                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                  options: CarouselOptions(
                    aspectRatio: 20 / 10,
                    autoPlay: true,
                    enlargeCenterPage: true

                    // viewportFraction: 1
                  )),

              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tin mới nhất",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: logic.getNewsRsp.value?.articles?.isNotEmpty==true,
                      replacement: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: Colors.grey,
                                      height: 100,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .35,

                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*.5,
                                            height: 40,
                                            decoration: BoxDecoration(

                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20,),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*.5,
                                            height: 20,
                                            decoration: BoxDecoration(

                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      ),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: logic.getNewsRsp.value?.articles?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible:  logic.getNewsRsp.value?.articles?[index]
                                .urlToImage!=null,
                            child: InkWell(
                              onTap: (){
                                Get.to(GlobalWebview(
                                  tittleWeb: logic.getNewsRsp.value?.articles?[index].title,
                                  linkWeb: logic.getNewsRsp.value?.articles?[index].url,
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: GlobalImage(
                                        imageUrl:
                                        logic.getNewsRsp.value?.articles?[index]
                                            .urlToImage ?? "",
                                        height: 100,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .35,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              logic.getNewsRsp.value?.articles?[index]
                                                  .title ?? "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),

                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                                logic.getNewsRsp.value
                                                    ?.articles?[index]
                                                    .description ?? "",
                                            maxLines: 3,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
