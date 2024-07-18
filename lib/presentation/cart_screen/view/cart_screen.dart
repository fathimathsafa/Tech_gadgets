import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_gadgets/core/constants/color_constants.dart';
import 'package:tech_gadgets/core/constants/text_style.dart';
import 'package:tech_gadgets/presentation/home_screen/controller/product_controller.dart';
import 'package:tech_gadgets/presentation/home_screen/widget/product_listview.dart';

final ProductController controller = Get.put(ProductController());

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.navigateToListItemScreen,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cart",
            style: TextStyle(
                color: ColorTheme.maincolor, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: controller.removeItems,
                icon: Icon(
                  Icons.delete_forever,
                  color: ColorTheme.maincolor,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(child: ProductListView()),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Obx(
                      () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: kItemColorStyle.copyWith(fontSize: 12),
                                ),
                                Text(controller.price.value.toString(),
                                    style: kItemPriceStyle)
                              ],
                            ),
                            MaterialButton(
                                color: ColorTheme.maincolor,
                                shape: StadiumBorder(),
                                onPressed: controller.isCheckOutButtonEnabled(),
                                child: Text(
                                  "Buy Now",
                                  style:
                                      TextStyle(color: ColorTheme.primarycolor),
                                ))
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
