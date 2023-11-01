import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateSchedules extends StatefulWidget {
  final String token;
  const CreateSchedules({super.key, required this.token});

  @override
  State<CreateSchedules> createState() => _CreateSchedulesState();
}

class _CreateSchedulesState extends State<CreateSchedules> {
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
    final user = Provider.of<UserProvider>(context).user;
    Future<void> postSchedule({
      required DateTime start,
    }) async {
      final apiUrl = Uri.https(Constants.uri, '/schedule');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      };

      final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');

      final String startAt = dateFormat.format(DateTime(
        start.year,
        start.month,
        start.day,
        start.hour,
        start.minute,
        00,
      ));

      final String endAt = dateFormat.format(DateTime(start.year, start.month,
          start.day, start.hour + 1, start.minute, 00));

      final Map<String, dynamic> requestBody = {
        "start_at": startAt,
        "end_at": endAt,
      };

      String requestBodyJson = jsonEncode(requestBody);

      try {
        final http.Response response = await http.post(
          apiUrl,
          headers: headers,
          body: requestBodyJson,
        );

        if (response.statusCode == 201) {
          showSnackBar(context, 'Đã tạo lịch thành công');
          fetchData();
        } else {
          print("POST request failed with status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error during POST request: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo lịch rảnh'),
      ),
      body: Center(
        child: SfCalendar(
          view: CalendarView.week,
          onTap: (CalendarTapDetails details) {
            if (details.targetElement == CalendarElement.calendarCell) {
              DateTime selectedDate = details.date!;
              print(
                  "Selected date: ${selectedDate.year}:${selectedDate.month}:${selectedDate.day}T${selectedDate.hour}:${selectedDate.minute}0:00");
              print(
                  "End date: ${selectedDate.year}:${selectedDate.month}:${selectedDate.day}T${selectedDate.hour + 1}:${selectedDate.minute}0:00");

              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Thời gian đã chọn:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${selectedDate.hour}:${selectedDate.minute}0 - ${selectedDate.hour + 1}:${selectedDate.minute}0, ngày ${DateFormat('dd-MM-yyyy ').format(selectedDate)}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              postSchedule(start: selectedDate);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Lưu'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
          dataSource: ScheduleDataSource(scheduleData),
        ),
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
              subject: 'Đã tạo', // Customize as needed
            ))
        .toList();
  }
}
