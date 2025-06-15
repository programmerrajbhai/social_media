import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
    );
  }
}
