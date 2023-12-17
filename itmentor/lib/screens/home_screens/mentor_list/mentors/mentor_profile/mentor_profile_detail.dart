import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_screen.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorProfileDetail extends StatefulWidget {
  final String id;
  final String avatar;
  MentorProfileDetail({
    super.key,
    required this.id,
    required this.avatar,
  });

  @override
  State<MentorProfileDetail> createState() => _MentorProfileDetailState();
}

class _MentorProfileDetailState extends State<MentorProfileDetail> {
  Map<String, dynamic> userData = {};
  List<Map<String, dynamic>> blogs = [];
  List<dynamic> experiences = [];
  List<dynamic> awards = [];
  List<dynamic> skills = [];
  List<dynamic> educations = [];

  Map<String, dynamic> currentUserData = {};

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchBlogs();
    getAccessToken();
  }

  Future<void> fetchBlogs() async {
    final url = Uri.https(Constants.uri, '/user/${widget.id}/blogs');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> blogList = data['blogs'];

      setState(() {
        blogs = blogList.cast<Map<String, dynamic>>();
      });
    } else {
      debugPrint('Fail to load blogs');
    }
  }

  Future<void> fetchUserData() async {
    final uri = Uri.https(Constants.uri, '/user/${widget.id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userData = data;
        experiences = data['bio']['experiences'];
        awards = data['bio']['awards'];
        skills = data['bio']['skills'];
        educations = data['bio']['educations'];
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  String accessToken = '';

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('x-auth-token') ?? '';
      print('mentor screen token: $accessToken');
      fetchProfile();
    });
  }

  Future<void> fetchProfile() async {
    final url = Uri.https(Constants.uri, '/user/profile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          currentUserData = data;
          print(currentUserData);
          print('user appointment role: ${currentUserData['role']}');
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        title: const Text(
          'Thông tin mentor',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: userData.isNotEmpty
          ? SafeArea(
              child: SingleChildScrollView(
                key: Key('mentorProfile'),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.avatar != ''
                            ? CachedNetworkImageProvider(widget.avatar)
                            : const AssetImage('assets/images/blank_avatar.png')
                                as ImageProvider,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          '${userData['name']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 4,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userData['number_of_mentees'] == null
                                        ? '0'
                                        : '${userData['number_of_mentees']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text('Mentee'),
                                ],
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '4',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Giờ cố vấn'),
                                ],
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '5.0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Đánh giá'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            key: Key('chooseSchedule'),
                            onPressed: () {
                              currentUserData['role'] != 'mentor'
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChooseSchedule(
                                          mentorId: userData['_id'],
                                          mentorName: userData['name'],
                                          mentorAvatar: userData['avatar'],
                                          mentorExpertise: userData['expertise'] != null ?
                                              userData['expertise']['name'] : '`',
                                        ),
                                      ),
                                    )
                                  : showSnackBar(
                                      context, 'Mentor không thể đặt lịch');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1369B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text('Đặt lịch'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Implement the action for the "Yêu thích" button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  size: 24,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Yêu thích',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.message_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Nhắn tin',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kinh nghiệm làm việc',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              experiences.isEmpty
                                  ? const Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text('Không có dữ liệu')),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: experiences.length,
                                      itemBuilder: (context, index) {
                                        final experience = experiences[index];

                                        // Parse the start date
                                        final startDate = DateTime.parse(
                                            experience['start_date']);
                                        final endDate = DateTime.parse(
                                            experience['end_date']);

                                        // Format the date to dd:MM:yyyy
                                        final formattedStartDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(startDate);
                                        final formattedEndDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(endDate);

                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            leading: const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 59, 105, 255),
                                              child: Icon(
                                                Icons.work_outline,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              experience['position'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  experience['company'],
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Từ $formattedStartDate đến $formattedEndDate',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              const SizedBox(height: 16.0),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Học vấn',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              educations.isEmpty
                                  ? const Center(
                                      child: Text('Không có dữ liệu'),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: educations.length,
                                      itemBuilder: (context, index) {
                                        final education = educations[index];

                                        // Parse the start date
                                        final startDate = DateTime.parse(
                                            education['start_date']);
                                        final endDate = DateTime.parse(
                                            education['end_date']);

                                        final formattedStartDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(startDate);
                                        final formattedEndDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(endDate);
                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            leading: const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 59, 255, 137),
                                              child: Icon(
                                                Icons.school,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              education['place'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  education['major'],
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'Từ $formattedStartDate đến $formattedEndDate',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Giải thưởng',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              awards.isEmpty
                                  ? Center(
                                      child: Text('Không có dữ liệu'),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: awards.length,
                                      itemBuilder: (context, index) {
                                        final award = awards[index];

                                        final awardedDate =
                                            DateTime.parse(award['date']);

                                        final formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(awardedDate);
                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.all(16),
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.cyanAccent,
                                              child: Icon(
                                                Icons.military_tech,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              award['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Description: ${award['description']}',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Ngày trao thưởng: $formattedDate',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Kĩ năng',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              skills.isEmpty
                                  ? Center(
                                      child: Text('Không có dữ liệu'),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: skills.length,
                                      itemBuilder: (context, index) {
                                        final skill = skills[index];
                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(6),
                                            leading: const CircleAvatar(
                                              backgroundColor: Colors.yellow,
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              skill['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Text(
                                              'Mô tả: ${skill['description']}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Blogs',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: blogs.length,
                                itemBuilder: (context, index) {
                                  final blog = blogs[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return BlogDetailScreen(
                                              blogId: blog['_id'],
                                              blogContent: blog['content'],
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(blog['title']),
                                        subtitle: Text(
                                          stripHtmlTags(blog['content'])
                                                      .length <=
                                                  300
                                              ? stripHtmlTags(blog['content'])
                                              : '${stripHtmlTags(blog['content']).substring(0, 300)}...',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
