import 'package:flutter/material.dart';
import 'package:tech_gadgets/core/constants/color_constants.dart';
import 'package:tech_gadgets/presentation/login_screen/view/login_screen.dart';
import 'package:tech_gadgets/presentation/registration_screen/operations/sql_operations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name_controller = TextEditingController();
  final pass_controller = TextEditingController();
  final email_controller = TextEditingController();
  final phon_controller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  String? pass;

  @override
  Widget build(BuildContext context) {
    void registerUser(
        String name, String email, String phonenum, String password) async {
      var id = await SQL_Functions.adduser(name, email, phonenum, password);
      print(id);
      if (id != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration Failed")));
      }
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme.maincolor,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                Text("Welcome To Tech Gadgets",
                    style: TextStyle(
                        color: ColorTheme.primarycolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: 100),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Enter a valid Username";
                      } else {
                        return null;
                      }
                    },
                    controller: name_controller,
                    style: TextStyle(color: ColorTheme.maincolor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: ColorTheme.maincolor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: 50),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (Phone) {
                      if (Phone!.isEmpty|| Phone.length != 10) {
                        
                        return "invalid phone number";
                      } 
                      
                    },
                    controller: phon_controller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: ColorTheme.maincolor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone Number',
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
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Invalid email / or empty field";
                      } 
                    },
                    controller: email_controller,
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
                    textInputAction: TextInputAction.next,
                    validator: (pwd) {
                      if (pwd!.isEmpty || pwd.length < 6) {
                        return "Length Should be > 6 / field must not empty ";
                      } 
                    },
                    controller: pass_controller,
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
                      onPressed: () async {
                          var valid = formkey.currentState!.validate();
                          if (valid == true) {
                            var users = await SQL_Functions
                                .checkUserAlreadyRegistered(
                                email_controller.text);
                            if (users.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      "User Already Registered")));
                            } else {
                              registerUser(
                                  name_controller.text, email_controller.text,
                                  phon_controller.text, pass_controller.text);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please Fill All the Fields")));
                          }

                          
                        },
                      color: ColorTheme.primarycolor,
                      child: Text(
                        "Register",
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Already have an account? login here ",
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
