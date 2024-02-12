import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(String phone, String password) async {
    final Uri uri = Uri.parse('https://babsaye.com/api/login');
    final http.Response response = await http.post(
      uri,
      body: {
        'phone': phone,
        'password': password,
      },
    );
    return json.decode(response.body);
  }
}
