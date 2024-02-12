import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_for_job/api_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String phone = phoneController.text.trim();
    final String password = passwordController.text;

    final Map<String, dynamic> responseData = await AuthService.login(phone, password);

    if (responseData['status'] == true) {
      Fluttertoast.showToast(msg: "Login Successful");
    } else {
      if (responseData['error'] != null && responseData['error']['password'] != null) {
        Fluttertoast.showToast(msg: responseData['error']['password'][0]);
      } else if (responseData['error'] != null && responseData['error']['phone'] != null) {
        Fluttertoast.showToast(msg: responseData['error']['phone'][0]);
      } else {
        Fluttertoast.showToast(msg: responseData['error'].values.first[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
