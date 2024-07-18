import 'package:flutter/material.dart';
import 'package:tech_gadgets/core/constants/color_constants.dart';
import 'package:tech_gadgets/presentation/admin_home/view/admin_home.dart';
import 'package:tech_gadgets/presentation/home_screen/view/home_screen.dart';
import 'package:tech_gadgets/presentation/registration_screen/operations/sql_operations.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var cemailid = TextEditingController();
  var cpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    void loginUser(String email, String pwd) async {
      // admin login
      if (email == "admin@gmail.com" && pwd == "Admin@123") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      } else {
        var data = await SQL_Functions.checkUserAlreadyRegistered(
          email,
        );
        if (data.isNotEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProductListScreen()));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User not found")));
        }
      }
    }

    return Scaffold(
      backgroundColor: ColorTheme.maincolor,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .15,
                ),
                Text("Welcome Back To Tech Gadgets",
                    style: TextStyle(
                        color: ColorTheme.primarycolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: 150),
                  child: TextFormField(
                    controller: cemailid,
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Invalid email / or empty field";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: ColorTheme.maincolor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none),
                    ),
                    style: TextStyle(color: ColorTheme.maincolor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: 50),
                  child: TextFormField(
                    controller: cpass,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return "Password is empty /<6";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorTheme.maincolor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none),
                    ),
                    style: TextStyle(color: ColorTheme.maincolor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 70),
                  child: Container(
                    height: 45,
                    width: 200,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        var valid = formkey.currentState!.validate();
                                          if (valid == true) {
                                               loginUser(cemailid.text, cpass.text);
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(
                                                      'Please Fill All The Fields')));
                                            }
                      },
                      color: ColorTheme.primarycolor,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: ColorTheme.maincolor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Don't have an account? Register here ",
                      style: TextStyle(color: ColorTheme.secondarycolor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
