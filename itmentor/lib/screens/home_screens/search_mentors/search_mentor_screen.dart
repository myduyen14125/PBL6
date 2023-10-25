import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';

class SearchMentor extends StatefulWidget {
  const SearchMentor({super.key});

  @override
  State<SearchMentor> createState() => _SearchMentorState();
}

class _SearchMentorState extends State<SearchMentor> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> mentors = [];

  Future<void> fetchMentors(String name) async {
    // final apiUrl = 'http://localhost:3001/mentor/search?name=$name';
    // final uri = Uri.https(Constants.uri, '/mentor/search?name=$name');

    // final response = await http.get(uri);

    final queryParameters = {
      'name': name,
    };
    final uri = Uri.https(Constants.uri, '/mentor/search', queryParameters);
    final response = await http.get(uri);

    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final mentorsData = jsonData['mentors'] as List<dynamic>;

      setState(() {
        mentors = mentorsData.map((mentor) {
          return mentor as Map<String, dynamic>;
        }).toList();
      });
    } else {
      // Handle API error, e.g., show an error message.
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(labelText: 'Search by Name'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = searchController.text;
              fetchMentors(name);
            },
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mentors.length,
              itemBuilder: (context, index) {
                final mentor = mentors[index];
                return ListTile(
                  title: Text(mentor['name']),
                  subtitle: Text(mentor['email']),
                  // You can display other mentor information here.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
