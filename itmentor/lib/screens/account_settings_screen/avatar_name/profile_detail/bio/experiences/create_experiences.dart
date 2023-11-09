import 'package:flutter/material.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itmentor/utils/utils.dart';
import 'package:intl/intl.dart';

class CreateExperiences extends StatefulWidget {
  final String token;
  final String bioId;
  final Function(Map<String, String>) onExperienceCreated;
  CreateExperiences(
      {super.key,
      required this.token,
      required this.bioId,
      required this.onExperienceCreated});

  @override
  State<CreateExperiences> createState() => _CreateExperiencesState();
}

class _CreateExperiencesState extends State<CreateExperiences> {
  final TextEditingController bioController = TextEditingController();

  final TextEditingController positionController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  String startDate = '';
  String endDate = '';

  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

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

  void postExperienceData() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.https(Constants.uri, '/experience');

    final data = {
      "bio": bioController.text,
      "position": positionController.text,
      "company": companyController.text,
      "start_date": startDate,
      "end_date": endDate,
      "description": descriptionController.text,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('Experiences data posted successfully.');
      showSnackBar(context, 'Thêm kinh nghiệm làm việc thành công');
      widget.onExperienceCreated(data);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      print('Failed to post experiences data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    bioController.text = widget.bioId;
  }

  @override
  Widget build(BuildContext context) {
    print('experience token: ${widget.token}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thêm kinh nghiệm làm việc',
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
            ElevatedButton(
              onPressed: () {
                postExperienceData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Thêm kinh nghiệm'),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
