import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';

class EditAwardsDetail extends StatefulWidget {
  final dynamic awards;
  final String token;
  final Function(Map<String, dynamic>) onUpdateAward;
  const EditAwardsDetail(
      {super.key,
      required this.awards,
      required this.token,
      required this.onUpdateAward});

  @override
  State<EditAwardsDetail> createState() => _EditAwardsDetailState();
}

class _EditAwardsDetailState extends State<EditAwardsDetail> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String startDate = '';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.awards['name'];
    descriptionController.text = widget.awards['description'];
    startDate = formatDateString(widget.awards['date']);
  }

  String formatDateString(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  void updateAward() async {
    final url = Uri.https(Constants.uri, '/award/${widget.awards['_id']}');

    final data = {
      "name": nameController.text,
      "date": startDate,
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
      print('awards data updated successfully.');
      widget.onUpdateAward({
        '_id': widget.awards['_id'],
        "name": nameController.text,
        "date": startDate,
        "description": descriptionController.text,
      });
      showSnackBar(context, 'Cập nhật giải thưởng thành công');
      widget.onUpdateAward({});
      Navigator.of(context).pop();
    } else {
      print('Failed to update awards data: ${response.statusCode}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cập nhật giải thưởng',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên giải thưởng'),
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
                  decoration:
                      const InputDecoration(labelText: 'Ngày nhận thưởng'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                updateAward();
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
      ),
    );
  }
}
