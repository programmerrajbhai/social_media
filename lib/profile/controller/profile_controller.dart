import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/controllers/auth_service.dart';
import '../../login_reg_screens/model/userModel.dart';

class ProfileController extends GetxController {

  final AuthService _authService = Get.find<AuthService>();

  // UI-তে দেখানোর জন্য একটি গেটার (getter)
  Rxn<User> get user => _authService.user;

  // প্রোফাইল ছবির জন্য একটি গেটার
  String get profilePicUrl =>
      _authService.user.value?.profilePictureUrl ??
          'https://randomuser.me/api/portraits/women/2.jpg'; // ডিফল্ট ছবি

  // লগআউট মেথড
  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textCancel: "Cancel",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () {
        // AuthService-কে বলি সেশন ক্লিয়ার করতে
        _authService.clearUserSession();
      },
    );
  }
}