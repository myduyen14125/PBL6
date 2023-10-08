import 'package:flutter/material.dart';

class Constants {
  static String uri = 'http://10.0.2.2:3001';
  static const backgroundColor = LinearGradient(
    colors: [
      Color(0xFF18BEBC),
      Color(0x6618BEBC),
      Colors.white,
    ],
    stops: [0.0, 0.3, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
