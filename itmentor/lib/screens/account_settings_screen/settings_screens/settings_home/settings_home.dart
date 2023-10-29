import 'package:flutter/material.dart';
import 'package:itmentor/screens/account_settings_screen/custom_row.dart';
import 'package:itmentor/screens/account_settings_screen/settings_screens/settings_home/profile/profile_view.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({super.key});

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
                  child: Text(
                    'Quyền riêng tư',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Tài khoản',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return const ProfileView();
                          }),
                        ),
                      );
                    },
                    child: CustomRow(
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      const Text(
                        'Thông tin cá nhân',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  CustomRow(
                    const Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                    const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                  CustomRow(
                    const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    const Text(
                      'Yêu cầu xoá tài khoản',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
