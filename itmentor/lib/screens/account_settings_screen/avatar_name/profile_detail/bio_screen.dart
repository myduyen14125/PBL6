import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';

class BioScreen extends StatefulWidget {
  final String token;
  const BioScreen({super.key, required this.token});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Kinh nghiệm làm việc',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'Chief Technology Officer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Mentori\n09/2019 - Hiện tại'),
              onTap: () {},
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Học vấn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'Trường Đại học Khoa học Tự nhiên - Đại học Quốc gia Hà Nội',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Công nghệ phần mềm\n09/2018 - 12/2021'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'Trường Đại học Ngoại Thương',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Tài chính quốc tế\n08/2013 - 06/2017'),
              onTap: () {},
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Hoạt động ngoại khoá',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'Data Hat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Founder và Giảng viên\n08/2019 - 12/2020'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'MOS Excel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Giảng viên\n08/2016 - 02/2017'),
              onTap: () {},
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Kỹ năng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text(
                'Python',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Giảng viên\n08/2016 - 02/2017'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
