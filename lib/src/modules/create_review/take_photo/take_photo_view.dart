import 'package:app_ft_tmart/src/modules/create_review/take_photo/take_photo_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TakePhotoPage extends StatelessWidget {
  const TakePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TakePhotoLogic());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx(() {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.images.isNotEmpty == true ? (logic.images.length == 6 ? 6 : logic.images.length + 1) : 1,
            itemBuilder: (context, index) {
              if (logic.itemCount.value != index || index < logic.images.length) {
                return SizedBox(
                  height: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        logic.images[index]!,
                        width: MediaQuery.of(context).size.width * .25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              } else {
                return Visibility(
                  visible: index != 3,
                  child: InkWell(
                      onTap: () async {
                        await logic.pickImage();
                        logic.itemCount.value = index + 1;
                      },
                      child: SvgPicture.asset(
                        'assets/images/add_image.svg',
                        width: 50,
                        fit: BoxFit.fill,
                      )),
                );
              }
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 5 / 5,
            ),
          );
        }),

      ],
    );
  }
}