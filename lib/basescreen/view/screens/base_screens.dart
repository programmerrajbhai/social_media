import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --- আপনার পেজগুলো ইমপোর্ট করুন ---
import 'package:social_mediaa/createpost/view/screens/create_post.dart';
import 'package:social_mediaa/message/view/screens/message_screens.dart';
import 'package:social_mediaa/notification/view/screens/notification_screens.dart';
import 'package:social_mediaa/profile/view/screens/profilescreens.dart';
import 'package:social_mediaa/home/view/screens/home_screens.dart';
import '../../controller/bottom_nav_controller.dart';

// Main Page with Bottom Navigation and Screens
class BaseScreens extends StatelessWidget {
  const BaseScreens({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find() ব্যবহার করুন, কারণ কন্ট্রোলার main.dart-এ লোড হয়েছে
    final bottomNavController = Get.find<BottomNavController>();

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: bottomNavController.currentIndex.value,
          children: [
            const SocialHomePage(),
            const MessagesPage(),
            CreatePost(),
            const NotificationPage(),
            const ProfilePage(),
          ],
        );
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

// Custom Bottom Navigation Bar Widget
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();

    return Obx(() => BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: controller.changeTab,
      backgroundColor: const Color(0xFF1B1B3C),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.call_made_outlined), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: 'Add'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notify'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    ));
  }
}