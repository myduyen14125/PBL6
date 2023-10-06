import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/homepage_screen.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String avatar,
    required String dateOfBirth,
    required String role,
  }) async {
    try {
      User user = User(
          firstName: firstName,
          lastName: lastName,
          avatar: avatar,
          email: email,
          password: password,
          dateOfBirth: dateOfBirth,
          gender: false,
          phone: phone,
          role: role,
          id: '',
          expiresIn: '',
          accessToken: '',
          refreshToken: '');

      http.Response res = await http.post(
          Uri.parse('http://10.0.2.2:5000/auth/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });

      print(res.statusCode);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: (() {
            showSnackBar(context, 'Success');
          }));

      print('success');
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  void signInUser({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(ctx, listen: false);
      final navigator = Navigator.of(ctx);
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:5000/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: ctx,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['accessToken']);

          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomepageScreen(),
            ),
            (route) => false,
          );
        },
      );
      print(res.body);
      print(res.statusCode);
    } catch (e) {
      print(e.toString());
      showSnackBar(ctx, e.toString());
    }
  }
}
