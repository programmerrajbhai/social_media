import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/upload_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.x.x/upload.php"; // তোমার IP দাও

  static Future<String> uploadData(UploadModel model) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: model.toJson(),
      );

      final data = jsonDecode(response.body);
      return data['message'] ?? 'Unknown response';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
