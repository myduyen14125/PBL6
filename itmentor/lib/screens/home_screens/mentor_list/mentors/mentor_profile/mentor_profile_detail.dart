import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/schedule/choose_schedule_screen.dart';
import 'package:itmentor/utils/constant.dart';

import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';

class MentorProfileDetail extends StatefulWidget {
  final String id;
  final String avatar;
  final bool gender;
  MentorProfileDetail(
      {super.key,
      required this.id,
      required this.avatar,
      required this.gender});

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

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchBlogs();
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
      throw Exception('Failed to load blogs');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: userData.isNotEmpty
          ? SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.avatar != ''
                            ? NetworkImage(widget.avatar)
                            : widget.gender == true
                                ? AssetImage('assets/images/male_avatar.jpg')
                                : AssetImage('assets/images/female_avatar.png')
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseSchedule(
                                    mentorId: userData['_id'],
                                    mentorName: userData['name'],
                                  ),
                                ),
                              );
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
                            onPressed: () {
                              // Implement the action for the "Nhắn tin" button
                            },
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
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Kinh nghiệm làm việc',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18, // Font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: experiences.length,
                                itemBuilder: (context, index) {
                                  final experience = experiences[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    title: Text(
                                      experience['position'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${experience['company']}\n${experience['start_date']} - ${experience['end_date']}',
                                    ),
                                    onTap: () {},
                                  );
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Học vấn',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: educations.length,
                                itemBuilder: (context, index) {
                                  final education = educations[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    title: Text(
                                      '${education['place']} - ${education['major']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${education['start_date']} - ${education['end_date']}',
                                    ),
                                    onTap: () {},
                                  );
                                },
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Giải thưởng',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: awards.length,
                                itemBuilder: (context, index) {
                                  final award = awards[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    title: Text(
                                      award['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Description: ${award['description']}\nDate: ${award['date']}',
                                    ),
                                    onTap: () {},
                                  );
                                },
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Kỹ năng',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: skills.length,
                                itemBuilder: (context, index) {
                                  final skill = skills[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    title: Text(
                                      skill['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Description: ${skill['description']}',
                                    ),
                                    onTap: () {},
                                  );
                                },
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Blogs',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                      margin: const EdgeInsets.all(8),
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
