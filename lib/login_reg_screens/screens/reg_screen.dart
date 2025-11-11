import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/regController.dart';
// আপনার কন্ট্রোলার ইমপোর্ট করুন
// GetView ব্যবহার করলে কন্ট্রোলার সরাসরি 'controller' নামে পাওয়া যায়
class RegisterPage extends GetView<RegisterController> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter username' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty ? 'Please enter email' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter full name' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter password' : null,
              ),
              SizedBox(height: 30),

              // Obx দিয়ে বাটনটিকে রি-বিল্ড করি (লোডিং স্টেট অনুযায়ী)
              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: _submitRegistration,
                  child: Text('Register'),
                );
              }),

              TextButton(
                onPressed: () {
                  Get.toNamed('/login'); // লগইন পেজে যাই
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      controller.registerUser(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
      );
    }
  }
}