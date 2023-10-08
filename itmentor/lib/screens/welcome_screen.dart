import 'package:flutter/material.dart';
import 'package:itmentor/screens/auth_screens/login_screen.dart';
import 'package:itmentor/screens/auth_screens/register_screen.dart';
import 'package:itmentor/utils/constant.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key});

  @override
  State<WelcomeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    String selectedLanguage = 'Tiếng Anh';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
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
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1369B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'ĐĂNG KÝ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '⎯⎯⎯⎯⎯⎯⎯⎯⎯ ',
                  style: TextStyle(color: Colors.blue[400]),
                ),
                const Text(
                  ' hoặc ',
                  style: TextStyle(color: Colors.black45),
                ),
                Text(
                  ' ⎯⎯⎯⎯⎯⎯⎯⎯⎯',
                  style: TextStyle(color: Colors.blue[400]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/google.png'),
                const SizedBox(
                  width: 25,
                ),
                Image.asset('assets/images/mobile.png'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Lựa chọn ngôn \n ngữ của bạn: ',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value:
                      selectedLanguage, 
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 18.0,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.blue[400],
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                  },
                  items: <String>['Tiếng Anh', 'Tiếng Việt']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '© IT Mentor',
              style: TextStyle(
                color: Color(0xFF18BEBC), 
                fontSize:
                    19, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
