import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;
  BlogDetailScreen({super.key, required this.blogId});

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

        print("blog detail: $responseData");

        setState(() {
          title = blogTitle;
          content = blogContent;
          // blogImage = responseData['image'];
          var user = responseData['user'];
          authorName = user['name'];
          // authorAvatar = user['avatar'];
          createdAt = responseData['createdAt'];
          isLoading = false;
          // print("author avatar: ${user['avatar']}");
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                    createdAt,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Image.network(
                  //   blogImage,
                  //   width: double.infinity, // Set the width to fill the screen
                  //   height: 200, // Set the desired height
                  //   fit: BoxFit.cover, // Adjust the fit as needed
                  // ),
                  // CachedNetworkImage(
                  //   imageUrl: blogImage,
                  //   placeholder: (context, url) =>
                  //       new CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => new Icon(Icons.error),
                  // ),
                  // FadeInImage(
                  //   image: NetworkImage(blogImage),
                  //   placeholder: AssetImage("assets/images/female_avatar.png"),
                  //   imageErrorBuilder: (context, error, stackTrace) {
                  //     return Image.asset('assets/images/female_avatar.png',
                  //         fit: BoxFit.fitWidth);
                  //   },
                  //   fit: BoxFit.fitWidth,
                  // ),
                  const SizedBox(height: 16.0),
                  // Image.network(
                  //   authorAvatar,
                  //   width: 100, // Set the desired width
                  //   height: 100, // Set the desired height
                  //   fit: BoxFit.cover, // Adjust the fit as needed
                  // ),
                  // CachedNetworkImage(
                  //   imageUrl: authorAvatar,
                  //   placeholder: (context, url) =>
                  //       new CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => new Icon(Icons.error),
                  // ),
                  const SizedBox(height: 16.0),
                  Text(content),
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
