import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/profile_screens/edit_post_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllPostsScreen extends StatefulWidget {
  final String mentorId;
  final String mentorToken;
  const AllPostsScreen(
      {super.key, required this.mentorId, required this.mentorToken});

  @override
  State<AllPostsScreen> createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  List<Map<String, dynamic>> blogData = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/blog/by-user/${widget.mentorId}');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer ${widget.mentorToken}'
    });

    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // final List<dynamic> blogs = responseData['blogs'];
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        // blogData = blogs.cast<Map<String, dynamic>>();
        blogData = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Đã xảy ra lỗi.');
      throw Exception('Failed to load data');
    }
  }

  Future<void> _deleteBlogPost(String postId) async {
    final deleteUri = Uri.https(
      Constants.uri,
      '/blog/$postId',
    );

    final response = await http.delete(
      deleteUri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${widget.mentorToken}',
      },
      body: jsonEncode({
        "title": '',
        "content": '',
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        blogData.removeWhere((blog) => blog['_id'] == postId);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text('Đã xoá bài viết'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to delete blog post');
    }
  }

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
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
          'Tất cả bài viết',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : blogData.isEmpty
              ? const Center(
                  child: Text('Không có bài viết'),
                )
              : ListView.builder(
                  itemCount: blogData.length,
                  itemBuilder: (context, index) {
                    final blog = blogData[index];

                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.blue,
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          _deleteBlogPost(blog['_id']);
                        } else if (direction == DismissDirection.startToEnd) {}
                        setState(() {
                          blogData.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPostScreen(
                                    postId: blog['_id'],
                                    title: blog['title'],
                                    content: blog['content'],
                                    authorToken: user.accessToken),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(blog['title']),
                              subtitle: Text(
                                stripHtmlTags(blog['content']).length <= 300
                                    ? stripHtmlTags(blog['content'])
                                    : '${stripHtmlTags(blog['content']).substring(0, 300)}...',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
