import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/profile_screen_detail.dart';
import 'package:provider/provider.dart';

class AvatarName extends StatefulWidget {
  final String profileName;
  const AvatarName({super.key, required this.profileName});

  @override
  State<AvatarName> createState() => _AvatarNameState();
}

class _AvatarNameState extends State<AvatarName> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
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
                    child: Row(
                      children: const [
                        Text(
                          'Hồ sơ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/male_avatar.jpg',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(user.name,
                    style: const TextStyle(fontSize: 20.0)),
                const Icon(
                  Icons.verified_user,
                  size: 16.0,
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
