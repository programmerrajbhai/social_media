import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_mediaa/login_reg_screens/api/registration_api.dart';
import 'package:social_mediaa/login_reg_screens/model/registration_model.dart';

class Registration_Controller{

  TextEditingController firstname_controller= TextEditingController();
  TextEditingController lastname_controller= TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();



  Future<void> SubmitRegistration(BuildContext context) async {
    String firstname = firstname_controller.text.trim();
    String lastname = lastname_controller.text.trim();
    String email = email_controller.text.trim();
    String password = password_controller.text.trim();

    // ১. Validation check
    if (firstname.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid data")),
      );
      return; // spinner show হবে না
    }

    // ২. Spinner show করা
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false, // user cannot dismiss
    );

    // ৩. API call
    RegistrationModel user = RegistrationModel(firstname, lastname, email, password);
    var result = await RegistrationApi.addUser(user);

    // ৪. Spinner hide করা
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    // ৫. Response দেখানো
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'])),
    );

    // ৬. Success হলে controller clear করা
    if (result['status']) {
      firstname_controller.clear();
      lastname_controller.clear();
      email_controller.clear();
      password_controller.clear();
    }
  }


}

