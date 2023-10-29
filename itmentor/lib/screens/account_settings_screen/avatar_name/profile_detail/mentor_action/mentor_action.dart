import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/profile_screens/all_posts_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/create_post_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/all_current_schedules.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/create_schedules_screen.dart';
import 'package:itmentor/services/auth_services.dart';

class MentorAction extends StatelessWidget {
  final String token;
  final String mentorId;
  MentorAction({super.key, required this.mentorId, required this.token});

  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateSchedules(token: token),
              ),
            );
          },
          child: const Card(
            elevation: 3,
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Color(0xFF009688), // Teal color
            child: ListTile(
              leading: Icon(
                Icons.schedule,
                color: Colors.white,
              ),
              title: Text(
                'Tạo lịch rảnh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBlog(token: token),
              ),
            );
          },
          child: const Card(
            elevation: 3,
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Color(0xFFF57C00), // Orange color
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              title: Text(
                'Tạo blog',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            String? token = await authServices.getToken();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllPostsScreen(
                  mentorId: mentorId,
                  mentorToken: token!,
                ),
              ),
            );
          },
          child: const Card(
            elevation: 3,
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Color(0xFF8E44AD), // Purple color
            child: ListTile(
              leading: Icon(
                Icons.library_books,
                color: Colors.white,
              ),
              title: Text(
                'Xem blogs đã viết',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllCurrentSchedules(token: token),
              ),
            );
          },
          child: const Card(
            elevation: 3,
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Color(0xFFE74C3C),
            child: ListTile(
              leading: Icon(
                Icons.event,
                color: Colors.white,
              ),
              title: Text(
                'Xem lịch đã tạo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
