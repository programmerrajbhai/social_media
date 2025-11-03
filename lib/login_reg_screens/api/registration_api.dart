import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/registration_model.dart';

class RegistrationApi {
  static const String url = "http://10.0.2.2/flutter_api/save_user.php";

  static Future<Map<String, dynamic>> addUser(RegistrationModel user) async {
    try {
      final response = await http.post(Uri.parse(url), body: user.toMap());

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'status': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
