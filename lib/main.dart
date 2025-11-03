import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/basescreen/view/screens/base_screens.dart';
import 'package:social_mediaa/login_reg_screens/screens/reg_screen.dart';
import 'basescreen/controller/bottom_nav_controller.dart';
import 'home/view/screens/home_screens.dart';

void main() {
  Get.put(BottomNavController()); // add this line ✅

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'INJOY Social App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1B1B3C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B3C),
          elevation: 0,
        ),
      ),
      home: const RegistrationScreens(),
    );
  }
}
