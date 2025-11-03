import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';
import '../../model/comment_model.dart';
import '../widgets/post_card.dart'; // PostCard এখানেও ব্যবহার হবে

class PostDetailPage extends StatelessWidget {
  final int postIndex;
  PostDetailPage({super.key, required this.postIndex});

  final PostController controller = Get.find();
  final TextEditingController _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color darkBlue = Color(0xFF1B1B3C); // মেইন ব্যাকগ্রাউন্ড
    const Color mediumBlue = Color(0xFF2A2A4A); // কার্ডের ব্যাকগ্রাউন্ড

    final post = controller.posts[postIndex];

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: Text(post.title),
        backgroundColor: mediumBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ১. পোস্ট কার্ড
          // isDetailPage: true পাস করা হয়েছে যেন এখানে কমেন্ট বাটনে ক্লিক না হয়
          PostCard(
            post: post,
            index: postIndex,
            controller: controller,
            isDetailPage: true,
          ),

          // ২. কমেন্টের লিস্ট
          Expanded(
            child: Obx( // Obx দিয়ে র্যা প করা হলো যেন নতুন কমেন্ট আসলে লিস্ট আপডেট হয়
                  () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: post.commentList.length,
                itemBuilder: (context, index) {
                  final Comment comment = post.commentList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(comment.userImageUrl),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: mediumBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment.text,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // ৩. কমেন্ট করার ইনপুট ফিল্ড
          _buildCommentInput(context, mediumBlue),
        ],
      ),
    );
  }

  // কমেন্ট ইনপুট ফিল্ডের উইজেট
  Widget _buildCommentInput(BuildContext context, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 8,
        bottom: 8 + MediaQuery.of(context).viewInsets.bottom, // কি-বোর্ড হ্যান্ডেল করার জন্য
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentTextController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: () {
              // কন্ট্রোলার থেকে addComment ফাংশন কল করা হলো
              controller.addComment(postIndex, _commentTextController.text);
              _commentTextController.clear();
              FocusScope.of(context).unfocus(); // কি-বোর্ড হাইড করা হলো
            },
          ),
        ],
      ),
    );
  }
}