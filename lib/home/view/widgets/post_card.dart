import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controller/post_controller.dart';
import '../../model/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final int index;
  final PostController controller;

  const PostCard({
    super.key,
    required this.post,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A4A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=6'),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Blenderr Art', style: TextStyle(color: Colors.white)),
                    Text('8h', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                color: const Color(0xFF2A2A4A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                itemBuilder: (_) => [
                  _popupItem(Icons.bookmark_border, 'Save Post'),
                  _popupItem(Icons.notifications, 'Turn on notifications'),
                  _popupItem(Icons.visibility_off, 'Hide Post'),
                  _popupItem(Icons.person_remove_alt_1, 'Unfollow'),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          // Actions
          Row(
            children: [
              IconButton(
                icon: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : Colors.white70,
                ),
                onPressed: () => controller.toggleLike(index),
              ),
              Text('${post.likes}', style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.comment_outlined, color: Colors.white70),
                onPressed: () {},
              ),
              Text('${post.comments}', style: const TextStyle(color: Colors.white)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.send_outlined, color: Colors.white70),
                onPressed: () {
                  final link = 'https://injoy.app/post/${index + 1}';
                  Clipboard.setData(ClipboardData(text: link));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Copied: $link')));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  static PopupMenuItem<String> _popupItem(IconData icon, String label) {
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
