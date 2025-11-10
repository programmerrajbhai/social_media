import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/data/services/network_services.dart';
import '../../data/utils/Urls.dart';
import '../widgets/Textfromfield.dart';
import '../widgets/containnerBox.dart';

class RegistrationScreens extends StatefulWidget {
  const RegistrationScreens({super.key});

  @override
  State<RegistrationScreens> createState() => _RegistrationScreensState();
}

class _RegistrationScreensState extends State<RegistrationScreens> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 400),
              textfromfield(
                controller: _usernameController,
                icon: Icons.account_box,
                text: 'username',
              ),
              SizedBox(height: 8),
              textfromfield(
                controller: _fullnameController,
                icon: Icons.account_box,
                text: 'full name',
              ),
              SizedBox(height: 8),
              textfromfield(
                controller: _emailController,
                icon: Icons.email,
                text: 'email address',
              ),
              SizedBox(height: 8),
              textfromfield(
                controller: _passwordController,
                obscureText: true,
                icon: Icons.lock,
                text: 'Password',
              ),
              SizedBox(height: 8),

              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _onTapRegisterButton();
                },
                child: containnerBox(
                  bgColors: Colors.black,
                  text: "Registration",
                  textColors: Colors.white,
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              containnerBox(
                bgColors: Colors.white,
                text: 'Sign up by google',

                textColors: Colors.black,
              ),
              SizedBox(height: 40),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        // recognizer: TapGestureRecognizer()..onTap = () {
                        //   Get.to(LoginScreen());
                        // },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapRegisterButton() async {
    Map<String, dynamic> requestBody = {
      "username": _usernameController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "full_name": _fullnameController.text.trim(),
    };
    NetworkResponse responseNetwork = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    if(responseNetwork.isSuccess){

      print('Successss');
    }else{
      print('errorrr');

    }

  }
}
