import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/category_screen.dart';
import 'package:itmentor/screens/home_screens/course_list/course_list_screen.dart';
import 'package:itmentor/screens/home_screens/latest_news_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_list_screen.dart';
import 'package:itmentor/screens/home_screens/related_fields_screen.dart';
import 'package:itmentor/screens/home_screens/search_mentors/search_mentor_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'MENTOR'),
    const Tab(text: 'KHOÁ HỌC'),
  ];

  late TabController _postController;

  final List<Tab> postTabs = <Tab>[
    const Tab(text: 'DANH MỤC'),
    const Tab(text: 'TIN MỚI NHẤT'),
  ];

  late List<Map<String, dynamic>> expertiseData;
  List<String> expertiseId = [];

  Future<List<Map<String, dynamic>>> fetchExpertise() async {
    final apiUrl = Uri.https(Constants.uri, '/expertise');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load expertise data');
    }
  }

  void fetchData() async {
    try {
      expertiseData = await fetchExpertise();
      for (var expertise in expertiseData) {
        expertiseId.add(expertise['_id']);
      }
      print(expertiseId);
    } catch (e) {
      // Handle errors
      print('Error fetching expertise data: $e');
    }
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    _postController = TabController(vsync: this, length: postTabs.length);
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: (() {}), icon: const Icon(Icons.menu)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (() {}),
                            icon: const Icon(Icons.notifications)),
                        IconButton(
                          onPressed: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return const SearchMentor();
                                }),
                              ),
                            );
                          }),
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Card(
                          child: TabBar(
                            controller: _tabController,
                            tabs: tabs,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.blueGrey,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            indicatorColor: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 240,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            MentorListScreen(),
                            CourseListScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllMentorsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1369B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Xem thêm mentor'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Lĩnh vực bạn quan tâm',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
                RelatedFieldScreen(
                  expertiseId: expertiseId,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Bài viết mới',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 500,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CategoryScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
