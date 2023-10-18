import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> createBlogPost(
      BuildContext ctx, User user, String title, String content) async {
    final uri = Uri.https(Constants.uri, '/blog');

    final Map<String, dynamic> data = {"title": title, "content": content};
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer ${user.accessToken}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('Bài viết đã được tạo thành công.');
      showSnackBar(ctx, 'Bài viết đã được tạo thành công');
    } else {
      print(
          'Có lỗi xảy ra khi tạo bài viết. Mã trạng thái: ${response.statusCode}');
      print('Nội dung lỗi: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tiêu đề bài viết'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Nội dung'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý thông tin sau khi người dùng nhấn nút
                String title = _titleController.text;
                String content = _contentController.text;
                // Thực hiện xử lý thông tin ở đây
                print('Tên: $title');
                print('Email: $content');

                createBlogPost(context, user, title, content);
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
