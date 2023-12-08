import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class CreateAwards extends StatefulWidget {
  final String token;
  final String bioId;
  final Function(Map<String, String>) onAwardCreated;
  const CreateAwards(
      {super.key,
      required this.token,
      required this.bioId,
      required this.onAwardCreated});

  @override
  State<CreateAwards> createState() => _CreateAwardsState();
}

class _CreateAwardsState extends State<CreateAwards> {
  final TextEditingController bioController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String startDate = '';

  bool isLoading = false;

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void postAwardData() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.https(Constants.uri, '/award');

    final data = {
      "bio": bioController.text,
      "name": nameController.text,
      "date": startDate,
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
      showSnackBar(context, 'Thêm giải thưởng thành công');
      widget.onAwardCreated(data);
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pop();
    } else {
      print('Failed to post experiences data: ${response.statusCode}');
    }
  }

  void showStartDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        startDate = formatDate(pickedDate);
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
          'Thêm giải thưởng',
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
                  decoration: const InputDecoration(labelText: 'Ngày nhận giải'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     postAwardData();
            //   },
            //   child: const Text('Thêm giải thưởng'),
            // ),
            ElevatedButton(
              onPressed: () {
                postAwardData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Thêm giải thưởng'),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
