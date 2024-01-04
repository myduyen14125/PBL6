import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CreateBlog extends StatefulWidget {
  final String token;
  const CreateBlog({super.key, required this.token});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> createBlog() async {
    final url = Uri.https(Constants.uri, '/blog');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}'
    };
    final body = jsonEncode({
      'title': _titleController.text,
      'content': _contentController.text,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text('Đã tạo blog'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        _titleController.text = '';
        _contentController.text = '';
      });
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Không thể tạo bài viết'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tạo bài viết',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Khuyến cáo: Nên tạo bài viết ở phiên bản web để thao tác đầy đủ hơn!', style: TextStyle(fontSize: 16),),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tên bài viết'),
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Nội dung'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                createBlog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 63, 143, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Tạo bài viết'),
            ),
          ],
        ),
      ),
    );
  }
}
