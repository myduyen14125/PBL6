import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;
  BlogDetailScreen({super.key, required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  String title = '';
  String content = '';
  bool isLoading = true; // Biến kiểm soát hiển thị "Loading" widget

  Future<void> getBlogDetail(String blogId) async {
    final apiUrl = Uri.https(Constants.uri, '/blog/$blogId');

    try {
      final response = await http.get(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Thêm các header khác nếu cần thiết
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final blogTitle = responseData['title'];
        final blogContent = responseData['content'];

        setState(() {
          title = blogTitle;
          content = blogContent;
          isLoading = false; // Tắt hiển thị "Loading" khi load xong
        });
      } else {
        print(
            'Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ${response.statusCode}');
        print('Nội dung lỗi: ${response.body}');
      }
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getBlogDetail(widget.blogId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Chi tiết blog',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text('$title'),
                    Text('$content'),
                  ],
                ),
              ),
            ),
            // "Loading" widget ở giữa màn hình
            Visibility(
              visible: isLoading,
              child: Center(
                child:
                    CircularProgressIndicator(), // Hoặc bất kỳ widget "Loading" khác
              ),
            ),
          ],
        ),
      ),
    );
  }
}

