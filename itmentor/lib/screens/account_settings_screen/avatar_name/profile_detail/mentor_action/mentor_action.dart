import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/profile_screens/all_posts_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/create_post_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/all_current_schedules.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/create_schedules_screen.dart';
import 'package:itmentor/services/auth_services.dart';

class MentorAction extends StatelessWidget {
  final String token;
  final String mentorId;

  MentorAction({Key? key, required this.mentorId, required this.token})
      : super(key: key);

  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildActionCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateSchedules(token: token),
              ),
            );
          },
          icon: Icons.schedule,
          title: 'Tạo lịch rảnh',
          color: Color(0xFF009688),
        ),
        const SizedBox(height: 10),
        _buildActionCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBlog(token: token),
              ),
            );
          },
          icon: Icons.edit,
          title: 'Tạo blog',
          color: Color(0xFFF57C00),
        ),
        _buildActionCard(
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
          icon: Icons.library_books,
          title: 'Xem blogs đã viết',
          color: Color(0xFF8E44AD),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildActionCard({
    required VoidCallback onTap,
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
