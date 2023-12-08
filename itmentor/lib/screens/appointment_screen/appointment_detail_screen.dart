import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String accessToken;
  final String scheduleId;
  final String date;
  final int minutes;
  final String position;
  const AppointmentDetailScreen(
      {super.key,
      required this.accessToken,
      required this.scheduleId,
      required this.date,
      required this.minutes,
      required this.position});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  Future<Map<String, dynamic>> fetchData() async {
    final apiUrl =
        Uri.https(Constants.uri, '/appointment/${widget.scheduleId}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.accessToken}'
    };

    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, String>> tipsList = [
    {
      'title': '#1: Làm sao để cố vấn thành công?',
      'subtitle':
          'Chuẩn bị danh sách câu hỏi và chủ đề mà bạn muốn thảo luận và gửi trước cho mentor. Nếu bạn muốn đạt được mục tiêu dài hạn, hãy lên lịch sớm cho buổi cố vấn tiếp theo.'
    },
    {
      'title': '#2: Nên nói gì trong buổi cố vấn?',
      'subtitle':
          'Tìm hiểu kĩ càng thông tin của nhau (lĩnh vực, công ty, kinh nghiệm...). Bạn có thể trao đổi về mục tiêu, thử thách, những thành công hoặc một chủ đề cụ thể mà bạn mong muốn.'
    },
    {
      'title': '#3: Luôn đúng giờ',
      'subtitle':
          'Bạn sẽ nhận được rất nhiều thông báo về buổi cố vấn. Hãy chú ý và đúng giờ! Một buổi cố vấn thành công bắt đầu bằng việc hai bên xuất hiện đúng giờ.'
    },
    {
      'title': '#4: Hãy tiếp tục giữ liên lạc sau buổi cố vấn.',
      'subtitle':
          'Sau buổi cố vấn, hãy tiếp tục giữ liên lạc với mentor. Gãy trao đổi với mentor về sự tiến bộ của bạn, thật ra mentor quan tâm đến thành công của bạn nhiều hơn bạn nghĩ đó.'
    },
    {
      'title': '#5: Làm sao để tạo ra không khí thân thiện?',
      'subtitle':
          'Hãy chủ động chia sẻ về bản thân trước, bạn sẽ nhận ra mentor thật ra muốn lắng nghe câu chuyện của bạn nhiều hơn là chỉ sharing về chính bản thân của họ.'
    },
    {
      'title':
          '#6: Làm gì khi có việc đột xuất và không thể tham gia buổi cố vấn?',
      'subtitle':
          'Hãy liên lạc với mentor ngay lập tức để dời lịch hẹn trước khi mentor xác nhận bạn vắng mặt trong buổi hẹn.'
    },
  ];

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://flutter.dev'),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Text(
                      'Chi tiết cuộc hẹn',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(5),
              child: const Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Cuộc hẹn với:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Lỗi: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    final data = snapshot.data!;
                    final appointmentStatus = data['status'] == 'pending'
                        ? 'Chờ xác nhận'
                        : data['status'] == 'confirmed'
                            ? 'Đã xác nhận'
                            : data['status'] == 'finished'
                                ? 'Đã hoàn thành'
                                : 'Đã huỷ';
                    final meetingLink = data['mentor']['skype_link'] == ''
                        ? data['mentor']['facebook_link']
                        : data['mentor']['skype_link'];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          user.role == "mentee"
                              ? AppointmentDetailTile(
                                  avatarUrl: data['mentor']['avatar'],
                                  name: data['mentor']['name'],
                                  position: 'Lĩnh vực: ${widget.position}',
                                )
                              : AppointmentDetailTile(
                                  avatarUrl: data['mentee']['avatar'],
                                  name: data['mentee']['name'],
                                  position: 'Mentee',
                                ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.verified),
                              const SizedBox(width: 8),
                              Text('Trạng thái: $appointmentStatus',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              const SizedBox(width: 8),
                              Text('Ngày: ${widget.date}',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.timelapse_rounded),
                              const SizedBox(width: 8),
                              Text('${widget.minutes} phút',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.meeting_room_outlined),
                              const SizedBox(width: 8),
                              Flexible(
                                // or Expanded
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Link meeting: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: meetingLink,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _launchUrl();
                                            print('Meeting link tapped!');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.yellow[700],
                                child: Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.white,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              tileColor: Colors.white,
                              title: const Text(
                                'Tips để có buổi cố vấn thành công',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: GestureDetector(
                                onTap: () {
                                  print('Subtitle tapped!');
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: ListView.builder(
                                          itemCount: tipsList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                leading: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.yellow[700],
                                                  child: Icon(
                                                    Icons.lightbulb_outline,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                title: Text(
                                                  tipsList[index]['title'] ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  tipsList[index]['subtitle'] ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Xem ngay',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentDetailTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String position;
  final String? subtitle;

  const AppointmentDetailTile({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.position,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey, width: 1.0),
      ),
      child: ListTile(
        leading: avatarUrl != ""
            ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(avatarUrl),
              )
            : CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.yellow[700],
                ),
              ),
        contentPadding: const EdgeInsets.all(16),
        tileColor: Colors.white,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              position,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
