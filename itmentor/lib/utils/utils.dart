import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 201:
      onSuccess();
      break;
    case 400:
      try {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'] as String;
        showSnackBar(context, message);
      } catch (e) {
        showSnackBar(context, 'Không thể đăng ký');
      }
      break;
    case 500:
      try {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'] as String;
        showSnackBar(context, message);
      } catch (e) {
        showSnackBar(context, 'Không thể đăng ký');
      }
      break;
    default:
      showSnackBar(context, response.body);
  }
}
