class Urls {
  // অ্যান্ড্রয়েড ইমুলেটরের জন্য "10.0.2.2" ব্যবহার করুন
  // আসল ফোন ব্যবহার করলে আপনার কম্পিউটারের IP অ্যাড্রেস দিন (e.g., "http://192.168.0.101")
  static const String _baseUrl = "http://192.168.1.107/api/";

  static const String registerApi = "$_baseUrl/register.php";
  static const String loginApi = "$_baseUrl/login.php";
  static const String createPostApi = "$_baseUrl/create_post.php";
  static const String getAllPostsApi = "$_baseUrl/get_all_posts.php";
  static const String uploadImageApi = "$_baseUrl/upload_image.php";
// ... ইত্যাদি
}