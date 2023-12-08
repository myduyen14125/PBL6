import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileEdit extends StatefulWidget {
  final String? dateOfBirth;
  const ProfileEdit({super.key, required this.dateOfBirth});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController skypeController = TextEditingController();
  final TextEditingController meetingController = TextEditingController();

  String updatedDateOfBirth = '';

  String? token = '';

  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    _getToken();
    selectedDate2 = DateTime.parse(widget.dateOfBirth!);
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
      genderController.text = user.gender == true ? "Nam" : "Nữ";
      facebookController.text = user.facebookLink;
      skypeController.text = user.skypeLink;
    });
  }

  Future<void> updateUserData(User user, BuildContext ctx) async {
    final apiUrl = Uri.https(Constants.uri, '/user');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // final dateOfBirth = formatUserDateOfBirth(dateOfBirthController.text);
    final body = jsonEncode({
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'date_of_birth': selectedDateString,
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
        user.facebookLink = facebookController.text;
        user.skypeLink = skypeController.text;
        user.dateOfBirth = selectedDateString;
        print('updated: ${user.name}');

        Provider.of<UserProvider>(ctx, listen: false).updateUser(user);
      } else {
        print(
            'Failed to update user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  DateTime? selectedDate;
  String selectedDateString = '';

  DateTime? selectedDate2;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateString = picked.toLocal().toString();
        formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    formattedDate = widget.dateOfBirth != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.dateOfBirth!)) : '';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Ngày sinh: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : formattedDate,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Chọn ngày'),
                  ),
                ],
              ),
              _buildTextFormField('Giới tính', genderController),
              _buildTextFormField('Facebook', facebookController),
              _buildTextFormField('Skype', skypeController),
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
