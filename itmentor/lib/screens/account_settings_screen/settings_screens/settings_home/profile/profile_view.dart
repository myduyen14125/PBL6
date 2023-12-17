import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/settings_screens/settings_home/profile/profile_edit.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 103, 102, 102),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String formatUserDateOfBirth(String dateOfBirth) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateOfBirth));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print(user.dateOfBirth);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Thông tin tài khoản',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return ProfileEdit(dateOfBirth: user.dateOfBirth);
                          }),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10),
              buildInfoRow('Họ và tên', user.name),
              buildInfoRow('Email', user.email),
              buildInfoRow('Số điện thoại', user.phone),
              // buildInfoRow('Ngày sinh', user.dateOfBirth),
              buildInfoRow(
                  'Ngày sinh', formatUserDateOfBirth(user.dateOfBirth)),
              buildInfoRow('Giới tính', user.gender == true ? "Nữ" : "Nam"),
              buildInfoRow('Facebook', user.facebookLink),
              buildInfoRow('Skype', user.skypeLink),
            ],
          ),
        ),
      ),
    );
  }
}
