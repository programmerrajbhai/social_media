class Post {
  final String title;
  final String image;
  int likes;
  bool isLiked;
  final int comments;

  Post({
    required this.title,
    required this.image,
    required this.likes,
    required this.isLiked,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      image: json['image'],
      likes: json['likes'],
      isLiked: json['isLiked'],
      comments: json['comments'],
    );
  }
}
