import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile/mentor_profile_detail.dart';
import 'package:itmentor/services/auth_services.dart';
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
        print(allMentors);
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

    final uri = Uri.https(Constants.uri, '/mentor', {'page': '$currentPage'});

    final response = await http.get(uri);
    final data = json.decode(response.body);

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
                            final avatar = mentor['avatar'];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MentorProfileDetail(
                                      id: mentor['_id'],
                                      avatar: avatar,
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
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: double.infinity),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(16),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: avatar != ""
                                            ? CachedNetworkImageProvider(
                                                    avatar as String)
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/images/blank_avatar.png'),
                                      ),
                                      title: Text(
                                        mentor['name'] ?? mentor['email'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'Email: ${mentor['email']}',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.hotel_class_rounded,
                                                color: Colors.teal[300],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                mentor['expertise'] != null ? 'Chuyên môn: ${mentor['expertise']['name']}' : 'Chuyên môn: Không hiển thị',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.people,
                                                color: Colors.purple,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Số lượng mentee: ${mentor['number_of_mentees']}',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
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
