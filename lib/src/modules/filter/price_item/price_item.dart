import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceItem extends StatelessWidget {
  const PriceItem({
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
                "Khoảng giá",
                style: TextStyle(
                    fontSize: 16,
                    color: XColor.greyGlobal,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  logic.selectedPriceRange.clear();
                },
                child: const Text(
                  "Xóa hết",
                  style: TextStyle(
                    fontSize: 12,
                    color: XColor.greyGlobal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.priceRange.length,
              itemBuilder: (context, index) {
                final dataItem = logic.priceRange[index];

                return InkWell(onTap: () {
                  if (logic.selectedPriceRange.contains(dataItem["id"])) {
                    logic.selectedPriceRange.remove(dataItem["id"] ?? "");
                  } else {
                    logic.selectedPriceRange.add(dataItem["id"] ?? "");
                  }
                }, child: Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: logic.selectedPriceRange.contains(dataItem["id"])
                            ? const Color(0xff01CB69)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      dataItem["title"] ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: logic.selectedPriceRange.contains(dataItem["id"])
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
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
