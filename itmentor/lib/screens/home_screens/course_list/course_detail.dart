import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:video_player/video_player.dart';

class CourseDetail extends StatefulWidget {
  final String courseId;
  const CourseDetail({super.key, required this.courseId});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late List<dynamic> courseDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(widget.courseId);
  }

  Future<void> fetchData(String courseId) async {
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/course/$courseId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        courseDetails = json.decode(response.body);
        isLoading = false;
      });
    } else {
      isLoading = false;
      showSnackBar(context, 'Lỗi hệ thống');
    }
  }

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      showControls: true,
      showOptions: true,
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 9,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Error loading video: $errorMessage',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    return Chewie(
      controller: _chewieController!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 157, 144),
        elevation: 0,
        title: const Text(
          'Chi tiết khoá học',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: courseDetails.length,
              itemBuilder: (context, index) {
                final course = courseDetails[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: course['image'],
                            height: 150.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: Text(
                            course['title'],
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              course['creator']['avatar'],
                            ),
                            radius: 30, // Adjust the radius as needed
                          ),
                          title: const Text('Giảng viên'),
                          subtitle: Text(course['creator']['name']),
                        ),
                        ListTile(
                          title: const Text(
                            'Mô tả',
                            style: TextStyle(
                              fontSize: 18, // Adjust the font size
                              fontWeight: FontWeight.bold, // Make the text bold
                              color: Colors.blue, // Change the text color
                            ),
                          ),
                          subtitle: Text(
                            course['description'],
                            style: const TextStyle(
                              fontSize: 16, // Adjust the font size
                              color: Colors.grey, // Change the text color
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Giá',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            '\$${course['price']}',
                            style: const TextStyle(
                                fontSize: 16, // Adjust the font size
                                color: Color.fromARGB(
                                    255, 213, 29, 109) // Change the text color
                                ),
                          ),
                        ),
                        ListTile(
                          title: const Text('Chuyên ngành'),
                          subtitle:
                              Text(course['creator']['expertise']['name']),
                        ),
                        const Text(
                          'Lessons:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (var lesson in course['lessons'])
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text('Tên bài học'),
                                subtitle: Text(lesson['title']),
                              ),
                              ListTile(
                                title: const Text('Mô tả bài học'),
                                subtitle: Text(lesson['description']),
                              ),
                              const Divider(),
                              if (lesson['video'] != null)
                                _buildVideoPlayer(lesson['video']),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
