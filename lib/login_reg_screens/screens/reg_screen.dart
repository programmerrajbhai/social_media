import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/controllers/resgitration_controller.dart';
import '../widgets/Textfromfield.dart';
import '../widgets/containnerBox.dart';

class RegistrationScreens extends StatefulWidget {
  const RegistrationScreens({super.key});

  @override
  State<RegistrationScreens> createState() => _RegistrationScreensState();
}

class _RegistrationScreensState extends State<RegistrationScreens> {


  late final Registration_Controller reg_controller = Registration_Controller();

  @override
  void dispose() {
    // ✅ সব controller dispose করা
    reg_controller.firstname_controller.dispose();
    reg_controller.lastname_controller.dispose();
    reg_controller.email_controller.dispose();
    reg_controller.password_controller.dispose();

    super.dispose();
  }


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

              SizedBox(height: 400,),
              textfromfield(
                  controller: reg_controller.firstname_controller,
                  icon: Icons.account_box, text: 'First Name'),
              SizedBox(height: 8),
              textfromfield(
                controller: reg_controller.lastname_controller,
                  icon: Icons.account_box, text: 'Last Name'),
              SizedBox(height: 8),
              textfromfield(
                  controller:reg_controller.email_controller,
                  icon: Icons.email, text: 'Email Address'),
              SizedBox(height: 8),
              textfromfield(
                controller: reg_controller.password_controller,
                  obscureText: true,
                  icon: Icons.lock, text: 'Password'),
              SizedBox(height: 8),

              SizedBox(height: 16),
              InkWell(
                onTap: (){
                 reg_controller.SubmitRegistration(context);
                },
                child: containnerBox(
                  bgColors: Colors.black,
                  text: "Registration",
                  textColors: Colors.white,
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
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
}
