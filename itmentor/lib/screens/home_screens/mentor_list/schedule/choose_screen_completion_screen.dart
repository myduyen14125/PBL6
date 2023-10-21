import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/homepage_screen.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';


class ChooseScreenCompletionScreen extends StatelessWidget {
  final String mentorId;
  final String scheduleId;
  const ChooseScreenCompletionScreen(
      {super.key, required this.mentorId, required this.scheduleId});

  

  @override
  Widget build(BuildContext context) {
    
    print('mentor id: ${mentorId}');
    print('schedule id: ${scheduleId}');
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomepageNavigationScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Kết quả',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/icons/done_icon.png',
                width: 120,
                height: 120,
              ),
              const Text(
                'Đặt lịch thành công',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
              ClipOval(
                child: Image.asset(
                  'assets/images/male_avatar.jpg',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Nhận cố vấn từ ',
                    ),
                    TextSpan(
                      text: 'mentor2',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              Text('Nghề nghiệp'),
              Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.calendar_month),
                      SizedBox(
                        width: 10,
                      ),
                      Text('14:30,Chủ Nhật, 29/10/2023'),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.timelapse),
                      SizedBox(
                        width: 10,
                      ),
                      Text('60 phút'),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.info),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Hình thức kết nối: Google Meet'),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 4, // Add elevation for a card-like effect
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Add rounded corners
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 231, 14),
                          ),
                          child: const Icon(
                            Icons.star,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                            width:
                                16), // Add some space between the icon and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Constants.result,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      8), // Add vertical space between the texts
                              Text(
                                Constants.result2,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
