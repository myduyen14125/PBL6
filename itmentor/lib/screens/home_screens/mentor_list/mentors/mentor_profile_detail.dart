import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_screen.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MentorProfileDetail extends StatefulWidget {
  final String id;
  MentorProfileDetail({super.key, required this.id});

  @override
  State<MentorProfileDetail> createState() => _MentorProfileDetailState();
}

class _MentorProfileDetailState extends State<MentorProfileDetail> {
  Map<String, dynamic> userData = {};
  // late List<dynamic> schedules = [];
  // late List<dynamic> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    print(widget.id);
  }

  Future<void> fetchUserData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userData = data;
        // schedules = data['schedules'];
        // blogs = data['blogs'];
      });
      print(data);
      print(data['number_of_mentees']);
      // print(blogs.length);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: userData.isNotEmpty
            ? SingleChildScrollView(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          '${userData['name']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "IT helpdesk tại FPT",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 4,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userData['number_of_mentees'] == null
                                        ? '0'
                                        : '${userData['number_of_mentees']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text('Mentee'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '4',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Giờ cố vấn'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '5.0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Đánh giá'),
                                ],
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       '${blogs.length}',
                              //       style:
                              //           TextStyle(fontWeight: FontWeight.bold),
                              //     ),
                              //     Text('Số bài đăng'),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ChooseSchedule(
                              //         mentorId: userData['_id'],
                              //         schedules: schedules),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1369B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text('Đặt lịch'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // todo add onpressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.favorite,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Yêu thích',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // todo add onpressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.message_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Nhắn tin',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        12.0), // Make the bottom-left corner circular
                                    bottomRight: Radius.circular(
                                        12.0), // Make the bottom-right corner circular
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Giới thiệu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(
                                    16.0), // Add padding around text
                                child: Text(
                                  'Dừng lại là thất bại.',
                                  style: TextStyle(
                                    fontSize:
                                        18, // You can adjust the font size as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Kinh nghiệm làm việc',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18, // Font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.star,
                                    color: Colors.yellow),
                                title: const Text(
                                  'Chief Technology Officer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle:
                                    const Text('Mentori\n09/2019 - Hiện tại'),
                                onTap: () {},
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Học vấn',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.star,
                                    color: Colors.yellow),
                                title: const Text(
                                  'Trường Đại học Khoa học Tự nhiên -\n Đại học Quốc gia Hà Nội',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text(
                                    'Công nghệ phần mềm\n09/2018 - 12/2021'),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.star,
                                    color: Colors.yellow),
                                title: const Text(
                                  'Trường Đại học Ngoại Thương',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text(
                                    'Tài chính quốc tế\n08/2013 - 06/2017'),
                                onTap: () {},
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Hoạt động ngoại khoá',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.star,
                                    color: Colors.yellow),
                                title: const Text(
                                  'Data Hat',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text(
                                    'Founder và Giảng viên\n08/2019 - 12/2020'),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.star,
                                    color: Colors.yellow),
                                title: const Text(
                                  'MOS Excel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle:
                                    const Text('Giảng viên\n08/2016 - 02/2017'),
                                onTap: () {},
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors
                                      .teal, // Change the color to your desired color
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Kỹ năng',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
