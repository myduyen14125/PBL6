import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class CreateEducation extends StatefulWidget {
  final String token;
  final String bioId;
  final Function(Map<String, String>) onEducationCreated;
  const CreateEducation(
      {super.key,
      required this.token,
      required this.bioId,
      required this.onEducationCreated});

  @override
  State<CreateEducation> createState() => _CreateEducationState();
}

class _CreateEducationState extends State<CreateEducation> {
  final TextEditingController bioController = TextEditingController();

  final TextEditingController placeController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String startDate = '';
  String endDate = '';

  bool isCreating = false;

  void postEducationData() async {
    setState(() {
      isCreating = true;
    });
    final url = Uri.https(Constants.uri, '/education');

    final data = {
      "bio": bioController.text,
      "place": placeController.text,
      "major": majorController.text,
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
      showSnackBar(context, 'Thêm học vấn thành công');
      widget.onEducationCreated(data);
      setState(() {
        isCreating = false;
      });
      Navigator.of(context).pop();
    } else {
      print('Failed to post experiences data: ${response.statusCode}');
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
          'Thêm học vấn',
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
              decoration: const InputDecoration(labelText: 'Tên chuyển ngành'),
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
                postEducationData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Thêm học vấn'),
            ),
            const SizedBox(
              height: 10,
            ),
            isCreating == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
