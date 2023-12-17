import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';

import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  final String token;
  const ChangePassword({super.key, required this.token});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordController2 = TextEditingController();
  bool isLoading = false;

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

  Future<void> callChangePasswordApi(
      String token, String oldPassword, String newPassword) async {
    setState(() {
      isLoading = true;
    });
    final apiUrl = Uri.https(Constants.uri, '/user/change-password');

    try {
      final response = await http.patch(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Đổi mật khẩu thành công');
        print('Change Password API call successful');
        print('Response: ${response.body}');
        setState(() {
          currentPasswordController.text = "";
          newPasswordController.text = "";
          newPasswordController2.text = "";
        });
      } else {
        // Handle error
        setState(() {
          isLoading = false;
        });
        showSnackBar(context,
            'Sai mật khẩu cũ hoặc mật khẩu mới không thể trùng mật khẩu cũ.');
        print(
            'Change Password API call failed with status ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('forget password: ${widget.token}');
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
                      'Đổi mật khẩu',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              _buildTextFormField(
                  'Mật khẩu hiện tại', currentPasswordController),
              _buildTextFormField('Mật khẩu mới', newPasswordController),
              _buildTextFormField(
                  'Nhập lại mật khẩu mới', newPasswordController2),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Center(
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      if (newPasswordController.text !=
                          newPasswordController2.text) {
                        showSnackBar(context, 'Mật khẩu mới không khớp');
                        return;
                      }
                      callChangePasswordApi(
                          widget.token,
                          currentPasswordController.text,
                          newPasswordController.text);
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
                          Text('Đổi mật khẩu'),
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
