import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio_screen.dart';
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
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    }),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        'Thông tin cá nhân',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Profile Info
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: selectedImagePath !=
                                              'https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png'
                                          ? FileImage(File(
                                              selectedImagePath)) // Use FileImage for local file paths
                                          : NetworkImage(avatar)
                                              as ImageProvider, // Use NetworkImage for remote URLs
                                      child: InkWell(
                                        onTap: () {
                                          _pickImage(token);
                                        },
                                        customBorder: const CircleBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  '4',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Giờ cố vấn'),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
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
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email: $email',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Ngày Sinh: $formattedDateOfBirth',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Giới Tính: $genderText',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              if (role == "mentor")
                                MentorAction(
                                  token: token,
                                  mentorId: id,
                                )
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
