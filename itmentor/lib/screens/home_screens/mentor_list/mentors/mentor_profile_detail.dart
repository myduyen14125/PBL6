import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
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

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userData = data;
      });
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
            ? Center(
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
                              children: const [
                                Text(
                                  '4',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Mentee'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '4',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Giờ cố vấn'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '5.0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Đánh giá'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '10',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Lượt theo dõi'),
                              ],
                            ),
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
                            print('clicked đặt lịch');
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
                            // Xử lý sự kiện khi nút được nhấn
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
                                Icons.add_box_outlined,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Theo dõi',
                                style: TextStyle(color: Colors.black),
                              ), // Văn bản nút
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
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
                        child: Column(
                          children: [
                            Text('Giới thiệu'),
                            Text('Bio'),
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
                        child: Column(
                          children: [
                            Text('Kinh nghiệm làm việc'),
                            ListTile(
                              leading: Icon(Icons.star),
                              title: Text('Chief Technology Officer'),
                              subtitle: Text('Mentori\n09/2019 - Hiện tại'),
                              onTap: () {},
                            ),
                            Text('Mô tả công việc'),
                            ListTile(
                              leading: Icon(Icons.star),
                              title: Text('Chief Technology Officer'),
                              subtitle: Text('Mentori\n09/2019 - Hiện tại'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
