import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    // কন্ট্রোলারটি চালু হওয়ামাত্রই টোকেন চেক করবে
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // SharedPreferences থেকে টোকেনটি পড়ার চেষ্টা করি
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    // আমরা ১ সেকেন্ড অপেক্ষা করবো শুধু লোডিং দেখানোর জন্য (ঐচ্ছিক)
    await Future.delayed(Duration(seconds: 1));

    if (token != null && token.isNotEmpty) {
      // টোকেন আছে, ইউজার লগইন করা আছে
      Get.offAllNamed('/home'); // হোম পেজে পাঠাই
    } else {
      // টোকেন নেই, ইউজারকে লগইন করতে হবে
      Get.offAllNamed('/login'); // লগইন পেজে পাঠাই
    }
  }
}