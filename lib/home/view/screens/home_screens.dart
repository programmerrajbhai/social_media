import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';
import '../widgets/post_card.dart';

class SocialHomePage extends StatelessWidget {
  const SocialHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B1B3C),
        title: const Text(
          'Social Media',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: const [Icon(Icons.settings), SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          // Story Section
          SizedBox(
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 12),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                final names = [
                  'You',
                  'Jacob',
                  'Luna',
                  'John',
                  'Netaliya',
                  'Extra',
                ];
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=${index + 1}',
                        ),
                        child:
                            index == 0
                                ? const Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.add,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(names[index], style: const TextStyle(fontSize: 12)),
                  ],
                );
              },
            ),
          ),

          const Divider(color: Colors.white12, thickness: 0.5),
          // Feed Section
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    post: controller.posts[index],
                    index: index,
                    controller: controller,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
