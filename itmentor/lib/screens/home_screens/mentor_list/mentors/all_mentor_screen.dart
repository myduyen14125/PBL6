import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile_detail.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itmentor/utils/constant.dart';

class AllMentorsScreen extends StatefulWidget {
  const AllMentorsScreen({super.key});

  @override
  State<AllMentorsScreen> createState() => _AllMentorsScreenState();
}

class _AllMentorsScreenState extends State<AllMentorsScreen> {
  final AuthServices authServices = AuthServices();

  late Future<List<dynamic>> mentors;

  @override
  void initState() {
    super.initState();
    mentors = authServices.fetchMentors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: SafeArea(
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
                        'Danh sách mentor',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: mentors,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<dynamic>? mentorsData = snapshot.data;
                      return ListView.builder(
                        itemCount: mentorsData!.length,
                        itemBuilder: (context, index) {
                          final mentor = mentorsData[index];
                          final gender = mentorsData[index]['gender'];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MentorProfileDetail(id: mentor['_id'],)),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: ListTile(
                                leading: gender == true
                                    ? Image.asset(
                                        'assets/images/male_avatar.jpg')
                                    : Image.asset(
                                        'assets/images/female_avatar.png'),
                                title: Text(mentor['name'] ?? mentor['email']),
                                subtitle: Text(mentor['email']),
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
      ),
    );
  }
}
