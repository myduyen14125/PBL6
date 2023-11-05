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
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/schedule');
    print('schedules token : ${widget.token}');
    final headers = {'Authorization': "Bearer ${widget.token}"};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        scheduleData = data.cast<Map<String, dynamic>>();
        isLoading = false;
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> postScheduleLongPress({
      required DateTime start,
    }) async {
      final apiUrl = Uri.https(Constants.uri, '/schedule');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      };

      final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');

      final String startAt = dateFormat.format(start);

      DateTime end = start.add(const Duration(hours: 1));

      final String endAt = dateFormat.format(end);

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
          showSnackBar(context, 'Lịch đã bị trùng. Vui lòng thử lại');
        }
      } catch (e) {
        print("Error during POST request: $e");
        showSnackBar(context, 'Lịch đã bị trùng. Vui lòng thử lại');
      }
    }

    Future<void> postSchedule({
      required DateTime start,
    }) async {
      final apiUrl = Uri.https(Constants.uri, '/schedule');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      };

      final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');

      final String startAt = dateFormat.format(start);

      // Calculate the end time as exactly 30 minutes after the start time
      DateTime endAt = start.add(const Duration(minutes: 30));

      final Map<String, dynamic> requestBody = {
        "start_at": startAt,
        "end_at": dateFormat.format(endAt),
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
          showSnackBar(context, 'Lịch đã bị trùng. Vui lòng thử lại');
        }
      } catch (e) {
        print("Error during POST request: $e");
        showSnackBar(context, 'Lịch đã bị trùng. Vui lòng thử lại');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo lịch rảnh'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SfCalendar(
                view: CalendarView.week,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeInterval: Duration(minutes: 30),
                  timeFormat: 'hh:mm a',
                ),
                onLongPress: (CalendarLongPressDetails details) {
                  if (details.targetElement == CalendarElement.calendarCell) {
                    DateTime startDate = details.date!;
                    DateTime endDate = startDate.add(const Duration(hours: 1));
                    print("Long press start date: $startDate");
                    print("Long press end date: $endDate");

                    // Now you can use startDate and endDate for your logic.
                    String startText = '';
                    String endText = '';
                    if (startDate.minute == 30) {
                      startText =
                          '${startDate.hour}:${startDate.minute} - ${startDate.hour + 1}:${startDate.minute}';
                      endText =
                          '${startDate.hour}:${startDate.minute} - ${startDate.hour + 1}:${startDate.minute}';
                    } else {
                      startText =
                          '${startDate.hour}:${startDate.minute}0 - ${startDate.hour + 1}:${startDate.minute}0';
                      endText =
                          '${startDate.hour}:${startDate.minute} - ${startDate.hour + 1}:${startDate.minute}';
                    }

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
                                    '$startText, ngày ${DateFormat('dd-MM-yyyy ').format(startDate)}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    postScheduleLongPress(start: startDate);
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
                onTap: (CalendarTapDetails details) {
                  if (details.targetElement == CalendarElement.calendarCell) {
                    DateTime selectedDate = details.date!;

                    String startText = '';
                    String endText = '';
                    if (selectedDate.minute == 30) {
                      startText =
                          '${selectedDate.hour}:${selectedDate.minute} - ${selectedDate.hour + 1}:00';
                      endText =
                          '${selectedDate.hour + 1}:00 - ${selectedDate.hour + 1}:30';
                    } else {
                      startText =
                          '${selectedDate.hour}:${selectedDate.minute}0 - ${selectedDate.hour}:${selectedDate.minute + 30}';
                      endText =
                          '${selectedDate.hour}:${selectedDate.minute + 30} - ${selectedDate.hour + 1}:${selectedDate.minute}';
                    }

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
                                    '$startText, ngày ${DateFormat('dd-MM-yyyy ').format(selectedDate)}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
            ))
        .toList();
  }
}
