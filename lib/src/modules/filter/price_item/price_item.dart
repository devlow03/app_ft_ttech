import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/modules/filter/filter_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceItem extends StatelessWidget {
  final FilterLogic logic;
  const PriceItem({
    super.key, required this.logic,
  });

  @override
  Widget build(BuildContext context) {

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
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  logic.selectedPriceRange.clear();
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
                            ? Colors.white
                            : Colors.grey.shade100,
                        border: logic.selectedPriceRange.contains(dataItem["id"])?Border.all(color: XColor.primary):null,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      dataItem["title"] ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: logic.selectedPriceRange.contains(dataItem["id"])
                            ? XColor.primary
                            : Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10,
                childAspectRatio: 5 / 2,
              ))
        ],
      );
    });
  }
}
