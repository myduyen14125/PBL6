import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/screens/account_settings_screen/account_settings_screen.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio_screen.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/skills/create_skills.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/mentor_action/mentor_action.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class ProfileScreenDetail extends StatefulWidget {
  const ProfileScreenDetail({super.key});

  @override
  State<ProfileScreenDetail> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenDetail> {
  final AuthServices authServices = AuthServices();
  List<dynamic> awards = [];
  List<dynamic> skills = [];
  List<dynamic> educations = [];
  List<dynamic> experiences = [];

  String bioId = '';

  String selectedImagePath =
      "https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png";

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  List<Map<String, dynamic>> blogData = [];

  Future<void> _pickImage(String token) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImagePath = pickedImage.path;
        updateAvatar(selectedImagePath, token);
      });
      print('Selected image path: ${pickedImage.path}');
    }
  }

  Future<void> updateAvatar(String imagePath, String token) async {
    try {
      final uri = Uri.https(Constants.uri, '/user/update-avatar');

      final request = http.MultipartRequest('PATCH', uri);

      final file = await http.MultipartFile.fromPath('avatar', imagePath);
      request.files.add(file);

      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();

      print("upload code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print('Avatar updated successfully.');
        showSnackBar(context, 'Đã thay đổi ảnh');
      } else {
        print('Failed to update avatar. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('ScrollHoSoCaNhan'),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 157, 144),
        elevation: 0,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: SafeArea(
          child: FutureBuilder<String?>(
            future: authServices.getToken(),
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.connectionState == ConnectionState.done) {
                if (tokenSnapshot.hasError) {
                  return Center(child: Text('Error: ${tokenSnapshot.error}'));
                }

                final token = tokenSnapshot.data;

                return FutureBuilder<Map<String, dynamic>>(
                  future: authServices.fetchProfile(token!, context),
                  builder: (context, profileSnapshot) {
                    if (profileSnapshot.connectionState ==
                        ConnectionState.done) {
                      if (profileSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${profileSnapshot.error}'));
                      }

                      final data = profileSnapshot.data;

                      final name = data!['name'];
                      final email = data['email'];
                      final dateOfBirth = data['date_of_birth'];
                      final gender = data['gender'];
                      final role = data['role'];
                      final id = data['_id'];
                      final numberOfMentee = data['number_of_mentees'];
                      final avatar = data['avatar'];

                      awards = data['bio']['awards'];
                      skills = data['bio']['skills'];
                      educations = data['bio']['educations'];
                      experiences = data['bio']['experiences'];
                      print(experiences);

                      print(data['bio']);

                      bioId = data['bio']['_id'];

                      print('awardId: $bioId');

                      DateTime? dateOfBirthDateTime =
                          DateTime.tryParse(dateOfBirth);

                      String formattedDateOfBirth = '';
                      if (dateOfBirthDateTime != null) {
                        formattedDateOfBirth = DateFormat('dd-MM-yyyy')
                            .format(dateOfBirthDateTime);
                      }

                      String genderText = gender ? 'Nam' : 'Nữ';

                      return Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Profile Info
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        selectedImagePath !=
                                                'https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png'
                                            ? File(selectedImagePath)
                                                .path // Use File for local file paths
                                            : avatar == ""
                                                ? (gender == true
                                                    ? 'assets/images/male_avatar.jpg'
                                                    : 'assets/images/female_avatar.png')
                                                : avatar,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _pickImage(token);
                                        },
                                        customBorder: const CircleBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      elevation: 4,
                                      child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  numberOfMentee == null
                                                      ? '0'
                                                      : '$numberOfMentee',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text('Mentee'),
                                              ],
                                            ),
                                            const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '4',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Giờ cố vấn'),
                                              ],
                                            ),
                                            const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '5.0',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Đánh giá'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    BioScreen(
                                      token: token,
                                      bioId: bioId,
                                      awards: awards,
                                      skills: skills,
                                      educations: educations,
                                      experiences: experiences,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),

                              if (role == "mentor")
                                MentorAction(
                                  token: token,
                                  mentorId: id,
                                ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
