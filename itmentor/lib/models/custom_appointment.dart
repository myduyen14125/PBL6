import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomAppointment extends Appointment {
  final String id;

  CustomAppointment({
    required this.id,
    required DateTime startTime,
    required DateTime endTime,
    required Color color
  }) : super(startTime: startTime, endTime: endTime, color: Colors.green);
}
