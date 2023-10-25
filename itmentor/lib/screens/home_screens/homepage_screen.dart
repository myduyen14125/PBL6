import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/category_screen.dart';
import 'package:itmentor/screens/home_screens/course_list/course_list_screen.dart';
import 'package:itmentor/screens/home_screens/latest_news_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_list_screen.dart';
import 'package:itmentor/screens/home_screens/profile_screens/profile_screen.dart';
import 'package:itmentor/screens/home_screens/related_fields_screen.dart';
import 'package:itmentor/screens/home_screens/search_mentors/search_mentor_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    _postController = TabController(vsync: this, length: postTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print('homepage user: ${user.name}');

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
                                    return SearchMentor();
                                  }),
                                ),
                              );
                            }),
                            icon: const Icon(Icons.search)),
                        IconButton(
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()),
                              );
                            }),
                            icon: const Icon(Icons.face)),
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
                        height: 300,
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
                const RelatedFieldScreen(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Card(
                          child: TabBar(
                            controller: _postController,
                            tabs: postTabs,
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
                        height: 500,
                        child: TabBarView(
                          controller: _postController,
                          children: const [
                            CategoryScreen(),
                            LatestNewsScreen(),
                          ],
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
