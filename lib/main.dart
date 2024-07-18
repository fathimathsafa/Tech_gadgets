import 'package:flutter/material.dart';
import 'package:tech_gadgets/presentation/registration_screen/view/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  RegistrationScreen(),
    );
  }
}

