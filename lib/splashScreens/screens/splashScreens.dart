import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splashControllers.dart';

// এখানে GetView ব্যবহার না করে GetWidget ব্যবহার করছি
// কারণ SplashController-কে আমরা এই পেজের বাইন্ডিং-এই রাখবো
class SplashPage extends GetWidget<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলারটি ইনিশিয়ালাইজ করার জন্য 'controller' ভেরিয়েবলটি কল করা জরুরি
    Get.find<SplashController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}