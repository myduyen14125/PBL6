import 'package:flutter/material.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/experiences/edit_experiences_detail.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class EditExperiences extends StatefulWidget {
  final List<dynamic> experiences;
  final String token;
  final Function(String) onExperienceDeleted;

  EditExperiences(
      {Key? key,
      required this.experiences,
      required this.token,
      required this.onExperienceDeleted})
      : super(key: key);

  @override
  State<EditExperiences> createState() => _EditExperiencesState();
}

class _EditExperiencesState extends State<EditExperiences> {
  void deleteExperience(String experienceId) async {
    final url = Uri.https(Constants.uri, '/experience/$experienceId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      print('Experiences data deleted successfully.');
      widget.onExperienceDeleted(experienceId);
      Navigator.of(context).pop();
      showSnackBar(context, 'Đã xoá kinh nghiệm làm việc');
    } else {
      print('Failed to delete experiences data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    print('list experiences: ${widget.experiences}');
  }

  // void updateExperienceList(Map<String, dynamic> updatedExperience) {
  //   setState(() {
  //     final index = widget.experiences
  //         .indexWhere((exp) => exp['_id'] == updatedExperience['_id']);
  //     if (index != -1) {
  //       widget.experiences[index] = updatedExperience;
  //     }
  //   });
  // }

  Future<void> _confirmDeleteExperience(String experienceId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá'),
          content: const Text('Bạn có muốn xoá kinh nghiệm này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            TextButton(
              key: Key('ConfirmDeleteExperience'),
              onPressed: () {
                deleteExperience(experienceId);
                Navigator.of(context).pop();
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
          'Xoá kinh nghiệm',
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
              itemCount: widget.experiences.length,
              itemBuilder: (context, index) {
                final experience = widget.experiences[index];
                final startDate = DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(experience['start_date']));
                final endDate = DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(experience['end_date']));

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 59, 105, 255),
                      child: Icon(
                        Icons.work_outline,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      experience['position'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          experience['company'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$startDate đến $endDate',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('tap experience: $experience');
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          key: Key('IconDeleteExperience'),
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // deleteExperience(experience['_id']);
                            _confirmDeleteExperience(experience['_id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
