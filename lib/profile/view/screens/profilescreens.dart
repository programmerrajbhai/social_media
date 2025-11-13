import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/profile/controller/profile_controller.dart';
import 'package:social_mediaa/profile/view/widgets/itemcard.dart'; // ItemCard ইমপোর্ট

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find() ব্যবহার করুন
    final controller = Get.find<ProfileController>();

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

            // Profile Image (Obx দিয়ে রিয়েল-টাইম করা)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(controller.profilePicUrl),
              )),
            ),

            const SizedBox(height: 12),

            // User Name (Obx দিয়ে রিয়েল-টাইম করা)
            Obx(() => Text(
              controller.user.value?.fullName ?? 'Guest User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            // User Email (Obx দিয়ে রিয়েল-টাইম করা)
            Obx(() => Text(
              controller.user.value?.email ?? 'guest@mail.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            )),

            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // ... (আপনার অন্যান্য ItemCard) ...

                  // Logout
                  ItemCard(
                    icon: Icons.logout,
                    title: 'Logout',
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                    onTap: controller.logout, // সরাসরি কন্ট্রোলার মেথড কল
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