import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itmentor/utils/utils.dart';

class EditEducationDetail extends StatefulWidget {
  final dynamic educations;
  final String token;
  final Function(Map<String, dynamic>) onUpdateEducation;
  const EditEducationDetail(
      {super.key,
      required this.educations,
      required this.token,
      required this.onUpdateEducation});

  @override
  State<EditEducationDetail> createState() => _EditEducationDetailState();
}

class _EditEducationDetailState extends State<EditEducationDetail> {
  final TextEditingController placeController = TextEditingController();

  final TextEditingController majorController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String startDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    placeController.text = widget.educations['place'];
    majorController.text = widget.educations['major'];
    descriptionController.text = widget.educations['description'];
    startDate = formatDateString(widget.educations['start_date']);
    endDate = formatDateString(widget.educations['end_date']);
  }

  void updateEducation() async {
    final url =
        Uri.https(Constants.uri, '/education/${widget.educations['_id']}');

    final data = {
      "place": placeController.text,
      "major": majorController.text,
      "start_date": startDate,
      "end_date": endDate,
      "description": descriptionController.text,
    };

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('education data updated successfully.');
      widget.onUpdateEducation({
        '_id': widget.educations['_id'],
        'place': placeController.text,
        'major': majorController.text,
        'start_date': startDate,
        'end_date': endDate,
        'description': descriptionController.text,
      });
      showSnackBar(context, 'Cập nhật học vấn thành công');

      Navigator.of(context).pop();
    } else {
      print('Failed to update education data: ${response.statusCode}');
    }
  }

  void deleteEducation() async {
    final url =
        Uri.https(Constants.uri, '/education/${widget.educations['_id']}');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      print('Awards data deleted successfully.');
    } else {
      print('Failed to delete awards data: ${response.statusCode}');
    }
  }

  String formatDateString(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
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
    print('this award: ${widget.educations['_id']}');
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
            TextFormField(
              controller: placeController,
              decoration: const InputDecoration(labelText: 'Tên trường'),
            ),
            TextFormField(
              controller: majorController,
              decoration: const InputDecoration(labelText: 'Chuyên ngành'),
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
                //     updateEducation();
                //   },
                //   child: const Text('Cập nhật'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    updateEducation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 63, 143, 125),
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
