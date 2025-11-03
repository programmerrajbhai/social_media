
import 'package:get/get.dart';

import 'comment_model.dart'; // নতুন কমেন্ট মডেল ইম্পোর্ট

class Post {
  final String title;
  final String image;

  // ভ্যারিয়েবলগুলোকে রি-অ্যাকটিভ করা হলো
  final RxInt likes;
  final RxBool isLiked;
  final RxInt commentCount;
  final RxList<Comment> commentList; // কমেন্টের লিস্ট

  Post({
    required this.title,
    required this.image,
    required int initialLikes,
    required bool initialIsLiked,
    required int initialComments,
    required List<Comment> initialCommentList,
  }) :
        likes = initialLikes.obs,
        isLiked = initialIsLiked.obs,
        commentCount = initialComments.obs,
        commentList = initialCommentList.obs;
}