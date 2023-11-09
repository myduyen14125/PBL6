import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/educations/edit_education_detail.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class EditEducations extends StatefulWidget {
  final List<dynamic> educations;
  final String token;
  final Function(String) onEducationDeleted;
  const EditEducations(
      {super.key,
      required this.educations,
      required this.token,
      required this.onEducationDeleted});

  @override
  State<EditEducations> createState() => _EditEducationsState();
}

class _EditEducationsState extends State<EditEducations> {
  void deleteEducation(String educationId) async {
    final url = Uri.https(Constants.uri, '/education/$educationId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      print('Education data deleted successfully.');
      widget.onEducationDeleted(educationId);
      showSnackBar(context, 'Đã xoá kinh nghiệm làm việc');
      Navigator.of(context).pop();
    } else {
      print('Failed to delete education data: ${response.statusCode}');
    }
  }

  Future<void> _confirmDeleleEducation(String educationId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá'),
          content: const Text('Bạn có muốn xoá học vấn này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteEducation(educationId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cập nhật học vấn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.educations.length,
              itemBuilder: (context, index) {
                final education = widget.educations[index];
                final startDate = DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(education['start_date']));
                final endDate = DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(education['end_date']));
                print('education: $education');
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 59, 255, 137),
                      child: Icon(
                        Icons.school,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      education['place'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          education['major'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$startDate đến $endDate',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // deleteExperience(experience['_id']);
                            _confirmDeleleEducation(education['_id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
