import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';

class SearchMentor extends StatefulWidget {
  const SearchMentor({super.key});

  @override
  State<SearchMentor> createState() => _SearchMentorState();
}

class _SearchMentorState extends State<SearchMentor> {
  List<dynamic> mentors = [];

  bool isLoading = false;

  Future<void> fetchMentors(String name) async {
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/mentor/search', {'name': name});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        mentors = jsonData['mentors'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
                      'Tìm kiếm mentor',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Tìm theo tên'),
                onSubmitted: (value) {
                  fetchMentors(value);
                },
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: mentors.length,
                      itemBuilder: (context, index) {
                        final mentor = mentors[index];
                        return ListTile(
                          title: Text(mentor['name']),
                          subtitle: Text(mentor['email']),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
