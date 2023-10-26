import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile/mentor_profile_detail.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;

class AllMentorsScreen extends StatefulWidget {
  const AllMentorsScreen({super.key});

  @override
  State<AllMentorsScreen> createState() => _AllMentorsScreenState();
}

class _AllMentorsScreenState extends State<AllMentorsScreen> {
  final AuthServices authServices = AuthServices();
  late Future<List<dynamic>> mentors;
  List<dynamic> allMentors = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    mentors = authServices.fetchMentors();
    mentors.then((mentorsData) {
      setState(() {
        allMentors.addAll(mentorsData);
        isFirstLoad = false;
      });
    });
  }

  Future<void> loadMoreMentors() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    currentPage++;

    // final uri = Uri.https(Constants.uri, '/mentor?page=$currentPage');
    final uri = Uri.https(Constants.uri, '/mentor', {'page': '$currentPage'});

    final response = await http.get(uri);
    final data = json.decode(response.body);

    print("load more data: $data");

    if (data['mentors'] != null) {
      setState(() {
        allMentors.addAll(data['mentors']);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: Constants.backgroundColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'Danh sách mentor',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: isFirstLoad
                    ? const Center(child: CircularProgressIndicator())
                    : NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            loadMoreMentors();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: allMentors.length,
                          itemBuilder: (context, index) {
                            final mentor = allMentors[index];
                            final gender = mentor['gender'];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MentorProfileDetail(
                                      id: mentor['_id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: gender == true
                                        ? const AssetImage(
                                            'assets/images/male_avatar.jpg')
                                        : const AssetImage(
                                            'assets/images/female_avatar.png'),
                                  ),
                                  title: Text(
                                    mentor['name'] ?? mentor['email'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    mentor['email'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
