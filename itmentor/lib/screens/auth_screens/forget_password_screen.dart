import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/screens/auth_screens/login_screen.dart';
import 'package:itmentor/screens/auth_screens/register_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _usernameController = TextEditingController();
  bool isLoading = false;

  Future<void> callForgetPasswordApi(String email) async {
    setState(() {
      isLoading = true;
    });
    final apiUrl = Uri.https(Constants.uri, '/auth/forgot-password');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 201) {
        // Handle success
        setState(() {
          isLoading = false;
        });
        print('Forget Password API call successful');
        print('Response: ${response.body}');
        showSnackBar(
            context, 'Thành công. Hãy kiểm tra email để lấy mật khẩu mới!');
        setState(() {
          _usernameController.text = "";
        });
      } else {
        // Handle error
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Email không hợp lệ hoặc chưa đăng kí');
        print(
            'Forget Password API call failed with status ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Email không hợp lệ hoặc chưa đăng kí');
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Đã có tài khoản? '),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      }),
                      child: const Text(
                        'Đăng nhập',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chưa có tài khoản? '),
                    TextButton(
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      }),
                      child: const Text(
                        'Đăng kí tại đây',
                      ),
                    ),
                  ],
                ),
                if (isLoading) const CircularProgressIndicator(),
                ElevatedButton(
                  key: const Key('forgetPassword'),
                  onPressed: () {
                    if (_usernameController.text.isEmpty) {
                      showSnackBar(context, 'Vui lòng nhập email');
                      return;
                    }
                    callForgetPasswordApi(_usernameController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1369B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Lấy lại mật khẩu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  '© IT Mentor',
                  style: TextStyle(
                    color: Color(0xFF18BEBC),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
