import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';

class EditPostScreen extends StatefulWidget {
  final String postId;
  final String title;
  final String content;
  final String authorToken;
  const EditPostScreen(
      {super.key,
      required this.postId,
      required this.title,
      required this.content,
      required this.authorToken});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _contentTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editTitleController.text = widget.title;
    _contentTitleController.text = widget.content;
  }

  Future<void> updateBlogPost(
      String postId, String authorToken, String title, String content) async {
    try {
      final uri = Uri.https(Constants.uri, '/blog/${widget.postId}');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.authorToken}',
        },
        body: jsonEncode({
          "title": title,
          "content": content,
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Blog post updated successfully'),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to update the blog post'),
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
      }
    } catch (e) {
      // Handle exceptions
      print('Error updating blog post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _editTitleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _contentTitleController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                updateBlogPost(
                  widget.postId,
                  widget.authorToken,
                  _editTitleController.text,
                  _contentTitleController.text,
                );
                print("title: ${_editTitleController.text}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1369B2),
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
