import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AllCurrentSchedules extends StatefulWidget {
  final String token;
  const AllCurrentSchedules({super.key, required this.token});

  @override
  State<AllCurrentSchedules> createState() => _AllCurrentSchedulesState();
}

class _AllCurrentSchedulesState extends State<AllCurrentSchedules> {
  List<Map<String, dynamic>> scheduleData = [];

  Future<void> fetchData() async {
    final uri = Uri.https(Constants.uri, '/schedule');
    print('schedules token : ${widget.token}');
    final headers = {'Authorization': "Bearer ${widget.token}"};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        scheduleData = data.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load schedule data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đã tạo'),
      ),
      body: SfCalendar(
        view: CalendarView.week, // Choose your desired view
        dataSource: ScheduleDataSource(scheduleData),
      ),
    );
  }
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Map<String, dynamic>> source) {
    appointments = source
        .map((data) => Appointment(
              startTime: DateTime.parse(data['start_at']),
              endTime: DateTime.parse(data['end_at']),
            ))
        .toList();
  }
}
