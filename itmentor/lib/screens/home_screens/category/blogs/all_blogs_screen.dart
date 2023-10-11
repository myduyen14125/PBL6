import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:http/http.dart' as http;

class AllBlogsScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<AllBlogsScreen> {
  late Future<List<dynamic>> blogs;
  final AuthServices authServices = AuthServices();

  Future<void> deleteBlogPost(String blogId) async {
    final apiUrl = Uri.http('localhost:5000', '/blog/$blogId');

    try {
      final response = await http.delete(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Thêm các header khác nếu cần thiết
        },
      );

      if (response.statusCode == 200) {
        // Xóa thành công, thực hiện xử lý sau khi xóa nếu cần
        print('Bài viết đã được xóa thành công.');
      } else {
        // Xóa không thành công, xử lý lỗi nếu cần
        print(
            'Có lỗi xảy ra khi xóa bài viết. Mã trạng thái: ${response.statusCode}');
        print('Nội dung lỗi: ${response.body}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Đã xảy ra lỗi: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    blogs = authServices.fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: const Icon(Icons.arrow_back)),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Danh sách blogs',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: blogs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<dynamic>? blogsData = snapshot.data;
                    return ListView.builder(
                      itemCount: blogsData!.length,
                      itemBuilder: (context, index) {
                        final blog = blogsData[index];
                        return GestureDetector(
                          onTap: () {
                            print('item clicked');
                            print(blog['title']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(
                                  blogId: blog['_id'],
                                ),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            background: Container(
                              color: Colors.red,
                              child: const Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              // Xoá blog khỏi danh sách
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: ListTile(
                                leading: blog['user']['gender']
                                    ? Image.asset(
                                        'assets/images/male_avatar.jpg')
                                    : Image.asset(
                                        'assets/images/female_avatar.png'),
                                title: Text(blog['title']),
                                subtitle: Text(
                                    '${blog['content']}\nWritten by ${blog['user']['name']}'),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
