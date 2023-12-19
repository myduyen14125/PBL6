import 'package:flutter/material.dart';
import 'package:itmentor/screens/account_settings_screen/custom_row.dart';
import 'package:itmentor/screens/account_settings_screen/settings_screens/settings_home/settings_home.dart';
import 'package:itmentor/services/auth_services.dart';

class SettingsScreen extends StatelessWidget {
  final String token;
  const SettingsScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Khác',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return SettingsHome(token: token);
                  }),
                ),
              );
            },
            child: CustomRow(
              const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 69, 59, 59),
              ),
              const Text(
                'Cài đặt và Quyền riêng tư',
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
              Icons.content_paste,
              color: Color.fromARGB(255, 69, 59, 59),
            ),
            const Text(
              'Điều khoản và chính sách',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác nhận đăng xuất'),
                    content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          AuthServices().signOut(context);
                        },
                        child: const Text(
                          'Có',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Không'),
                      ),
                    ],
                  );
                },
              );
            },
            child: CustomRow(
              const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 69, 59, 59),
              ),
              const Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 16),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
