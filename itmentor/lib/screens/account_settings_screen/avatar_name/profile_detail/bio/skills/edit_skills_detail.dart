import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';

class EditSkillDetail extends StatefulWidget {
  final dynamic skills;
  final String token;
  final Function(Map<String, dynamic>) onSkillUpdate;
  const EditSkillDetail(
      {super.key,
      required this.skills,
      required this.token,
      required this.onSkillUpdate});

  @override
  State<EditSkillDetail> createState() => _EditSkillDetailState();
}

class _EditSkillDetailState extends State<EditSkillDetail> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().toString();

  @override
  void initState() {
    super.initState();
    print(widget.skills);
    nameController.text = widget.skills['name'];
    descriptionController.text = widget.skills['description'];
  }

  void updateSkill() async {
    final url = Uri.https(Constants.uri, '/skill/${widget.skills['_id']}');

    final data = {
      "name": nameController.text,
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
      widget.onSkillUpdate({
        '_id': widget.skills['_id'],
        "name": nameController.text,
        "description": descriptionController.text,
      });
      showSnackBar(context, 'Cập nhật giải thưởng thành công');
      Navigator.of(context).pop();
    } else {
      print('Failed to update awards data: ${response.statusCode}');
    }
  }

  void deleteAward() async {
    final url = Uri.https(Constants.uri, '/skill/${widget.skills['_id']}');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      print('skill data deleted successfully.');
    } else {
      print('Failed to delete skill data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('this skill: ${widget.skills['_id']}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cập nhật kĩ năng',
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
                updateSkill();
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
