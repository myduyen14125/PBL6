import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/account_settings_screen.dart';
import 'package:itmentor/screens/appointment_screen/appointment_screen.dart';
import 'package:itmentor/screens/communication_screen/communication_screen.dart';
import 'package:itmentor/screens/home_screens/course_list/course_list_screen.dart';
import 'package:itmentor/screens/home_screens/homepage_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageNavigationScreen extends StatefulWidget {
  const HomepageNavigationScreen({super.key});

  @override
  State<HomepageNavigationScreen> createState() =>
      _HomepageNavigationScreenState();
}

class _HomepageNavigationScreenState extends State<HomepageNavigationScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  String accessToken = ''; // Add this variable to store the access token

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('x-auth-token') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getAccessToken(); // Call the function to retrieve the access token
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print('homepage access token: $accessToken');

    final List<Widget> _pages = [
      const HomepageScreen(),
      AppointmentScreen(
        token: accessToken,
      ),
      // const CommunicationScreen(),
      const CourseListScreen(),
      const ProfileScreen(),
    ];

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
            label: 'Khoá học',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
