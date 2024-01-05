import 'package:flutter/material.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';
import 'package:itmentor/utils/constant.dart';

class ChooseScreenCompletionScreen extends StatelessWidget {
  final String mentorAvatar;
  final String mentorName;
  final String selectedDate;
  final int duration;
  final String connectionChoice;
  final String subject;
  const ChooseScreenCompletionScreen(
      {super.key,
      required this.mentorAvatar,
      required this.mentorName,
      required this.selectedDate,
      required this.duration,
      required this.connectionChoice,
      required this.subject});

  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      'Kết quả',
                      style: TextStyle(fontSize: 20),
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
                'Đặt lịch hẹn thành công',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipOval(
                child: mentorAvatar == ""
                    ? Image.asset(
                        'assets/images/male_avatar.jpg',
                        height: 100,
                        width: 100,
                      )
                    : Image.network(
                        mentorAvatar, // Assuming mentorAvatar is a URL
                        height: 100,
                        width: 100,
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Nhận cố vấn từ ',
                    ),
                    TextSpan(
                      text: mentorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.calendar_month),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$selectedDate',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.timelapse),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$duration phút',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.info),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hình thức kết nối: $connectionChoice',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                Constants.result2,
                                style: const TextStyle(
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
