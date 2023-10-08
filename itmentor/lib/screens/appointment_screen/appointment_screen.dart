import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = LinearGradient(
      colors: [
        Color(0xFF18BEBC),
        Color(0x6618BEBC),
        Colors.white,
      ],
      stops: [0.0, 0.3, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text('Đặt lịch', style: TextStyle(color: Colors.black, fontSize: 20),)
        ]),
      ),
    );
  }
}
