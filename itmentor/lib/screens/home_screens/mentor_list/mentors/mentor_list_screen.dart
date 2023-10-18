import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/all_mentor_screen.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile_detail.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/utils.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                ],
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: mentors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<dynamic>? mentorData = snapshot.data;
                  int itemCount =
                      mentorData!.length < 3 ? mentorData.length : 3;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final mentor = mentorData[index];
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
                                      )),
                            );
                          },
                          leading: Image.asset(
                            mentor['gender'] == true
                                ? 'assets/images/male_avatar.jpg'
                                : 'assets/images/female_avatar.png',
                            width: 48,
                            height: 48,
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
