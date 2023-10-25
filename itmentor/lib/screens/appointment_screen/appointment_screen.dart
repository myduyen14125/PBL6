import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/appointment_screen/appointment_detail_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  final User user;
  const AppointmentScreen({super.key, required this.user});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<dynamic> appointments = [];

  Future<void> fetchData(User user) async {
    final apiUrl = Uri.https(Constants.uri, '/appointment');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}'
    };
    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        appointments = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.user);
  }

  Future<void> deleteAppointment(String appointmentId) async {
    final apiUrl =
        Uri.https(Constants.uri, '/appointment/$appointmentId/cancel');
    final headers = {
      'Content-Length': '0',
      'Connection': 'keep-alive',
      'Authorization': 'Bearer ${widget.user.accessToken}',
    };

    final response = await http.patch(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Blog deleted successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: Text('Delete fail'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: appointments.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  final mentorName = appointment['mentor']['name'];
                  final startAt =
                      DateTime.parse(appointment['schedule']['start_at']);
                  final endAt =
                      DateTime.parse(appointment['schedule']['end_at']);
                  final status = appointment['status'];
                  final appointmentId = appointment['_id'];

                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        // Handle delete API call here
                        deleteAppointment(appointmentId);
                        // Remove the appointment from the list
                        setState(() {
                          appointments.removeAt(index);
                        });
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return AppointmentDetailScreen(
                                accessToken: user.accessToken,
                                scheduleId: appointmentId,
                              );
                            }),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          tileColor: Colors.white,
                          title: Text(
                            'Mentor: $mentorName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date: ${DateFormat('dd/MM/yyyy').format(startAt)}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'End Date: ${DateFormat('dd/MM/yyyy').format(endAt)}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Status: $status',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: status == 'pending'
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
