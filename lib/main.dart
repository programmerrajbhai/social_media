import 'package:flutter/material.dart';

import 'add_post.dart';
// import 'package:http/http.dart' as http; // Removed server-related import
// import 'dart:convert'; // Removed server-related import


void main() {
  runApp(const MyApp());
}

// --- আপনার পোস্ট মডেল (main.dart এর উপরে বা একটি model/post.dart ফাইলে রাখুন) ---
// এই মডেলটি এখন শুধুমাত্র UI-তে ডামি ডাটা দেখানোর জন্য ব্যবহৃত হবে।
class Post {
  final String id;
  final String username;
  final String text;
  final String? imageUrl;
  final String time;

  Post({
    required this.id,
    required this.username,
    required this.text,
    this.imageUrl,
    required this.time,
  });

// factory Post.fromJson(Map<String, dynamic> json) { // Removed server-related factory
//   return Post(
//     id: json['id'].toString(),
//     username: json['username'] ?? 'Anonymous',
//     text: json['text'] ?? '',
//     imageUrl: json['imageUrl'],
//     time: json['createdAt'] ?? 'Just now',
//   );
// }
}
// -------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'আমার সোশ্যাল মিডিয়া',
      debugShowCheckedModeBanner: false, // ডিবাগ ব্যানার সরান
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SocialHomePage(),
    );
  }
}

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  _SocialHomePageState createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  int _selectedIndex = 0;
  List<Post> _posts = []; // পোস্ট লোড করার জন্য লিস্ট
  // bool _isLoading = true; // লোডিং স্টেট - Removed

  // final String _baseUrl = 'http://10.0.2.2/social_app_backend/api'; // Removed server-related base URL

  @override
  void initState() {
    super.initState();
    _loadDummyPosts(); // ডামি পোস্ট লোড করুন
  }

  // ডামি পোস্ট তৈরি করার ফাংশন
  void _loadDummyPosts() {
    setState(() {
      _posts = List.generate(
        5, // উদাহরণস্বরূপ ৫টি ডামি পোস্ট
            (index) => Post(
          id: (index + 1).toString(),
          username: 'ব্যবহারকারী ${index + 1}',
          text: 'এটি একটি ডামি পোস্ট #${index + 1}. এখানে পোস্টের বিস্তারিত বিবরণ থাকবে। এই টেক্সটটি আরও দীর্ঘ হতে পারে এবং একাধিক লাইন নিতে পারে।',
          imageUrl: index % 2 == 0 ? 'https://picsum.photos/id/${100 + index}/400/250' : null,
          time: '${index + 1} ঘন্টা আগে',
        ),
      );
      // _isLoading = false; // Removed
    });
  }

  // পোস্ট ফেচ করার ফাংশন (সার্ভার কোড সরানো হয়েছে, এখন ডামি ডাটা)
  // Future<void> _fetchPosts() async { // Removed
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     final response = await http.get(Uri.parse('$_baseUrl/get_posts.php'));
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> postsJson = json.decode(response.body);
  //       setState(() {
  //         _posts = postsJson.map((json) => Post.fromJson(json)).toList();
  //         _isLoading = false;
  //       });
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('পোস্ট লোড করতে ব্যর্থ: ${response.statusCode}')),
  //       );
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('পোস্ট লোড করতে সমস্যা: $e')),
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) { // 'পোস্ট' ট্যাব (ইনডেক্স 2)
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddPostScreen()),
      );
      if (result == true) { // যদি নতুন পোস্ট সফলভাবে তৈরি হয় (ডামি)
        _loadDummyPosts(); // ডামি পোস্ট রিফ্রেশ করুন
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- ১. অ্যাপ বার (Header) ---
      appBar: AppBar(
        title: const Text(
          'আমার সোশ্যাল মিডিয়া',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {
              // সার্চ ফাংশনালিটি
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('সার্চ বাটন ক্লিক করা হয়েছে')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined, size: 28),
            onPressed: () {
              // মেসেজ ফাংশনালিটি
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('মেসেজ বাটন ক্লিক করা হয়েছে')),
              );
            },
          ),
        ],
      ),

      // --- ২. বাম পাশের ড্রয়ার (Sidebar) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("আপনার নাম", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text("আপনার ইমেইল"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "আ", // আপনার নামের প্রথম অক্ষর
                  style: TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('হোম'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0; // হোম ট্যাব নির্বাচন
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: const Text('এক্সপ্লোর'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1; // এক্সপ্লোর ট্যাব নির্বাচন
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('গ্রুপস'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('গ্রুপস পেজ খুলছে...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('সেভড পোস্টস'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('সেভড পোস্টস পেজ খুলছে...')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('সেটিংস ও প্রাইভেসি'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('সেটিংস পেজ খুলছে...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('সহায়তা'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('সহায়তা পেজ খুলছে...')),
                );
              },
            ),
          ],
        ),
      ),

      // --- ৩. মূল কন্টেন্ট এরিয়া ---
      body: _getBodyWidget(_selectedIndex),

      // --- ৪. বটম নেভিগেশন বার ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'হোম',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'এক্সপ্লোর',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'পোস্ট',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'নোটিফিকেশন',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'প্রোফাইল',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }

  // নির্বাচিত ট্যাবের উপর ভিত্তি করে কন্টেন্ট দেখানোর ফাংশন
  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return _buildHomeFeed(); // হোম ফিড
      case 1:
        return const Center(child: Text('এক্সপ্লোর পেজ', style: TextStyle(fontSize: 20)));
      case 2:
        return const Center(child: Text('পোস্ট তৈরি করার জন্য একটি নতুন স্ক্রিনে যাওয়া হবে', style: TextStyle(fontSize: 20)));
      case 3:
        return const Center(child: Text('নোটিফিকেশন পেজ', style: TextStyle(fontSize: 20)));
      case 4:
        return const Center(child: Text('প্রোফাইল পেজ', style: TextStyle(fontSize: 20)));
      default:
        return _buildHomeFeed();
    }
  }

  // --- হোম ফিড তৈরির ফাংশন ---
  Widget _buildHomeFeed() {
    return Column(
      children: [
        // পোস্ট তৈরির বক্স
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey[200],
                        child:  Icon(Icons.person, color: Colors.grey[600], size: 28),
                        // backgroundImage: NetworkImage('আপনার_প্রোফাইল_ছবির_URL'), // আপনার প্রোফাইল ছবি এখানে যোগ করুন
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          readOnly: true, // শুধু ট্যাপ করলে ইনপুট দেওয়ার জন্য
                          onTap: () {
                            // নতুন পোস্ট তৈরি পৃষ্ঠায় নেভিগেট করুন
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddPostScreen()),
                            ).then((value) {
                              if (value == true) { // যদি নতুন পোস্ট সফলভাবে তৈরি হয় (ডামি)
                                _loadDummyPosts(); // ডামি পোস্ট রিফ্রেশ করুন
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "আপনার মনের কথা লিখুন...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 25, thickness: 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPostOptionButton(Icons.photo_library, 'ছবি/ভিডিও', Colors.green),
                      _buildPostOptionButton(Icons.tag_faces, 'অনুভূতি', Colors.orange),
                      _buildPostOptionButton(Icons.videocam, 'লাইভ', Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // নিউজ ফিড
        Expanded(
          child: _posts.isEmpty // _isLoading চেক সরানো হয়েছে
              ? const Center(child: Text('কোনো পোস্ট নেই।'))
              : RefreshIndicator( // পোস্ট রিফ্রেশ করার জন্য
            onRefresh: () async { // অন-রিফ্রেশ এখন ডামি ডাটা লোড করবে
              _loadDummyPosts();
            },
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return PostCard(
                  username: post.username,
                  time: post.time,
                  postText: post.text,
                  imageUrl: post.imageUrl,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // পোস্ট অপশন বাটন তৈরির হেল্পার ফাংশন
  Widget _buildPostOptionButton(IconData icon, String label, Color color) {
    return TextButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label অপশন ক্লিক করা হয়েছে!')),
        );
      },
      icon: Icon(icon, color: color),
      label: Text(label, style: const TextStyle(color: Colors.black87)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

// --- পোস্ট কার্ড উইজেট (একই ফাইলে রাখা হয়েছে বোঝার সুবিধার জন্য) ---
class PostCard extends StatelessWidget {
  final String username;
  final String time;
  final String postText;
  final String? imageUrl; // ছবি ঐচ্ছিক

  const PostCard({
    super.key,
    required this.username,
    required this.time,
    required this.postText,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blueAccent,
                  child: Text(username[0], style: const TextStyle(color: Colors.white, fontSize: 18)),
                  // backgroundImage: NetworkImage('পোস্টকারীর_প্রোফাইল_ছবির_URL'), // পোস্টকারীর প্রোফাইল ছবি যোগ করুন
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}), // পোস্ট অপশন
              ],
            ),
            const SizedBox(height: 10),
            Text(
              postText,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            if (imageUrl != null) ...[
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200, // ছবির নির্দিষ্ট উচ্চতা
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey[400])),
                ),
              ),
            ],
            const SizedBox(height: 15),
            const Divider(height: 1, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInteractionButton(Icons.thumb_up_alt_outlined, 'লাইক'),
                  _buildInteractionButton(Icons.comment_outlined, 'কমেন্ট'),
                  _buildInteractionButton(Icons.share_outlined, 'শেয়ার'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ইন্টারঅ্যাকশন বাটন তৈরির হেল্পার ফাংশন
  Widget _buildInteractionButton(IconData icon, String label) {
    return InkWell(
      onTap: () {
        debugPrint('$label ক্লিক করা হয়েছে');
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 5),
            Text(label, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
