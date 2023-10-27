import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';

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
        title: Text('Schedule Data'),
      ),
      body: ListView.builder(
        itemCount: scheduleData.length,
        itemBuilder: (context, index) {
          final item = scheduleData[index];
          return ListTile(
            title: Text('Start Time: ${item['start_at']}'),
            subtitle: Text('End Time: ${item['end_at']}'),
          );
        },
      ),
    );
  }
}
