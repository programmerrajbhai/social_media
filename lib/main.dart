import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/basescreen/view/screens/base_screens.dart';
import 'package:social_mediaa/home/view/screens/home_screens.dart';
import 'package:social_mediaa/splashScreens/controllers/splashControllers.dart';
import 'package:social_mediaa/splashScreens/screens/splashScreens.dart';

import 'login_reg_screens/controllers/loginController.dart';
import 'login_reg_screens/controllers/regController.dart';
import 'login_reg_screens/screens/loginui.dart';
import 'login_reg_screens/screens/reg_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,

      // অ্যাপটি এখন Splash Page দিয়ে শুরু হবে
      initialRoute: '/splash',

      getPages: [
        // Splash Page-এর রুট ও বাইন্ডিং
        GetPage(
          name: '/splash',
          page: () => SplashPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<SplashController>(() => SplashController());
          }),
        ),

        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<RegisterController>(() => RegisterController());
          }),
        ),

        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<LoginController>(() => LoginController());
          }),
        ),

        GetPage(name: '/home', page: () => BaseScreens()),
      ],
    );
  }
}