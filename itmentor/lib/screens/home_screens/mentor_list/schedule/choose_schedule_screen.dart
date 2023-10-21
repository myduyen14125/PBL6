import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_detail_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChooseSchedule extends StatefulWidget {
  final String mentorId;
  final List<dynamic> schedules;

  ChooseSchedule({Key? key, required this.mentorId, required this.schedules})
      : super(key: key);

  @override
  State<ChooseSchedule> createState() => _ChooseScheduleState();
}

class _ChooseScheduleState extends State<ChooseSchedule> {
  @override
  Widget build(BuildContext context) {
    final filteredSchedules = widget.schedules
        .where((schedule) => schedule['status'] == true)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
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
              const Text('Chọn ngày',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filteredSchedules.map((schedule) {
                    final startAt = DateTime.parse(schedule['start_at']);
                    final endAt = DateTime.parse(schedule['end_at']);
                    final dateFormatted =
                        DateFormat('dd/MM/yyyy').format(startAt);
                    final dayOfWeek = DateFormat('EEEE').format(startAt);
                    final timeFormatted =
                        DateFormat('HH:mm:ss').format(startAt);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return ChooseScheduleDetailScreen(
                                scheduleId: schedule['_id'],
                                mentorId: widget.mentorId,
                              );
                            }),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(10),
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
      ),
    );
  }
}
