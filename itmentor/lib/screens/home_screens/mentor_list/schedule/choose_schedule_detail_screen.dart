import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_screen_completion_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChooseScheduleDetailScreen extends StatefulWidget {
  final String mentorId;
  final String scheduleId;
  final String mentorName;
  final String mentorAvatar;
  final String selectedDate;
  final int duration;
  final String aToken;
  final String mentorExpertise;
  const ChooseScheduleDetailScreen(
      {super.key,
      required this.mentorId,
      required this.scheduleId,
      required this.mentorName,
      required this.mentorAvatar,
      required this.selectedDate,
      required this.duration,
      required this.aToken,
      required this.mentorExpertise});

  @override
  State<ChooseScheduleDetailScreen> createState() =>
      _ChooseScheduleDetailScreenState();
}

class _ChooseScheduleDetailScreenState
    extends State<ChooseScheduleDetailScreen> {
  String senderDet = 'Sender Details ';
  bool formOpenFlag = false;

  List<String> connectChoices = ['Google Meet', 'Skype'];
  String selectedConnectChoice = 'Chọn hình thức kết nối';

  List<String> subjectChoices = [
    'Định hướng nghề nghiệp',
    'Nghiên cứu khoa học',
    'Kỹ năng mềm',
    'Bất kì',
  ];
  String selectedSubjectChoice = 'Chọn chủ đề';

  TextEditingController _messageController = TextEditingController();

  bool isSendingAppointment = false;

  @override
  Widget build(BuildContext context) {
    Future<void> sendAppointmentRequest(
        {required String mentorId,
        required String scheduleId,
        required String note}) async {
      setState(() {
        isSendingAppointment = true;
      });
      final uri = Uri.https(Constants.uri, '/appointment');

      final Map<String, dynamic> data = {
        "mentor": mentorId,
        "schedule": scheduleId,
        "note": _messageController.text
      };
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${widget.aToken}'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        showSnackBar(context, 'Đã đặt lịch thành công');
        setState(() {
          isSendingAppointment = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return ChooseScreenCompletionScreen(
                mentorAvatar: widget.mentorAvatar,
                mentorName: widget.mentorName,
                duration: widget.duration,
                selectedDate: widget.selectedDate,
                connectionChoice: selectedConnectChoice,
                subject: selectedSubjectChoice,
              );
            }),
          ),
        );
      } else {
        print('Nội dung lỗi: ${response.body}');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Text(
                      'Hoàn tất lịch hẹn',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Nhận cố vấn từ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          CachedNetworkImageProvider(widget.mentorAvatar),
                      child: const InkWell(
                        customBorder: CircleBorder(),
                      ),
                    ),
                    title: Text(
                      widget.mentorName,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      'Lĩnh vực: ${widget.mentorExpertise}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.selectedDate,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.timelapse),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.duration} phút',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Hình thức kết nối',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
                child: ExpansionTile(
                    key: GlobalKey(),
                    initiallyExpanded: formOpenFlag,
                    onExpansionChanged: (val) {
                      formOpenFlag = val;
                    },
                    title: Text(selectedConnectChoice),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.025),
                    children: connectChoices.map((choice) {
                      return ListTile(
                        title: Text(choice),
                        onTap: () {
                          setState(() {
                            selectedConnectChoice = choice;
                            formOpenFlag = !formOpenFlag;
                          });
                        },
                      );
                    }).toList()),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Chủ đề',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
                child: ExpansionTile(
                    key: GlobalKey(),
                    initiallyExpanded: formOpenFlag,
                    onExpansionChanged: (val) {
                      formOpenFlag = val;
                    },
                    title: Text(selectedSubjectChoice),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.025),
                    children: subjectChoices.map((choice) {
                      return ListTile(
                        title: Text(choice),
                        onTap: () {
                          setState(() {
                            selectedSubjectChoice = choice;
                            formOpenFlag = !formOpenFlag;
                          });
                        },
                      );
                    }).toList()),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Gửi tin nhắn',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Nhập lời nhắn đến mentor...',
                      border: InputBorder.none,
                      icon: const Icon(Icons.message, color: Colors.blue),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _messageController.clear();
                        },
                        icon: const Icon(Icons.clear, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 130,
                  child: ElevatedButton(
                    onPressed:
                        (selectedConnectChoice != 'Chọn hình thức kết nối' &&
                                selectedSubjectChoice != 'Chọn chủ đề')
                            ? () {
                                sendAppointmentRequest(
                                    mentorId: widget.mentorId,
                                    scheduleId: widget.scheduleId,
                                    note: "");
                              }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1369B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_month,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text('Đặt lịch'),
                      ],
                    ),
                  ),
                ),
              ),
              isSendingAppointment
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
