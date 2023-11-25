import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile/mentor_profile_detail.dart';
import 'package:itmentor/services/auth_services.dart';

class MentorListScreen extends StatefulWidget {
  const MentorListScreen({super.key});

  @override
  State<MentorListScreen> createState() => _MentorListScreenState();
}

class _MentorListScreenState extends State<MentorListScreen> {
  String selectedValue1 = 'Lĩnh vực';
  String selectedValue2 = 'Đánh giá';

  final AuthServices authServices = AuthServices();

  late Future<List<dynamic>> mentors;

  @override
  void initState() {
    super.initState();
    mentors = authServices.fetchMentors();
    print("mentor list screen: $mentors");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: mentors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Lỗi: ${snapshot.error}');
                } else {
                  List<dynamic>? mentorData = snapshot.data;
                  int itemCount =
                      mentorData!.length < 3 ? mentorData.length : 3;

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final mentor = mentorData[index];
                          final avatar = mentor['avatar'];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MentorProfileDetail(
                                      id: mentor['_id'],
                                      avatar: avatar,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: avatar != ""
                                    ? CachedNetworkImageProvider(avatar as String)
                                        as ImageProvider
                                    : const AssetImage(
                                        'assets/images/blank_avatar.png'),
                              ),
                              title: Text('${mentor['name']}'),
                              subtitle: Row(
                                children: [
                                  Text('${mentor['email']}'),
                                  const Spacer(),
                                  const Text(
                                    'Chi tiết',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
