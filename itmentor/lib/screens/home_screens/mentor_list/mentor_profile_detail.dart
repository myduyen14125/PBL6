import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:http/http.dart' as http;

class MentorProfileDetail extends StatefulWidget {
  final String id;
  MentorProfileDetail({super.key, required this.id});

  @override
  State<MentorProfileDetail> createState() => _MentorProfileDetailState();
}

class _MentorProfileDetailState extends State<MentorProfileDetail> {
  Map<String, dynamic> userData = {}; // Dữ liệu từ API

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userData = data;
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: userData.isNotEmpty
            ? Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: const Icon(Icons.arrow_back)),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Thông tin cá nhân',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/male_avatar.jpg',
                      width: 400,
                      height: 300,
                    ),
                    ListTile(
                      title: Text('Tên: ${userData['name']}'),
                    ),
                    ListTile(
                      title: Text('Email: ${userData['email']}'),
                    ),
                    // ListTile(
                    //   title: Text(
                    //       'Ngày Sinh: ${Constants.formatDateString(widget.user.dateOfBirth)}'),
                    // ),
                    ListTile(
                      title: Text(
                          'Giới Tính: ${userData['gender'] ? 'Male' : 'Female'}'),
                    ),
                    // ListTile(
                    //   title: Text('Số Điện Thoại: ${widget.user.phone}'),
                    // ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
