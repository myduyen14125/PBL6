import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:http/http.dart' as http;

class CreateSchedules extends StatefulWidget {
  final String token;
  const CreateSchedules({super.key, required this.token});

  @override
  State<CreateSchedules> createState() => _CreateSchedulesState();
}

class _CreateSchedulesState extends State<CreateSchedules> {
  DateTime? selectedStartDateAt;
  TimeOfDay? selectedTimeStartAt;
  String startAt = '';

  TimeOfDay? selectedTimeEndAt;
  String endAt = '';

  DateTime? extractedDate;

  String formattedDate = '';
  DateTime? parsedDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedStartDateAt ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != selectedStartDateAt) {
      setState(() {
        selectedStartDateAt = picked;
        extractedDate = DateTime(picked.year, picked.month, picked.day);

        formattedDate =
            DateFormat('yyyy-MM-dd\'T\'HH:mm:ss').format(selectedStartDateAt!);
        parsedDate = DateTime.parse(formattedDate);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedTimeStartAt ?? TimeOfDay.now(),
    ))!;
    if (picked != null && picked != selectedTimeStartAt) {
      setState(() {
        selectedTimeStartAt = picked;

        startAt =
            '${extractedDate!.year}-${extractedDate!.month}-${extractedDate!.day}T${selectedTimeStartAt!.hour}:${selectedTimeStartAt!.hour}:00';
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedTimeEndAt ?? TimeOfDay.now(),
    ))!;
    if (picked != null && picked != selectedTimeEndAt) {
      setState(() {
        selectedTimeEndAt = picked;
        endAt =
            '${extractedDate!.year}-${extractedDate!.month}-${extractedDate!.day}T${selectedTimeEndAt!.hour}:${selectedTimeEndAt!.hour}:00';
      });
    }
  }

  Future<void> createSchedule(
      {required String timeStart, required String timeEnd}) async {
    final uri = Uri.https(Constants.uri, '/schedule');
    final body = jsonEncode({
      'start_at':
          "${extractedDate!.year}-${extractedDate!.month}-${extractedDate!.day}T${selectedTimeStartAt!.hour}:${selectedTimeStartAt!.hour}:00",
      'end_at':
          "${extractedDate!.year}-${extractedDate!.month}-${extractedDate!.day}T${selectedTimeEndAt!.hour}:${selectedTimeEndAt!.hour}:00",
    });
    final headers = {'Authorization': "Bearer ${widget.token}"};

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      print('create schedule successfully');
    } else {
      print('create schedule failed');
    }
  }

  Future<void> postSchedule(
      {required String timeStart,
      required String timeEnd,
      required BuildContext context}) async {
    final apiUrl = Uri.https(Constants.uri, '/schedule');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}'
    };

    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final String startAt = dateFormat.format(DateTime(
      extractedDate!.year,
      extractedDate!.month,
      extractedDate!.day,
      selectedTimeStartAt!.hour,
      selectedTimeStartAt!.minute,
      00,
    ));

    final String endAt = dateFormat.format(DateTime(
        extractedDate!.year,
        extractedDate!.month,
        extractedDate!.day,
        selectedTimeEndAt!.hour,
        selectedTimeEndAt!.minute,
        00));

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
      } else {
        print("POST request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during POST request: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        icon: const Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Tạo lịch rảnh',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => _selectStartDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Chọn ngày bắt đầu',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                Text(
                  selectedStartDateAt != null
                      ? "Ngày bắt đầu: ${DateFormat('yyyy-MM-dd').format(selectedStartDateAt!)}"
                      : 'Chưa chọn ngày',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Chọn giờ bắt đầu',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                Text(
                  selectedTimeStartAt != null
                      ? "Giờ bắt đầu: ${selectedTimeStartAt?.format(context)}"
                      : 'Chưa chọn giờ',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Chọn giờ kết thúc',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                Text(
                  selectedTimeEndAt != null
                      ? "Giờ kết thúc: ${selectedTimeEndAt?.format(context)}"
                      : 'Chưa chọn giờ',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      postSchedule(
                          timeStart: startAt, timeEnd: endAt, context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009688),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Tạo lịch',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
