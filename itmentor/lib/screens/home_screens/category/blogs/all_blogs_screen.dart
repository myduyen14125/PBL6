import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/home_screens/category/blogs/blog_detail_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';

class AllBlogsScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<AllBlogsScreen> {
  late Future<List<dynamic>> blogs;
  final AuthServices authServices = AuthServices();

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

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
                  child: Text(
                    'Danh sách blogs',
                    style: TextStyle(fontSize: 20),
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
                        debugPrint(blog['user']['avatar']);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(
                                  blogId: blog['_id'],
                                  blogContent: blog['content'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color.fromARGB(255, 197, 189, 189), width: 1),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: blog['user']['avatar'] == ''
                                    ? const AssetImage(
                                        'assets/images/blank_avatar.png',
                                      )
                                    : CachedNetworkImageProvider(
                                        blog['user']['avatar'],
                                      ) as ImageProvider,
                                child: const InkWell(
                                  customBorder: CircleBorder(),
                                ),
                              ),
                              title: Text(blog['title']),
                              subtitle: Text(
                                stripHtmlTags(blog['content']).length <= 300
                                    ? stripHtmlTags(blog['content'])
                                    : '${stripHtmlTags(blog['content']).substring(0, 300)}...', // Limit to 300 characters
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
