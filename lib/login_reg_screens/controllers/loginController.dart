import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/controllers/auth_service.dart';
import 'package:social_mediaa/data/services/network_services.dart';
import 'package:social_mediaa/data/utils/Urls.dart';

class LoginController extends GetxController {

  var isLoading = false.obs;
  // AuthService-কে খুঁজে নিই
  final AuthService _authService = Get.find<AuthService>();

  Future<void> loginUser({
    required String loginIdentifier,
    required String password,
  }) async {
    try {
      isLoading(true);

      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.loginApi,
        body: {
          'login_identifier': loginIdentifier,
          'password': password,
        },
      );

      if (response.isSuccess && response.data?['status'] == 'success') {

        // লগইন সফল! AuthService-এ ডেটা সেভ করি
        await _authService.saveUserSession(
            response.data!['token'],  // টোকেন
            response.data!['user']    // ইউজার ডেটা (Map)
        );

        Get.offAllNamed('/home'); // BaseScreens-এ পাঠাই
      } else {
        Get.snackbar(
          'Login Failed',
          response.errorMessage ?? 'Invalid credentials',
          backgroundColor: Colors.red, colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }
}