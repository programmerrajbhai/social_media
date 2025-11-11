import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/network_services.dart';
import '../../data/utils/Urls.dart';
class RegisterController extends GetxController {

  // API বেস URL (ইমুলেটরের জন্য 10.0.2.2 ব্যবহার করুন)
  final String _baseUrl = "http://10.0.2.2/api";

  // UI-তে লোডিং স্টেট দেখানোর জন্য
  var isLoading = false.obs;

  // রেজিস্ট্রেশন ফাংশন
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      isLoading(true); // লোডিং শুরু

      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.registerApi,
        body: {
          'username': username,
          'email': email,
          'password': password,
          'full_name': fullName,
        },
      );

      if (response.isSuccess && response.data?['status'] == 'success') {
        // রেজিস্ট্রেশন সফল
        Get.snackbar(
          'Success',
          response.data?['message'] ?? 'Registration successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // সফল হলে লগইন পেজে ফেরত পাঠাই
        Get.offNamed('/login'); // .offNamed দিয়ে Register পেজটি stack থেকে রিমুভ হবে
      } else {
        // API কল ফেইল বা PHP সাইড থেকে এরর
        Get.snackbar(
          'Registration Failed',
          response.data?['message'] ?? response.errorMessage ?? 'Something went wrong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false); // লোডিং শেষ
    }
  }
}