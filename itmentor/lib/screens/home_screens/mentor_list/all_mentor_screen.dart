import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/services/auth_services.dart';

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
                    child: Text('Danh sách mentor'),
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
                    // Hiển thị danh sách mentors ở đây
                    List<dynamic>? mentorsData = snapshot.data;
                    return ListView.builder(
                      itemCount: mentorsData!.length,
                      itemBuilder: (context, index) {
                        final mentor = mentorsData[index];
                        final gender = mentorsData[index]['gender'];
                        // Hiển thị thông tin mentor ở đây, ví dụ:
                        return ListTile(
                          leading: gender == true
                              ? Image.asset('assets/images/male_avatar.jpg')
                              : Image.asset('assets/images/female_avatar.png'),
                          title: Text(mentor['name'] ?? mentor['email']),
                          subtitle: Text(mentor['email']),
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
