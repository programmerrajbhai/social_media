import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // File ক্লাস ব্যবহারের জন্য

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {






  final TextEditingController _postTextController = TextEditingController();
  File? _imageFile; // নির্বাচিত ছবির জন্য
  final ImagePicker _picker = ImagePicker(); // ImagePicker ইনস্ট্যান্স
  // bool _isPosting = false; // লোডিং স্টেট দেখানোর জন্য - removed

  @override
  void dispose() {
    _postTextController.dispose();
    super.dispose();
  }

  // ছবি গ্যালারি থেকে নেওয়ার ফাংশন
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() {
    String postContent = _postTextController.text.trim();

    if (postContent.isEmpty && _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('পোস্ট করার জন্য কিছু লিখুন বা ছবি যোগ করুন।')),
      );
      return;
    }

    // setState(() {
    //   _isPosting = true; // লোডিং শুরু করুন - removed
    // });

    // সার্ভার ইন্টিগ্রেশন লজিক এখানে ছিল, যা এখন সরানো হয়েছে।
    // এখানে আপনি পোস্ট তৈরি করার জন্য UI-মাত্রিক লজিক রাখতে পারেন,
    // যেমন: একটি ডামি মেসেজ দেখানো বা আগের স্ক্রিনে ফিরে যাওয়া।

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('পোস্ট তৈরি করা হয়েছে (শুধুমাত্র UI): $postContent')),
    );
    Navigator.pop(context, true); // আগের স্ক্রিনে ফিরে যান
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন পোস্ট তৈরি করুন'),
        actions: [
          TextButton(
            onPressed: _createPost, // _isPosting চেক সরানো হয়েছে
            child: const Text( // লোডিং ইন্ডিকেটর সরানো হয়েছে
              'পোস্ট করুন',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child:  Icon(Icons.person, color: Colors.grey[600], size: 30),
                  // backgroundImage: NetworkImage('আপনার_প্রোফাইল_ছবির_URL'), // আপনার প্রোফাইল ছবি এখানে যোগ করুন
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _postTextController,
                    decoration: const InputDecoration(
                      hintText: "আপনার মনের কথা লিখুন...",
                      border: InputBorder.none,
                      filled: false,
                    ),
                    maxLines: null, // আনলিমিটেড লাইন
                    keyboardType: TextInputType.multiline,
                    autofocus: true, // স্ক্রিন খুললেই কীবোর্ড দেখাবে
                  ),
                ),
              ],
            ),
            if (_imageFile != null) // যদি ছবি যুক্ত করা হয়, তাহলে এখানে ছবিটি দেখাবে
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(_imageFile!, fit: BoxFit.contain), // ছবির ফিট মোড
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black, size: 30),
                      onPressed: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            const Spacer(), // নিচের অপশনগুলোকে নিচে রাখতে সাহায্য করে
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPostOptionButton(
                  icon: Icons.photo_library,
                  label: 'ছবি/ভিডিও',
                  color: Colors.green,
                  onTap: () {
                    _pickImage(ImageSource.gallery); // গ্যালারি থেকে ছবি নেওয়ার জন্য
                  },
                ),
                _buildPostOptionButton(
                  icon: Icons.tag_faces,
                  label: 'অনুভূতি/অ্যাক্টিটিভি',
                  color: Colors.orange,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('অনুভূতি/অ্যাক্টিভিটি ফাংশনালিটি যোগ করুন')),
                    );
                  },
                ),
                _buildPostOptionButton(
                  icon: Icons.location_on,
                  label: 'চেক ইন',
                  color: Colors.red,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('চেক ইন ফাংশনালিটি যোগ করুন')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // পোস্ট অপশন বাটন তৈরির হেল্পার উইজেট
  Widget _buildPostOptionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.black87, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
