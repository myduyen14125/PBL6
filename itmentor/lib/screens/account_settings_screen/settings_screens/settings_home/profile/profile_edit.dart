import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController skypeController = TextEditingController();
  final TextEditingController meetingController = TextEditingController();

  String? token = '';

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('x-auth-token');
    setState(() {
      token = storedToken;
    });
  }

  Widget _buildTextFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  void setData(User user) {
    setState(() {
      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;
      dateOfBirthController.text = user.dateOfBirth;
      genderController.text = user.gender == true ? "Nam" : "Nữ";
    });
  }

  Future<void> updateUserData(User user, BuildContext ctx) async {
    final apiUrl = Uri.https(Constants.uri, '/user');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = jsonEncode({
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'gender': genderController.text == "Nam" ? true : false,
    });

    try {
      final response = await http.patch(
        apiUrl,
        headers: headers,
        body: body,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        print('User data updated successfully.');
        // Update the user data in the UserProvider
        user.name = nameController.text;
        user.email = emailController.text;
        user.phone = phoneController.text;
        user.gender = genderController.text == "Nam" ? true : false;
        print('updated: ${user.name}');

        // Update the UserProvider
        Provider.of<UserProvider>(ctx, listen: false).updateUser(user);
      } else {
        print(
            'Failed to update user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    setData(user);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: const Icon(Icons.arrow_back)),
                  const Expanded(
                    child: Text(
                      'Thông tin tài khoản',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              _buildTextFormField('Họ và tên', nameController),
              _buildTextFormField('Email', emailController),
              _buildTextFormField('Số điện thoại', phoneController),
              _buildTextFormField('Địa chỉ', addressController),
              _buildTextFormField('Ngày sinh', dateOfBirthController),
              _buildTextFormField('Giới tính', genderController),
              _buildTextFormField('Facebook', facebookController),
              _buildTextFormField('Skype', skypeController),
              _buildTextFormField('Google meet', meetingController),
              Center(
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateUserData(user, context);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1369B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 8),
                          Text('Lưu thay đổi'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
