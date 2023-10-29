import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/category/blogs/all_blogs_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String selectedValue1 = 'Lĩnh vực';
  String selectedValue2 = 'Đánh giá';
  String selectedValue3 = 'Đánh giá';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Card(
                            child: DropdownButton<String>(
                              value: selectedValue1,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue1 = newValue!;
                                });
                              },
                              items: <String>[
                                'Lĩnh vực',
                                'Option b',
                                'Option C',
                                'Option D'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Card(
                            child: DropdownButton<String>(
                              value: selectedValue2,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue2 = newValue!;
                                });
                              },
                              items: <String>[
                                'Đánh giá',
                                'Option b',
                                'Option C',
                                'Option D'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Card(
                            child: DropdownButton<String>(
                              value: selectedValue3,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue3 = newValue!;
                                });
                              },
                              items: <String>[
                                'Đánh giá',
                                'Option b',
                                'Option C',
                                'Option D'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // call api get all blogs
                  // hard code first
                  Column(
                    children: [
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              Image.asset('assets/images/logo.png'),
                              const Text('Tin tức công nghệ sáng 31//7'),
                              const Text('Twitter đổi tên sang X'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.calendar_month),
                                        Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text('07/10/2023')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF195A94),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Đặt bán kính bo tròn
                                        ),
                                      ),
                                      child: Row(
                                        children: const [
                                          Text('Xem tiếp'),
                                          Icon(
                                            Icons.arrow_circle_right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllBlogsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1369B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Xem thêm bài viết'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
