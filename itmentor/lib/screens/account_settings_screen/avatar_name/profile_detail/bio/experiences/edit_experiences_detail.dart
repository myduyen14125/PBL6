import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class EditExperiencesDetail extends StatefulWidget {
  final dynamic experience;
  final String token;
  final Function(Map<String, dynamic>) onUpdateExperience;

  EditExperiencesDetail({
    Key? key,
    required this.experience,
    required this.token,
    required this.onUpdateExperience,
  }) : super(key: key);

  @override
  State<EditExperiencesDetail> createState() => _EditExperiencesDetailState();
}

class _EditExperiencesDetailState extends State<EditExperiencesDetail> {
  final TextEditingController positionController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  String startDate = '';
  String endDate = '';
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    positionController.text = widget.experience['position'];
    companyController.text = widget.experience['company'];
    descriptionController.text = widget.experience['description'];
    // startDate = formatDate(widget.experience['start_date']);
    // endDate = formatDate(widget.experience['end_date']);
    startDate = formatDateString(widget.experience['start_date']);
    endDate = formatDateString(widget.experience['end_date']);
  }

  String formatDateString(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  void updateExperience() async {
    final url =
        Uri.https(Constants.uri, '/experience/${widget.experience['_id']}');

    final data = {
      "position": positionController.text,
      "company": companyController.text,
      "start_date": startDate,
      "end_date": endDate,
      "description": descriptionController.text,
    };

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Experiences data updated successfully.');
      widget.onUpdateExperience({
        '_id': widget.experience['_id'],
        'position': positionController.text,
        'company': companyController.text,
        'start_date': startDate,
        'end_date': endDate,
        'description': descriptionController.text,
      });

      showSnackBar(context, 'Cập nhật kinh nghiệm thành công');

      Navigator.of(context).pop();
    } else {
      // Handle the error
      print('Failed to update experiences data: ${response.statusCode}');
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void showStartDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        startDate = formatDate(pickedDate);
      });
    }
  }

  void showEndDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        endDate = formatDate(pickedDate); // Format the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cập nhật kinh nghiệm',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: positionController,
              decoration: const InputDecoration(labelText: 'Vị trí'),
            ),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Công ty'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
            GestureDetector(
              onTap: showStartDatePicker, // Show the startDate picker
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(text: startDate),
                  decoration: const InputDecoration(labelText: 'Ngày bắt đầu'),
                ),
              ),
            ),
            GestureDetector(
              onTap: showEndDatePicker, // Show the endDate picker
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(text: endDate),
                  decoration: const InputDecoration(labelText: 'Ngày kết thúc'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     updateExperience();
                //   },
                //   child: const Text('Cập nhật'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    updateExperience();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Cập nhật'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
