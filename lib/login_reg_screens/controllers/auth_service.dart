import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userModel.dart'; // মডেল ইমপোর্ট

class AuthService extends GetxService {
  var token = ''.obs;
  var user = Rxn<User>(); // Nullable User

  // অ্যাপ চালু হলে সার্ভিসটি ইনিশিয়ালাইজ হবে
  Future<AuthService> init() async {
    await loadUserSession();
    return this;
  }

  // লগইন সফল হলে এই ফাংশন কল হবে
  Future<void> saveUserSession(String userToken, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('auth_token', userToken);

    User loggedInUser = User.fromMap(userData);
    await prefs.setString('user_data', loggedInUser.toJson());

    // GetX ভেরিয়েবল আপডেট করি
    token.value = userToken;
    user.value = loggedInUser;
  }

  // Splash Screen থেকে এই ফাংশন কল হবে
  Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();

    final String? userToken = prefs.getString('auth_token');
    final String? userDataString = prefs.getString('user_data');

    if (userToken != null && userDataString != null) {
      token.value = userToken;
      user.value = User.fromJson(userDataString);
    }
  }

  // লগআউট করার জন্য
  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');

    token.value = '';
    user.value = null;

    Get.offAllNamed('/login'); // লগইন পেজে পাঠাই
  }
}