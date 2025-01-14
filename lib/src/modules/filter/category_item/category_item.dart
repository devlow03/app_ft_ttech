import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FilterLogic());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Danh mục",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  logic.selectedCategoryTypes.clear();
                },
                child: const Text(
                  "Xóa hết",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.getCategoryRsp.value?.data?.length,
              itemBuilder: (context, index) {
                final dataItem = logic.getCategoryRsp.value?.data?[index];

                return InkWell(onTap: () {
                  if (logic.selectedCategoryTypes.contains(dataItem?.id.toString())) {
                    logic.selectedCategoryTypes.remove(dataItem?.id.toString());
                  } else {
                    logic.selectedCategoryTypes.add(dataItem?.id.toString()??"");
                  }
                }, child: Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: logic.selectedCategoryTypes.contains(dataItem?.id.toString())
                            ? Colors.white
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                        border: logic.selectedCategoryTypes.contains(dataItem?.id.toString())?Border.all(color: XColor.primary):null

                    ),
                    child: Text(
                      dataItem?.name?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: logic.selectedCategoryTypes.contains(dataItem?.id.toString())
                            ? XColor.primary
                            : Colors.black,

                      ),
                    ),
                  );
                }));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 5 / 2,
              ))
        ],
      );
    });
  }
}
