import 'package:flutter/material.dart';

class textfromfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? text;
  final bool obscureText;

  const textfromfield({
    Key? key,
    required this.controller,       // controller required
    this.icon,
    this.text,
    this.obscureText = false,      // password hide optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,        // <-- assign controller here
      obscureText: obscureText,      // <-- hide text if needed
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
