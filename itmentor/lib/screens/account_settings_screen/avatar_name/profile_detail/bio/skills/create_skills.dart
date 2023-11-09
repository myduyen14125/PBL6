import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';

class CreateSkills extends StatefulWidget {
  final String token;
  final String bioId;
  final Function(Map<String, String>) onSkillCreated;
  CreateSkills(
      {super.key,
      required this.token,
      required this.bioId,
      required this.onSkillCreated});

  @override
  State<CreateSkills> createState() => _CreateAwardsScreenState();
}

class _CreateAwardsScreenState extends State<CreateSkills> {
  final TextEditingController bioController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bioController.text = widget.bioId;
  }

  void postSkillData() async {
    final url = Uri.https(Constants.uri, '/skill');

    final data = {
      "bio": bioController.text,
      "name": nameController.text,
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
      print('Skill data posted successfully.');
      showSnackBar(context, 'Thêm kĩ năng thành công');
      widget.onSkillCreated({
        "bio": bioController.text,
        "name": nameController.text,
        "description": descriptionController.text,
      });
      Navigator.of(context).pop();
    } else {
      print('Failed to post Skill data: ${response.statusCode}');
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
          'Thêm kĩ năng',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên kĩ năng'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                postSkillData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Thêm giải thưởng'),
            ),
          ],
        ),
      ),
    );
  }
}
