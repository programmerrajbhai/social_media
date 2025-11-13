import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --- আপনার ফাইল ইমপোর্ট ---
import 'package:social_mediaa/basescreen/controller/bottom_nav_controller.dart';
import 'package:social_mediaa/basescreen/view/screens/base_screens.dart';
import 'package:social_mediaa/profile/controller/profile_controller.dart';
import 'package:social_mediaa/splashScreens/controllers/splashControllers.dart';
import 'package:social_mediaa/splashScreens/screens/splashScreens.dart';
import 'package:social_mediaa/login_reg_screens/controllers/auth_service.dart';
import 'package:social_mediaa/login_reg_screens/controllers/loginController.dart';
import 'package:social_mediaa/login_reg_screens/controllers/regController.dart';
import 'package:social_mediaa/login_reg_screens/screens/loginui.dart';
import 'package:social_mediaa/login_reg_screens/screens/reg_screen.dart';

// (CreatePost কন্ট্রোলার ইমপোর্ট করুন)
// import 'package:social_mediaa/createpost/controller/create_post_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // অ্যাপ রান করার আগেই AuthService ইনিশিয়ালাইজ করি
  await Get.putAsync(() => AuthService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // আপনার UI অনুযায়ী ডার্ক থিম
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<SplashController>(() => SplashController());
          }),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<LoginController>(() => LoginController());
          }),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<RegisterController>(() => RegisterController());
          }),
        ),

        // '/home' রুটটি BaseScreens এবং তার সব কন্ট্রোলার লোড করবে
        GetPage(
          name: '/home',
          page: () => BaseScreens(),
          binding: BindingsBuilder(() {
            // BaseScreens-এর কন্ট্রোলার
            Get.lazyPut<BottomNavController>(() => BottomNavController());

            // BaseScreens-এর ভেতরের পেজগুলোর কন্ট্রোলার
            Get.lazyPut<ProfileController>(() => ProfileController());
            // Get.lazyPut<HomeController>(() => HomeController());
            // Get.lazyPut<MessageController>(() => MessageController());
            // Get.lazyPut<CreatePostController>(() => CreatePostController());
            // Get.lazyPut<NotificationController>(() => NotificationController());
          }),
        ),
      ],
    );
  }
}