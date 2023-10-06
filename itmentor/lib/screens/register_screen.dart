import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/screens/login_screen.dart';
import 'package:itmentor/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  // RegisterScreen createState() => RegisterScreen();
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final AuthServices authServices = AuthServices();

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      email: _usernameController.text,
      password: _passwordController.text,
      // phone: _phoneController.text,
      phone: '1234567890',
      avatar: 'avatar',
      dateOfBirth: '123',
      firstName: 'hung',
      lastName: 'ngoc',
      role: 'mentor',
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = LinearGradient(
      colors: [
        Color(0xFF18BEBC),
        Color(0x6618BEBC),
        Colors.white,
      ],
      stops: [0.0, 0.3, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
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
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Mật khẩu',
                    labelStyle: const TextStyle(
                      color: Color(0xFF1BB55C),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Nhập lại mật khẩu',
                    labelStyle: const TextStyle(
                      color: Color(0xFF1BB55C),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Số điện thoại',
                    labelStyle: const TextStyle(
                      color: Color(0xFF1BB55C),
                    ),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      isChecked = newValue!;
                    });
                  },
                ),
                const Text(
                  'Tôi đồng ý với các điều \n khoản dịch vụ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              ElevatedButton(
                onPressed: isChecked ? signUpUser : (() {}),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isChecked ? const Color(0xFF1369B2) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Đã có tài khoản?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => LoginScreen())));
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Color(0xFF024075),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
  }
}
