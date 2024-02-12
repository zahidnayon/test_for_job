import 'package:flutter/material.dart';
import 'package:test_for_job/api_service.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService apiService = ApiService();

  void _login(BuildContext context) async {
    final String phone = _phoneController.text;
    final String password = _passwordController.text;

    try {
      final result = await apiService.login(phone, password);
      if (result['status']) {
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Successful!"),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Catch error and show snackbar with message to provide valid phone number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone or password did't match"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
          ),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => _login(context),
          child: Text('Login'),
        ),
      ],
    );
  }
}
