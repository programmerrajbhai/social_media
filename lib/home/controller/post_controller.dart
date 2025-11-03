import 'package:get/get.dart';
import '../model/post_model.dart';
import '../model/comment_model.dart'; // কমেন্ট মডেল ইম্পোর্ট

class PostController extends GetxController {
  var posts = <Post>[].obs;

  get selectedImage => null;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  void loadPosts() {
    // কিছু ডামি কমেন্ট ডেটা
    List<Comment> comments1 = [
      Comment(username: "Jacob", userImageUrl: "https://i.pravatar.cc/150?img=2", text: "Wow, amazing work!"),
      Comment(username: "Luna", userImageUrl: "https://i.pravatar.cc/150?img=3", text: "Love the colors."),
    ];
    List<Comment> comments2 = [
      Comment(username: "John", userImageUrl: "https://i.pravatar.cc/150?img=4", text: "Incredible!"),
    ];

    posts.value = List.generate(
      20,
          (index) {
        bool isEven = index % 2 == 0;
        return Post(
          title: 'Blender Art #${index + 1}', // ডাইনামিক টাইটেল
          image: 'https://picsum.photos/id/${index + 110}/400/300',
          initialLikes: isEven ? 325 : 150,
          initialIsLiked: isEven ? true : false,
          initialComments: isEven ? comments1.length : comments2.length,
          initialCommentList: isEven ? List<Comment>.from(comments1) : List<Comment>.from(comments2),
        );
      },
    );
  }

  // toggleLike ফাংশনটি রি-অ্যাকটিভ ভ্যারিয়েবল ব্যবহার করার জন্য আপডেট করা হলো
  void toggleLike(int index) {
    final post = posts[index];
    post.isLiked.value = !post.isLiked.value;
    if (post.isLiked.value) {
      post.likes.value++;
    } else {
      post.likes.value--;
    }
  }

  // নতুন কমেন্ট যোগ করার ফাংশন
  void addComment(int postIndex, String commentText) {
    if (commentText.isEmpty) return;

    final post = posts[postIndex];

    // ডামি ইউজার হিসেবে নতুন কমেন্ট যোগ করা হলো
    final newComment = Comment(
      username: "You", // আপনি চাইলে এই নামটি পরিবর্তন করতে পারেন
      userImageUrl: "https://i.pravatar.cc/150?img=1",
      text: commentText,
    );

    post.commentList.add(newComment);
    post.commentCount.value = post.commentList.length; // কাউন্ট আপডেট
  }
}