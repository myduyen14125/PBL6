import 'package:flutter/material.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/profile_screen_detail.dart';
import 'package:itmentor/screens/account_settings_screen/custom_row.dart';

class UtilitiesScreen extends StatelessWidget {
  const UtilitiesScreen({super.key});

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
              'Tiệc ích',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const ProfileScreenDetail();
                  }),
                ),
              );
            },
            child: CustomRow(
              const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              const Text(
                'Hồ sơ cá nhân',
                style: TextStyle(fontSize: 16),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          ),
          CustomRow(
            Icon(
              Icons.favorite,
              color: Colors.red[400],
            ),
            const Text(
              'Yêu thích',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.groups,
              color: Color.fromARGB(255, 3, 88, 6),
            ),
            const Text(
              'Tìm bạn bè',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.view_list,
              color: Colors.purple,
            ),
            const Text(
              'Lĩnh vực quan tâm',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.share,
              color: Colors.orange,
            ),
            const Text(
              'Giới thiệu bạn bè',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.person_add,
              color: Colors.purple,
            ),
            const Text(
              'Thêm người giới thiệu',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.how_to_reg,
              color: Colors.green,
            ),
            const Text(
              'Dành cho mentor',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          CustomRow(
            const Icon(
              Icons.lightbulb_sharp,
              color: Colors.amber,
            ),
            const Text(
              'Góp ý cho ITMentor',
              style: TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
