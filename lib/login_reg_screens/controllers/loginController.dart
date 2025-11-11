import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/network_services.dart';
import '../../data/utils/Urls.dart';

class LoginController extends GetxController {

  final String _baseUrl = "http://10.0.2.2/api";
  var isLoading = false.obs;

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
        // লগইন সফল! টোকেন সেভ করি
        String token = response.data?['token'];
        await _saveToken(token);

        // হোম পেজে পাঠাই (এবং লগইন/রেজিস্টার পেজ stack থেকে রিমুভ করি)
        Get.offAllNamed('/home');
      } else {
        // API কল ফেইল বা PHP সাইড থেকে এরর
        Get.snackbar(
          'Login Failed',
          response.data?['message'] ?? response.errorMessage ?? 'Invalid credentials',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // টোকেন সেভ করার প্রাইভেট ফাংশন
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}