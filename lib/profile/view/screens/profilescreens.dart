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
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Image with Border
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.white, size: 16),
                ),
              ],
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

            // Preferences
            ItemCard(
              icon: Icons.settings,
              title: 'Preferences',
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
            ),

            // Account Security with progress bar
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

            // Customer Support
            ItemCard(
              icon: Icons.help_outline,
              title: 'Customer Support',
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
            ),

            // Logout
            ItemCard(
              icon: Icons.logout,
              title: 'Logout',
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
            ),

            const Spacer(),

            // Bottom Padding
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
