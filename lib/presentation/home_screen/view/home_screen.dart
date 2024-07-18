import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:tech_gadgets/core/constants/color_constants.dart';
import 'package:tech_gadgets/presentation/home_screen/controller/product_controller.dart';
import 'package:tech_gadgets/presentation/home_screen/widget/product_listview.dart';

final ProductController controller = Get.put(ProductController());

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Badge(
            badgeContent:
                Obx(() => Text(controller.itemCount.value.toString())),
            child: const Icon(Icons.shopping_cart,),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: controller.navigateToCartScreen,
              ),
            );
          }),
      appBar: AppBar(
        title: Text("TECH GADGETS",style: TextStyle(color: ColorTheme.maincolor,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ProductListView(),
    );
  }
}
