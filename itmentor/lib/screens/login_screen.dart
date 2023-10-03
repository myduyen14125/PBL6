import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Đặt góc bo tròn ở đây
                      ),
                      labelText: 'Tài khoản',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Đặt góc bo tròn ở đây
                      ),
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      )),
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
                      onPressed: (() {}),
                      child: const Text(
                        'Bấm tại đây',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ))
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1369B2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                '© IT Mentor',
                style: TextStyle(
                  color: Color(0xFF18BEBC), // Đổi màu văn bản thành #18BEBC
                  fontSize:
                      19, // Có thể điều chỉnh kích thước văn bản theo ý muốn
                  fontWeight: FontWeight.bold, // Đặt kiểu văn bản theo ý muốn
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
    // Giải phóng bộ nhớ khi không cần thiết
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
