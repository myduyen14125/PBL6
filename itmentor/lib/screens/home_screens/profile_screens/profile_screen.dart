import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/all_posts_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/create_post_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/create_schedules_screen.dart';
import 'package:itmentor/screens/welcome_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print("current user: ${user.role}");

    String genderText = user.gender ? 'Nam' : 'Nữ';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        icon: const Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Thông tin cá nhân',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/male_avatar.jpg',
                  width: 400,
                  height: 300,
                ),
                ListTile(
                  title: Text('Tên: ${user.name}'),
                ),
                ListTile(
                  title: Text('Email: ${user.email}'),
                ),
                ListTile(
                  title: Text('Ngày Sinh: ${user.dateOfBirth}'),
                ),
                ListTile(
                  title: Text('Giới Tính: $genderText'),
                ),
                user.role == "mentor"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateBlog()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1369B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('Tạo lịch rảnh'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateBlog()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1369B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('Tạo blog'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllPostsScreen(
                                          mentorId: user.id,
                                          mentorToken: user.accessToken,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1369B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('Xem blogs đã viết'),
                          ),
                        ],
                      )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Xác nhận đăng xuất'),
                          content: Text('Bạn có chắc chắn muốn đăng xuất?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                signOutUser(context);
                              },
                              child: const Text(
                                'Có',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Không'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Đăng xuất'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
