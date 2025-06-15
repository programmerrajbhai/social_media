import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/profile/controller/profile_controller.dart';
import 'package:social_mediaa/profile/view/widgets/itemcard.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1C),
      body: SafeArea(
        child: Column(

          children: [
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Image with Gradient Border
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/2.jpg'),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'James Bond',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Tomhill@mail.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 8),

                  // Preferences
                  ItemCard(
                    icon: Icons.settings,
                    title: 'Preferences',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                    onTap: () {
                      Get.snackbar("Preferences", "Preferences Clicked", backgroundColor: Colors.black87, colorText: Colors.white);
                    },
                  ),
                  const Divider(color: Colors.white12, indent: 72, endIndent: 16),

                  // Account Security with progress
                  Obx(() => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C2E),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ItemCard(
                          icon: Icons.lock,
                          title: 'Account Security',
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                          onTap: () {
                            Get.snackbar("Security", "Account Security Clicked", backgroundColor: Colors.black87, colorText: Colors.white);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: controller.securityLevel.value,
                              backgroundColor: Colors.grey[800],
                              color: Colors.blueAccent,
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 4),
                            child: Text('Excellent', style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  )),

                  // Notifications with Switch
                  Obx(() => ItemCard(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    trailing: Switch(
                      value: controller.isNotificationOn.value,
                      onChanged: (val) {
                        controller.isNotificationOn.value = val;
                      },
                      activeColor: Colors.blueAccent,
                    ),
                    onTap: () {
                      controller.isNotificationOn.value = !controller.isNotificationOn.value;
                    },
                  )),
                  const Divider(color: Colors.white12, indent: 72, endIndent: 16),

                  // Privacy Policy
                  ItemCard(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                    onTap: () {
                      Get.defaultDialog(title: "Privacy Policy", middleText: "This is a demo privacy policy.");
                    },
                  ),
                  const Divider(color: Colors.white12, indent: 72, endIndent: 16),

                  // Customer Support
                  ItemCard(
                    icon: Icons.help_outline,
                    title: 'Customer Support',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                    onTap: () {
                      Get.snackbar("Support", "Support Clicked", backgroundColor: Colors.black87, colorText: Colors.white);
                    },
                  ),
                  const Divider(color: Colors.white12, indent: 72, endIndent: 16),

                  // Logout
                  ItemCard(
                    icon: Icons.logout,
                    title: 'Logout',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                    onTap: () {
                      Get.defaultDialog(
                        title: "Logout",
                        middleText: "Are you sure you want to logout?",
                        textCancel: "Cancel",
                        textConfirm: "Logout",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          // Handle logout
                          Get.back();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
