import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itmentor/utils/constant.dart';

class EditSkillDetail extends StatefulWidget {
  final dynamic skills;
  final String token;
  const EditSkillDetail({super.key, required this.skills, required this.token});

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
    nameController.text = widget.skills['name'];
    descriptionController.text = widget.skills['description'];
  }

  void updateAward() async {
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
        title: const Text('Cập nhật kĩ năng'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    deleteAward();
                  },
                  child: const Text('Xoá'),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateAward();
                  },
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
