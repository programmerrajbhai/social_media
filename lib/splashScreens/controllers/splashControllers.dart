import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/controllers/auth_service.dart';

class SplashController extends GetxController {

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // SharedPreferences লোড হওয়ার জন্য ১ সেকেন্ড সময় দিই
    await Future.delayed(Duration(seconds: 1));

    // AuthService থেকে চেক করি টোকেন আছে কি না
    if (_authService.token.value.isNotEmpty) {
      Get.offAllNamed('/home'); // লগইন করা থাকলে BaseScreens-এ যাই
    } else {
      Get.offAllNamed('/login'); // লগইন করা না থাকলে লগইন পেজে
    }
  }
}