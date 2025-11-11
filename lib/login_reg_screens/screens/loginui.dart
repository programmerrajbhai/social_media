import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loginController.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _loginController,
                decoration: InputDecoration(labelText: 'Username or Email'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter username or email' : null,
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

              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: _submitLogin,
                  child: Text('Login'),
                );
              }),

              TextButton(
                onPressed: () {
                  Get.toNamed('/register'); // রেজিস্টার পেজে যাই
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      controller.loginUser(
        loginIdentifier: _loginController.text,
        password: _passwordController.text,
      );
    }
  }
}