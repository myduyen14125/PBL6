import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateSchedules extends StatefulWidget {
  const CreateSchedules({super.key});

  @override
  State<CreateSchedules> createState() => _CreateSchedulesState();
}

class _CreateSchedulesState extends State<CreateSchedules> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: 'Tiêu đề bài viết'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Nội dung'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Xử lý thông tin sau khi người dùng nhấn nút
                  // Thực hiện xử lý thông tin ở đây
                  print('Tên: title');
                  print('Email: content');

                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}