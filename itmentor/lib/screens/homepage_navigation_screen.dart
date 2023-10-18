import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/screens/account_settings_screen/account_settings_screen.dart';
import 'package:itmentor/screens/appointment_screen/appointment_screen.dart';
import 'package:itmentor/screens/communication_screen/communication_screen.dart';
import 'package:itmentor/screens/home_screens/homepage_screen.dart';

class HomepageNavigationScreen extends StatefulWidget {
  const HomepageNavigationScreen({super.key});

  @override
  State<HomepageNavigationScreen> createState() =>
      _HomepageNavigationScreenState();
}

class _HomepageNavigationScreenState extends State<HomepageNavigationScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomepageScreen(),
    const AppointmentScreen(),
    const CommunicationScreen(),
    const AccountSettingsScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch hẹn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Liên hệ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
