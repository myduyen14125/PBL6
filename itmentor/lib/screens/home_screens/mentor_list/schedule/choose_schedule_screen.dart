import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/models/custom_appointment.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_detail_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ChooseSchedule extends StatefulWidget {
  final String mentorId;
  final String mentorName;
  final String mentorAvatar;
  final String mentorExpertise;

  ChooseSchedule(
      {Key? key,
      required this.mentorId,
      required this.mentorName,
      required this.mentorAvatar,
      required this.mentorExpertise})
      : super(key: key);

  @override
  State<ChooseSchedule> createState() => _ChooseScheduleState();
}

class _ChooseScheduleState extends State<ChooseSchedule> {
  List<Map<String, dynamic>> apiData = [];
  String selectedTime = '';
  String aToken = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    getAccessToken();
    print(widget.mentorId);
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aToken = prefs.getString('x-auth-token') ?? '';
    });
  }

  Future<void> fetchData() async {
    final uri = Uri.https(Constants.uri, '/schedule/by-user/${widget.mentorId}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        apiData = jsonData.cast<Map<String, dynamic>>();
        apiData = apiData
            .where((schedule) =>
                schedule['status'] == true &&
                DateTime.parse(schedule['end_at']).isAfter(DateTime.now()))
            .toList();
        print('apiData: $apiData');
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 157, 144),
        elevation: 0,
        title: const Text(
          'Chọn lịch',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: ScheduleDataSource(apiData),
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeInterval: Duration(minutes: 30),
            timeFormat: 'hh:mm a',
          ),
          minDate: DateTime.now(),
          onTap: (CalendarTapDetails details) {
            if (details.targetElement == CalendarElement.appointment) {
              CustomAppointment selectedAppointment =
                  details.appointments![0] as CustomAppointment;
              String appointmentId = selectedAppointment.id;

              print('Selected appointment ID: $appointmentId');

              // DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
              DateFormat formatter = DateFormat('HH:mm');
              DateFormat yearFormatter = DateFormat('dd-MM-yyyy');
              String formattedStartTime =
                  formatter.format(selectedAppointment.startTime);
              String formattedEndTime =
                  formatter.format(selectedAppointment.endTime);
              String formattedYearTime =
                  yearFormatter.format(selectedAppointment.endTime);

              int duration = selectedAppointment.endTime
                  .difference(selectedAppointment.startTime)
                  .inMinutes;
              print(duration);

              selectedTime =
                  '$formattedStartTime - $formattedEndTime, $formattedYearTime';

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
                              '$formattedStartTime - $formattedEndTime, $formattedYearTime',
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
                                      mentorAvatar: widget.mentorAvatar,
                                      selectedDate: selectedTime,
                                      duration: duration,
                                      aToken: aToken,
                                      mentorExpertise: widget.mentorExpertise,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('Chọn'),
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
            color: Colors.green))
        .toList();
  }
}
