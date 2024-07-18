import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_gadgets/core/constants/text_style.dart';
import 'package:tech_gadgets/presentation/home_screen/controller/product_controller.dart';
import 'package:tech_gadgets/presentation/home_screen/model/product_model.dart';

final ProductController controller = Get.put(ProductController());

class ProductListView extends StatelessWidget {
  Widget countButton(int index, void Function(int index) counter,
      {IconData icon = Icons.add}) {
    return RawMaterialButton(
      onPressed: () {
        counter(index);
      },
      elevation: 2.0,
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget listViewBody(Product item, int index) {
      return Card(
        child: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              item.image,
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(item.name, style: kItemNameStyle),
                ),
                Text(item.description, style: kItemColorStyle),
                Text(item.price, style: kItemPriceStyle),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                countButton(index, controller.increase),
                Obx(() =>
                    Text(controller.allProducts[index].count.toString())),
                countButton(index, controller.decrease, icon: Icons.remove)
              ],
            )
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: controller.allProducts.length,
      itemBuilder: (context, index) {
        Product item = controller.allProducts[index];
        if (controller.isItemListScreen) {
          return listViewBody(item, index);
        } else if (controller.isCartScreen && item.count > 0) {
          return listViewBody(item, index);
        } else {
          return Container();
        }
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2),
    );
  }
}
