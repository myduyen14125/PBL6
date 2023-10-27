import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
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
        print("${selectedTimeStartAt!.hour}:${selectedTimeStartAt!.minute}:00");

        startAt =
            '${extractedDate!.year}-${extractedDate!.month}-${extractedDate!.day}T${selectedTimeStartAt!.hour}:${selectedTimeStartAt!.hour}:00';
        print(startAt);
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
        print(endAt);
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

    print("token: ${widget.token}");

    final response = await http.post(uri, headers: headers, body: body);

    print(response.statusCode);
    if (response.statusCode == 201) {
      print('create schedule successfully');
    } else {
      print('create schedule failed');
    }
  }

  Future<void> postSchedule(
      {required String timeStart, required String timeEnd}) async {
    // final String apiUrl = "https://pbl6-test-production.up.railway.app/schedule";
    final apiUrl = Uri.https(Constants.uri, '/schedule');

    // Define the request headers and body.
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}'
    };

    final Map<String, dynamic> requestBody = {
      "start_at": startAt.toString(),
      "end_at": endAt.toString(),
    };

    // Encode the request body as JSON.
    String requestBodyJson = jsonEncode(requestBody);

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: headers,
        body: requestBodyJson,
      );

      if (response.statusCode == 201) {
        // Request was successful.
        print("POST request was successful!");
        print("Response: ${response.body}");
      } else {
        // Request failed.
        print("POST request failed with status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      // Exception occurred during the request.
      print("Error during POST request: $e");
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
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Tạo lịch hẹn',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _selectStartDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1369B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Chọn ngày bắt đầu'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  selectedStartDateAt != null
                      ? "${selectedStartDateAt?.toLocal()}".split(' ')[0]
                      : 'Chưa chọn ngày',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () => _selectStartTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1369B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Chọn giờ bắt đầu'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  selectedTimeStartAt != null
                      ? "${selectedTimeStartAt?.format(context)}"
                      : 'Chưa chọn ngày',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('Bắt đầu lúc: $selectedStartDateAt : $selectedTimeStartAt'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () => _selectEndTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1369B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Chọn giờ kết thúc'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  selectedTimeStartAt != null
                      ? "${selectedTimeEndAt?.format(context)}"
                      : 'Chưa chọn thời gian',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('Kết thúc lúc: $selectedStartDateAt : $selectedTimeEndAt'),
            ElevatedButton(
              onPressed: () {
                // createSchedule(timeStart: startAt, timeEnd: endAt);
                postSchedule(timeStart: startAt, timeEnd: endAt);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1369B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Tạo lịch'),
            ),
          ],
        ),
      ),
    );
  }
}
