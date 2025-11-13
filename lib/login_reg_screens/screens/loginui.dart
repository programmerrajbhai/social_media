import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/controllers/loginController.dart';

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
                validator: (v) => v!.isEmpty ? 'This field is required' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (v) => v!.isEmpty ? 'Password required' : null,
              ),
              SizedBox(height: 30),
              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submitLogin,
                child: Text('Login'),
              )),
              TextButton(
                onPressed: () => Get.offNamed('/register'),
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