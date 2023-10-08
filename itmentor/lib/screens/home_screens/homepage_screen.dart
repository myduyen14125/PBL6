import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category_screen.dart';
import 'package:itmentor/screens/home_screens/course_list/course_list_screen.dart';
import 'package:itmentor/screens/home_screens/latest_news_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentor_list_screen.dart';
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
                            onPressed: (() {}), icon: const Icon(Icons.face)),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Tìm Kiếm",
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/ai_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Trí tuệ\nnhân tạo',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/big_data_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Big Data',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/computer_science_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Khoa học\nmáy tính',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/information_security_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'An toàn\nthông tin',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/networking_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Mạng \nmáy tính',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/software_icon.png',
                                  width: 50,
                                  height: 100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Công nghệ\nphần mềm',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
