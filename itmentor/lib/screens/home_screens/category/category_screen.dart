import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/category/blogs/all_blogs_screen.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/utils/constant.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<dynamic> blogs = [];

  Future<void> fetchData() async {
    final apiUrl = Uri.https(Constants.uri, '/blog');
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        blogs = data['blogs'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10), // Adjust the padding as needed
        child: Column(
          children: [
            Expanded(
              child: blogs.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      itemCount: blogs.length > 3 ? 3 : blogs.length,
                      itemBuilder: (context, index) {
                        final blog = blogs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(
                                  blogId: blog['_id'],
                                  blogContent: blog['content'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: blog['user']['avatar'] == ''
                                    ? const AssetImage(
                                        'assets/images/blank_avatar.png')
                                    : CachedNetworkImageProvider(
                                            blog['user']['avatar'])
                                        as ImageProvider,
                              ),
                              title: Text(blog['title']),
                              subtitle: Text(
                                stripHtmlTags(blog['content']).length <= 300
                                    ? stripHtmlTags(blog['content'])
                                    : '${stripHtmlTags(blog['content']).substring(0, 300)}...',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllBlogsScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF195A94),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Row(
                  children: [
                    Text('Xem thêm bài viết'),
                    Icon(
                      Icons.arrow_circle_right,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}
