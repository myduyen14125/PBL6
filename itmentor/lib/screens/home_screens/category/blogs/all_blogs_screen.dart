import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllBlogsScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<AllBlogsScreen> {
  late Future<List<dynamic>> blogs;
  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    blogs = authServices.fetchBlogs(user);

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
                        final avatarUrl = blog['user']['avatar'];
                        return GestureDetector(
                          onTap: () {
                            print('item clicked');
                            print(blog['_id']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(
                                  blogId: blog['_id'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/female_avatar.png',
                                  width: 48, 
                                  height: 48, 
                                ),
                                title: Text(blog['title']),
                                subtitle: Text(
                                  '${blog['content']}\nWritten by ${blog['user']['name']}',
                                ),
                              )),
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
