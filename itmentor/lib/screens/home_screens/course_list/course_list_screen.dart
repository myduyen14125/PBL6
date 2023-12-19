import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:itmentor/screens/home_screens/course_list/course_detail.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  List<dynamic> courses = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    setState(() {
      isLoading = true;
    });
    final apiUrl = Uri.https(Constants.uri, '/course');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      debugPrint(response.body);
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        courses = data['courses'];
        isLoading = false;
      });
    } else {
      showSnackBar(context, 'Lỗi hệ thống');
      isLoading = false;
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 157, 144),
        elevation: 0,
        title: const Text('Khoá học'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: courses.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  final course = courses[index];
                  debugPrint(course);
                  return Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            debugPrint('course clicked');
                            debugPrint('course id: ${course['_id']}');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CourseDetail(courseId: course['_id']);
                            }));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                                child: CachedNetworkImage(
                                  imageUrl: course['image'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course['title'],
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(Icons.person,
                                        'Giảng viên: ${course['creator']['name']}'),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.star,
                                        'Chuyên ngành: ${course['creator']['expertise']['name']}'),
                                    const SizedBox(height: 10),
                                    _buildPriceRow(
                                        Icons.attach_money, course['price']),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.description,
                                        'Mô tả: ${course['description']}'),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.library_books,
                                        'Số bài học: ${course['lesson_count']}'),
                                    const SizedBox(height: 10),
                                    _buildInfoRow(Icons.people,
                                        'Số học sinh: ${course['user_count']}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.0),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(IconData icon, int price) {
    return Row(
      children: [
        Icon(icon, size: 16.0),
        const SizedBox(width: 4),
        Text(
          'Giá: ${price} VND',
          style: TextStyle(
            fontSize: 16.0,
            color: price == 0
                ? Colors.green
                : const Color.fromARGB(255, 218, 88, 131),
          ),
        ),
      ],
    );
  }
}
