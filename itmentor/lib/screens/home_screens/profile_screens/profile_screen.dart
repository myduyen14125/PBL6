import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/all_posts_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/create_post_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/all_current_schedules.dart';
import 'package:itmentor/screens/home_screens/profile_screens/schedules/create_schedules_screen.dart';
import 'package:itmentor/screens/welcome_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token != null || token != '') {
      return token;
    }
  }

  Future<Map<String, dynamic>> fetchProfile(String token) async {
    final uri = Uri.https(Constants.uri, '/user/profile');
    final response = await http.get(uri, headers: <String, String>{
      'Connection': 'keep-alive',
      'Authorization': 'Bearer $token',
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
      ),
      body: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.done) {
            if (tokenSnapshot.hasError) {
              // Handle the error
              return Center(child: Text('Error: ${tokenSnapshot.error}'));
            }

            final token = tokenSnapshot.data;

            return FutureBuilder<Map<String, dynamic>>(
              future: fetchProfile(token!),
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState == ConnectionState.done) {
                  if (profileSnapshot.hasError) {
                    // Handle the error
                    return Center(
                        child: Text('Error: ${profileSnapshot.error}'));
                  }

                  final data = profileSnapshot.data;

                  // Extract data and build your UI here
                  final name = data!['name'];
                  final email = data['email'];
                  final dateOfBirth = data['date_of_birth'];
                  final gender = data['gender'];
                  final role = data['role'];
                  final id = data['_id'];

                  String genderText = gender ? 'Nam' : 'Nữ';

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Your UI Widgets here
                        // Example:
                        Text('Tên: $name'),
                        Text('Email: $email'),
                        Text('Ngày Sinh: $dateOfBirth'),
                        Text('Giới Tính: $genderText'),

                        // Add more widgets as needed
                        role == "mentor"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateSchedules(token: token,)),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1369B2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                            builder: (context) =>
                                                const CreateBlog()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1369B2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: const Text('Tạo blog'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String? token = await getToken();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllPostsScreen(
                                            mentorId: id,
                                            mentorToken: token!,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1369B2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: const Text('Xem blogs đã viết'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllCurrentSchedules(token: token)),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1369B2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: const Text('Xem lịch đã tạo'),
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
                                  content:
                                      Text('Bạn có chắc chắn muốn đăng xuất?'),
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
                  );
                } else {
                  // Return a loading indicator or another widget while waiting for the result.
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            // Return a loading indicator or another widget while waiting for the result.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
