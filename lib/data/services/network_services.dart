import 'dart:convert';
import 'package:get/get.dart' hide Response; // Get.find ব্যবহার করার জন্য
import 'package:http/http.dart';
import 'package:logger/logger.dart';
// AuthService ইমপোর্ট করুন, কারণ টোকেন এখানে আছে
import 'package:social_mediaa/login_reg_screens/controllers/auth_service.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage,
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  // ডিফল্ট হেডার
  static Map<String, String> _getHeaders() {
    // AuthService থেকে টোকেনটি নিই
    // main.dart-এ AuthService লোড না হলে এটি কাজ করবে না
    final AuthService authService = Get.find<AuthService>();

    final Map<String, String> headers = {
      'Content-type': 'application/json'
    };

    // যদি টোকেন থাকে, তবে তা হেডারে যোগ করি
    if (authService.token.value.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${authService.token.value}';
    }
    return headers;
  }

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = _getHeaders(); // টোকেন সহ হেডার

      _preRequestLog(url, headers: headers);
      Response response = await get(uri, headers: headers);
      _postRequestLog(url, response.statusCode, responseBody: response.body);

      return _handleResponse(response);
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = _getHeaders(); // টোকেন সহ হেডার

      _preRequestLog(url, body: body, headers: headers);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _postRequestLog(url, response.statusCode, responseBody: response.body);

      return _handleResponse(response);
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  // রেসপন্স হ্যান্ডেল করার জন্য একটি কমন মেথড
  static NetworkResponse _handleResponse(Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodedJson = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        data: decodedJson,
      );
    } else {
      // PHP থেকে আসা এরর মেসেজ দেখানোর চেষ্টা করি
      final decodedJson = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: false,
        errorMessage: decodedJson['message'] ?? "Something went wrong",
        statusCode: response.statusCode,
      );
    }
  }

  // --- আপনার লগিং মেথড ---
  static void _preRequestLog(String url, {Map<String, dynamic>? body, Map<String, String>? headers}) {
    _logger.i('URL=> $url\nHeaders=> $headers\nBody=> ${body ?? ''}');
  }

  static void _postRequestLog(String url, int statusCode, {dynamic responseBody, dynamic errorMessage}) {
    if (errorMessage != null) {
      _logger.e('URL=> $url\nStatusCode=> $statusCode\nError=> $errorMessage');
    } else {
      _logger.i('URL=> $url\nStatusCode=> $statusCode\nResponse=> $responseBody');
    }
  }
}