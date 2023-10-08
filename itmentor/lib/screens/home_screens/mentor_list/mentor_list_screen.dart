import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/screens/home_screens/mentor_list/all_mentor_screen.dart';

class MentorListScreen extends StatefulWidget {
  const MentorListScreen({super.key});

  @override
  State<MentorListScreen> createState() => _MentorListScreenState();
}

class _MentorListScreenState extends State<MentorListScreen> {
  String selectedValue1 = 'Lĩnh vực';
  String selectedValue2 = 'Đánh giá';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50.0, 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100.0), 
                      child: Card(
                        child: DropdownButton<String>(
                          value: selectedValue1,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue1 = newValue!;
                            });
                          },
                          items: <String>[
                            'Lĩnh vực',
                            'Option b',
                            'Option C',
                            'Option D'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50.0, 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100.0), 
                      child: Card(
                        child: DropdownButton<String>(
                          value: selectedValue2,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue2 = newValue!;
                            });
                          },
                          items: <String>[
                            'Đánh giá',
                            'Option b',
                            'Option C',
                            'Option D'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // call api get all mentor
            // hard code first
            Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/male_avatar.jpg',
                      width: 48, 
                      height: 48,
                    ),
                    title: const Text('Trần Nhật Nghi'),
                    subtitle: Row(
                      children: const [
                        Text('Senior Front-end tại NashTech'),
                        Spacer(),
                        Text('Chi tiết', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllMentorsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1369B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Xem thêm mentor'),
            ),
          ],
        ),
      ),
    );
  }
}
