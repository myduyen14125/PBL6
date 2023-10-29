import 'package:flutter/material.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String selectedValue1 = 'Lĩnh vực';
  String selectedValue2 = 'Giá tiền';
  String selectedValue3 = 'Đánh giá';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
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
                  borderRadius: BorderRadius.circular(100.0),
                  child: Card(
                    child: DropdownButton<String>(
                      value: selectedValue2,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue2 = newValue!;
                        });
                      },
                      items: <String>[
                        'Giá tiền',
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
                  borderRadius: BorderRadius.circular(100.0),
                  child: Card(
                    child: DropdownButton<String>(
                      value: selectedValue3,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue3 = newValue!;
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
          // call api get all course
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
                    'assets/course_icon/cplusplus_icon.png',
                    width: 48,
                    height: 48,
                  ),
                  title: const Text('Khoá học C++'),
                  subtitle: Row(
                    children: const [
                      Text('Giảng dạy bởi Nguyễn Trần\nMỹ Duyên'),
                      Spacer(),
                      Text('Chi tiết', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1369B2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text('Xem thêm khoá học'),
          ),
        ],
      ),
    );
  }
}
