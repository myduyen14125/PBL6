import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(color: Colors.red),
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
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppointmentDetailTile(
                            avatarUrl: data['mentor']['avatar'],
                            name: data['mentor']['name'],
                            position: 'Lĩnh vực: ${widget.position}',
                          ),
                          const SizedBox(height: 16),
                          Text('Chủ đề: Chủ đề bất kì',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Trạng thái: $appointmentStatus',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined),
                              const SizedBox(width: 8),
                              Text('Ngày: ${widget.date}',
                                  style: TextStyle(fontSize: 16)),
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
                          const SizedBox(height: 16),
                          const AppointmentDetailTile(
                            avatarUrl: '',
                            name: 'Tips để có buổi cố vấn thành công',
                            position: '',
                            subtitle: 'Xem ngay',
                          ),
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
