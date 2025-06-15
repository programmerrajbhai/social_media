import 'package:get/get.dart';
import '../model/post_model.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  void loadPosts() {
    posts.value = List.generate(
      5,
          (index) => Post(
        title: 'Blender Art',
        image: 'https://picsum.photos/id/${index + 10}/400/300',
        likes: 325,
        isLiked: false,
        comments: 98,
      ),
    );
  }

  void toggleLike(int index) {
    posts[index].isLiked = !posts[index].isLiked;
    posts[index].likes += posts[index].isLiked ? 1 : -1;
    posts.refresh();
  }
}
