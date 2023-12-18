import 'package:flutter/material.dart';
import 'package:itmentor/screens/auth_screens/forget_password_screen.dart';
import 'package:itmentor/screens/auth_screens/register_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  bool _isLoggingIn = false;
  bool _obscurePassword = true;

  void login() async {
    setState(() {
      _isLoggingIn = true;
    });

    try {
      await authServices.signInUser(
        ctx: context,
        email: _usernameController.text,
        password: _passwordController.text,
      );

      setState(() {
        _isLoggingIn = false;
      });
    } catch (e) {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
                      labelText: 'Tài khoản',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Quên mật khẩu? '),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgetPassword();
                            },
                          ),
                        );
                      }),
                      child: const Text(
                        'Bấm tại đây',
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
                if (_isLoggingIn) // Hiển thị circular progress indicator nếu isLoading là true
                  const CircularProgressIndicator(),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: const Key('loginButton'),
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1369B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
