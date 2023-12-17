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

  bool validateInputs() {
    if (positionController.text.isEmpty ||
        companyController.text.isEmpty ||
        startDate.isEmpty ||
        endDate.isEmpty ||
        descriptionController.text.isEmpty) {
      showSnackBar(context, 'Vui lòng điền đầy đủ thông tin');
      return false;
    }
    return true;
  }

  String? validateNonEmpty(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Vui lòng điền $fieldName';
    }

    final validTextRegex = RegExp(r'^[a-zA-Z0-9.,!? ]*$');
    if (!validTextRegex.hasMatch(value)) {
      return 'Vui lòng nhập $fieldName hợp lệ';
    }

    return null;
  }

  String? validateDate(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Vui lòng chọn $fieldName';
    }
    return null;
  }

  bool validateDateOrder() {
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      final startDateTime = DateTime.parse(startDate);
      final endDateTime = DateTime.parse(endDate);
      if (startDateTime.isAfter(endDateTime)) {
        showSnackBar(context, 'Ngày bắt đầu phải trước ngày kết thúc');
        return false;
      }
    }
    return true;
  }

  void postExperienceData() async {
    if (!validateInputs()) {
      return;
    }
    if (!validateDateOrder()) {
      return;
    }
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
    final _formKey = GlobalKey<FormState>();
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: Key('Position'),
                  controller: positionController,
                  decoration: const InputDecoration(labelText: 'Vị trí'),
                  validator: (value) => validateNonEmpty(value!, 'vị trí'),
                ),
                TextFormField(
                  key: Key('Company'),
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Công ty'),
                  validator: (value) => validateNonEmpty(value!, 'công ty'),
                ),
                TextFormField(
                  key: Key('Description'),
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                  validator: (value) => validateNonEmpty(value!, 'mô tả'),
                ),
                GestureDetector(
                  onTap: showStartDatePicker,
                  child: AbsorbPointer(
                    key: Key('StartDatePicker'),
                    child: TextFormField(
                      controller: TextEditingController(text: startDate),
                      decoration:
                          const InputDecoration(labelText: 'Ngày bắt đầu'),
                      validator: (value) =>
                          validateDate(value!, 'ngày bắt đầu'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: showEndDatePicker,
                  child: AbsorbPointer(
                    key: Key('EndDatePicker'),
                    child: TextFormField(
                      controller: TextEditingController(text: endDate),
                      decoration:
                          const InputDecoration(labelText: 'Ngày kết thúc'),
                      validator: (value) =>
                          validateDate(value!, 'ngày kết thúc'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  key: Key('ButtonAddExperience'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      postExperienceData();
                    }
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
        ),
      ),
    );
  }
}
