import 'dart:convert';

class User {
  final int userId;
  final String username;
  final String email;
  final String fullName;
  final String? profilePictureUrl;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.fullName,
    this.profilePictureUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      username: map['username'],
      email: map['email'],
      fullName: map['full_name'],
      profilePictureUrl: map['profile_picture_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'full_name': fullName,
      'profile_picture_url': profilePictureUrl,
    };
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}