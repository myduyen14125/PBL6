import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/models/custom_appointment.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_detail_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
        print('apiData: $apiData');
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: SfCalendar(
  //         view: CalendarView.week,
  //         dataSource: ScheduleDataSource(apiData),
  //         timeSlotViewSettings: const TimeSlotViewSettings(
  //           timeInterval: Duration(minutes: 30),
  //           timeFormat: 'hh:mm a',
  //         ),
  //         onTap: (CalendarTapDetails details) {
  //           if (details.targetElement == CalendarElement.calendarCell) {
  //             DateTime selectedDate = details.date!;
  //             print('ko ranh: $selectedDate');
  //           } else {
  //             DateTime selectedDate = details.date!;
  //             print('rảnh: $selectedDate');
  //             print(
  //                 "Selected date: ${selectedDate.year}:${selectedDate.month}:${selectedDate.day}T${selectedDate.hour}:${selectedDate.minute}0:00");
  //             print(
  //                 "End date: ${selectedDate.year}:${selectedDate.month}:${selectedDate.day}T${selectedDate.hour + 1}:${selectedDate.minute}0:00");
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print(user.accessToken);
    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: ScheduleDataSource(apiData),
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeInterval: Duration(minutes: 30),
            timeFormat: 'hh:mm a',
          ),
          onTap: (CalendarTapDetails details) {
            if (details.targetElement == CalendarElement.appointment) {
              CustomAppointment selectedAppointment =
                  details.appointments![0] as CustomAppointment;
              String appointmentId = selectedAppointment.id;

              print('Selected appointment ID: $appointmentId');

              DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
              String formattedStartTime =
                  formatter.format(selectedAppointment.startTime);
              String formattedEndTime =
                  formatter.format(selectedAppointment.endTime);

              print('Selected appointment startTime: $formattedStartTime');
              print('Selected appointment endTime: $formattedEndTime');

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
                              formattedStartTime,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChooseScheduleDetailScreen(
                                      scheduleId: appointmentId,
                                      mentorId: widget.mentorId,
                                      mentorName: widget.mentorName,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('Lưu'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Map<String, dynamic>> source) {
    appointments = source
        .map((data) => CustomAppointment(
              id: data['_id'], // Add the id field from the API data
              startTime: DateTime.parse(data['start_at']),
              endTime: DateTime.parse(data['end_at']),
            ))
        .toList();
  }
}
