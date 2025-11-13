import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/splashScreens/controllers/splashControllers.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলারটিকে ইনিশিয়ালাইজ করার জন্য কল করি
    Get.find<SplashController>();

    return const Scaffold(
      backgroundColor: Color(0xFF0D0D1C), // আপনার থিম কালার
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text("Loading...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}