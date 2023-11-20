import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile/mentor_profile_detail.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';

class MobileMentorsScreen extends StatefulWidget {
  final String mobileDevelopmentId;
  const MobileMentorsScreen({super.key, required this.mobileDevelopmentId});

  @override
  State<MobileMentorsScreen> createState() => _MobileMentorsScreenState();
}

class _MobileMentorsScreenState extends State<MobileMentorsScreen> {
  late Future<List<dynamic>> networkingMentors;
  List<dynamic> allNetworkingMentors = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    networkingMentors = fetchNetworkingMentors();
    networkingMentors.then((mentorsData) {
      setState(() {
        allNetworkingMentors.addAll(mentorsData);
        isFirstLoad = false;
        print(allNetworkingMentors);
      });
    });
  }

  Future<List<dynamic>> fetchNetworkingMentors() async {
    try {
      final apiUrl = Uri.https(Constants.uri, '/mentor/search',
          {'expertise': widget.mobileDevelopmentId});
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['mentors']);
      } else {
        showSnackBar(context, 'Lỗi hệ thống');
        throw Exception('Failed to load mentor data');
      }
    } catch (e) {
      showSnackBar(context, 'Lỗi hệ thống');
      throw Exception('Failed to load mentor data');
    }
  }

  Future<void> loadMoreMentors() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    currentPage++;

    final uri = Uri.https(Constants.uri, '/mentor/search',
        {'expertise': widget.mobileDevelopmentId, 'page': '$currentPage'});

    final response = await http.get(uri);
    final data = json.decode(response.body);
    print(data);

    if (data['mentors'] != null) {
      setState(() {
        allNetworkingMentors.addAll(data['mentors']);
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
                          itemCount: allNetworkingMentors.length,
                          itemBuilder: (context, index) {
                            final mentor = allNetworkingMentors[index];
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
                                    constraints: BoxConstraints(
                                        maxHeight: double.infinity),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(16),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: avatar != ""
                                            ? CachedNetworkImageProvider(avatar as String)
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
                                                'Chuyên môn: ${mentor['expertise']['name']}',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
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
