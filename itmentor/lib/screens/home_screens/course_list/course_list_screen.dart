import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         // call api get all course
  //         // hard code first
  //         Column(
  //           children: [
  //             Card(
  //               elevation: 4,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12.0),
  //               ),
  //               child: ListTile(
  //                 leading: Image.asset(
  //                   'assets/course_icon/cplusplus_icon.png',
  //                   width: 48,
  //                   height: 48,
  //                 ),
  //                 title: const Text('Khoá học C++'),
  //                 subtitle: Row(
  //                   children: const [
  //                     Text('Giảng dạy bởi Nguyễn Trần\nMỹ Duyên'),
  //                     Spacer(),
  //                     Text('Chi tiết', style: TextStyle(color: Colors.green)),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF1369B2),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //           ),
  //           child: const Text('Xem thêm khoá học'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
      backgroundColor: Colors.transparent,
      body: isLoading
          ? const Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: courses.length > 3 ? 3 : courses.length,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20.0)),
                        child: CachedNetworkImage(
                          imageUrl: course['image'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course['title'],
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Giảng viên: ${course['creator']['name']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Chuyên môn: ${course['creator']['expertise']['name']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Giá: \$${course['price']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Mô tả: ${course['description']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Số bài học: ${course['lesson_count']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Số học viên: ${course['user_count']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
