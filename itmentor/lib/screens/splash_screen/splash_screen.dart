import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> navigateToNextScreen() async {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      // Navigate to the second screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const WelcomeScreen(),
      ));
    }

    navigateToNextScreen();

    const backgroundColor = LinearGradient(
      colors: [
        Color(0xFF18BEBC), // Màu hex #18BEBC
        Color(0x6618BEBC), // Màu hex #18BEBC với độ mờ 40%
        Colors.white, // White color for the bottom
      ],
      stops: [0.0, 0.3, 1.0], // Đặt điểm dừng để xác định độ mờ
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: backgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Splash screen image
              const SizedBox(height: 30,),
              Image.asset(
                'assets/images/logo.png', // Replace with your image asset path
                width: 300, // Adjust the image size as needed
                height: 300,
              ),
              const SizedBox(
                height: 40, // Adjust the spacing between image and text
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 310, // Adjust the spacing between image and text
              ),
              // Company name text at the bottom
              const Text(
                '© IT Mentor',
                style: TextStyle(
                  color: Color(0xFF18BEBC), // Đổi màu văn bản thành #18BEBC
                  fontSize:
                      19, // Có thể điều chỉnh kích thước văn bản theo ý muốn
                  fontWeight: FontWeight.bold, // Đặt kiểu văn bản theo ý muốn
                ),
              ),
              const SizedBox(
                height: 20, // Adjust the spacing between text and progress bar
              ),
              // Progress bar
              
            ],
          ),
        ),
      ),
    );
  }
}
