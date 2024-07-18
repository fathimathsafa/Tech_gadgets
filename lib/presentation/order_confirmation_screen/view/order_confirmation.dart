import 'package:flutter/material.dart';
import 'package:tech_gadgets/core/constants/color_constants.dart';
import 'package:tech_gadgets/presentation/home_screen/view/home_screen.dart';
import 'package:tech_gadgets/presentation/login_screen/view/login_screen.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme.maincolor,
      appBar: AppBar(
        backgroundColor: ColorTheme.maincolor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorTheme.primarycolor,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .4,
            ),
            Icon(
              Icons.done,
              color: ColorTheme.primarycolor,
              size: 50,
            ),
            Text(
              "Order Confirmed",
              style: TextStyle(
                  color: ColorTheme.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: size.height * .1,
            ),
          ],
        ),
      ),
    );
  }
}
