import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/data/services/network_services.dart';
import 'package:social_mediaa/data/utils/Urls.dart';

class RegisterController extends GetxController {

  var isLoading = false.obs;
  // (UI থেকে কন্ট্রোলারগুলো এখানে মুভ করা ভালো)
  // final TextEditingController usernameController = TextEditingController();
  // ...

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      isLoading(true);
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
        Get.snackbar(
          'Success',
          response.data?['message'] ?? 'Registration successful!',
          backgroundColor: Colors.green, colorText: Colors.white,
        );
        Get.offNamed('/login'); // সফল হলে লগইন পেজে
      } else {
        Get.snackbar(
          'Registration Failed',
          response.errorMessage ?? 'Something went wrong',
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