import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static String uri = 'pbl6-test-production.up.railway.app';
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

  static String formatDateString(String inputDateString) {
    DateTime dateTime = DateTime.parse(inputDateString);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDateString = dateFormat.format(dateTime);
    return formattedDateString;
  }

  static String result =
      '95% cố vấn sẽ xem rất kĩ Hồ sơ của bạn trước khi đồng ý lịch hẹn';
  static String result2 = 'Trong lúc chờ cố vấn xác nhận, hãy cập nhật và hoàn thiện hồ sơ của bản thân ngay nhé!';
}
