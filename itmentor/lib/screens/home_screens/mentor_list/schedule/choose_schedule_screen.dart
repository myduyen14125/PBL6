import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_detail_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ChooseSchedule extends StatefulWidget {
  final String mentorId;
  final String mentorName;

  ChooseSchedule({Key? key, required this.mentorId, required this.mentorName})
      : super(key: key);

  @override
  State<ChooseSchedule> createState() => _ChooseScheduleState();
}

class _ChooseScheduleState extends State<ChooseSchedule> {
  List<Map<String, dynamic>> apiData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.mentorId}/schedules');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        apiData = jsonData.cast<Map<String, dynamic>>();
        apiData =
            apiData.where((schedule) => schedule['status'] == true).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Chọn lịch',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Chọn ngày',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: apiData.map((schedule) {
                  final startAt = DateTime.parse(schedule['start_at']);
                  final endAt = DateTime.parse(schedule['end_at']);
                  final dateFormatted =
                      DateFormat('dd/MM/yyyy').format(startAt);
                  final dayOfWeek = DateFormat('EEEE').format(startAt);
                  final timeFormatted = DateFormat('HH:mm:ss').format(startAt);

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChooseScheduleDetailScreen(
                                scheduleId: schedule['_id'],
                                mentorId: widget.mentorId,
                                mentorName: widget.mentorName,
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              dateFormatted,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              dayOfWeek,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Time: $timeFormatted',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
