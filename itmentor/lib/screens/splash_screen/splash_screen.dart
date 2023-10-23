import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/screens/welcome_screen.dart';
import 'package:itmentor/utils/constant.dart';

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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const WelcomeScreen(),
      ));
    }

    navigateToNextScreen();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(
                height: 40,
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                height: 310,
              ),
              const Text(
                '© IT Mentor',
                style: TextStyle(
                  color: Color(0xFF18BEBC),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
