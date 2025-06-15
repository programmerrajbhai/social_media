import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/bottom_nav_controller.dart';

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
