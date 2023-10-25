import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/profile_screens/edit_post_screen.dart';
import 'package:itmentor/utils/constant.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.mentorId}/blogs');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer ${widget.mentorToken}'
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> blogs = responseData['blogs'];

      setState(() {
        blogData = blogs.cast<Map<String, dynamic>>();
        print(blogData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _deleteBlogPost(String postId) async {
    final deleteUri = Uri.https(
      Constants.uri,
      '/blog/$postId', // Replace with your actual delete API endpoint
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
      // Deletion was successful
      // You can also update the UI to remove the deleted item from the list
      setState(() {
        blogData.removeWhere((blog) => blog['_id'] == postId);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Blog deleted successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print(response.statusCode);
    } else {
      // Handle deletion failure
      // You can show an error message or take appropriate action
      print('Failed to delete blog post');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Blog List'),
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: blogData.length,
        itemBuilder: (context, index) {
          final blog = blogData[index];
          print("blog data: $blog");
          print("blogId: ${blog['_id']}");

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
                    subtitle: Text(blog['content']),
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
