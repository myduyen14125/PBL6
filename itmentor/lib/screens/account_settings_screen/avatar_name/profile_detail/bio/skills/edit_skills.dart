import 'package:flutter/material.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/skills/edit_skills_detail.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class EditSkills extends StatefulWidget {
  final List<dynamic> skills;
  final String token;
  final Function(String) onSkillDelete;
  const EditSkills(
      {super.key,
      required this.skills,
      required this.token,
      required this.onSkillDelete});

  @override
  State<EditSkills> createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {
  void deleteSkill(String skillId) async {
    final url = Uri.https(Constants.uri, '/skill/$skillId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      print('skill data deleted successfully.');
      widget.onSkillDelete(skillId);
      showSnackBar(context, 'Đã xoá kĩ năng');
      Navigator.of(context).pop();
    } else {
      print('Failed to delete skill data: ${response.statusCode}');
    }
  }

  Future<void> _confirmDeleleEducation(String educationId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá'),
          content: const Text('Bạn có muốn xoá học vấn này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteSkill(educationId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Xoá kĩ năng',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.skills.length,
              itemBuilder: (context, index) {
                final skill = widget.skills[index];
                print('skill: $skill');
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      skill['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${skill['description']}',
                    ),
                    onTap: () {},
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: ((context) {
                        //   return EditSkillDetail(
                        //     skills: skill,
                        //     token: widget.token,
                        //   );
                        // })));
                        _confirmDeleleEducation(skill['_id']);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
