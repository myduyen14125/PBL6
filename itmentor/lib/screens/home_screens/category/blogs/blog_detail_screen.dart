import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;
  final String blogContent;
  BlogDetailScreen(
      {super.key, required this.blogId, required this.blogContent});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  String title = '';
  String content = '';
  bool isLoading = true;

  String blogImage = '';
  String authorName = '';
  String authorAvatar = '';
  String createdAt = '';

  String formattedDateTime = '';

  Future<void> getBlogDetail(String blogId) async {
    final apiUrl = Uri.https(Constants.uri, '/blog/$blogId');

    try {
      final response = await http.get(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final blogTitle = responseData['title'];
        final blogContent = responseData['content'];

        setState(() {
          title = blogTitle;
          content = blogContent;
          var user = responseData['user'];
          authorName = user['name'];
          createdAt = responseData['createdAt'];
          formattedDateTime = DateFormat('HH:mm:ss dd-MM-yyyy')
              .format(DateTime.parse(createdAt));
          isLoading = false;
        });
      } else {
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

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Chi tiết blog',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    authorName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Ngày viết: $formattedDateTime',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  HtmlWidget(
                    widget.blogContent,
                    textStyle:
                        const TextStyle(), // Customize the text style if needed
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
