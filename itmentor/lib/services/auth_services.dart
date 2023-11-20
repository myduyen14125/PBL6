import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';
import 'package:itmentor/screens/splash_screen/splash_screen.dart';
import 'package:itmentor/screens/welcome_screen.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  String newToken = '';
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required bool gender,
    required String dateOfBirth,
    required String phone,
    required String avatar,
    required String role,
  }) async {
    try {
      User user = User(
        email: email,
        password: password,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        phone: phone,
        avatar: avatar,
        role: role,
        id: '',
        expiresIn: '',
        accessToken: '',
        refreshToken: '',
        facebookLink: '',
        skypeLink: '',
      );

      final uri = Uri.https(Constants.uri, '/auth/register');

      http.Response res = await http.post(uri,
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: (() {
            showSnackBar(context, 'Đăng ký thành công');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
              (route) => false,
            );
          }));
    } catch (e) {
      showSnackBar(context, 'Không thể đăng kí');
      print(e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(ctx, listen: false);
      final navigator = Navigator.of(ctx);

      final uri = Uri.https(Constants.uri, '/auth/login');

      http.Response res = await http.post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: ctx,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['accessToken']);
          await prefs.setString(
              'x-refresh', jsonDecode(res.body)['refreshToken']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomepageNavigationScreen(),
            ),
            (route) => false,
          );
        },
      );

      print(res.body);
    } catch (e) {
      print("login error : $e.toString()");
      showSnackBar(ctx, 'Sai tài khoản hoặc mật khẩu');
    }
  }

  Future<List<dynamic>> fetchMentors() async {
    final uri = Uri.https(Constants.uri, '/mentor');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> mentors = responseData['mentors'];
      return mentors;
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  Future<List<dynamic>> fetchBlogs(User user) async {
    List<dynamic> blogs = [];

    final uri = Uri.https(Constants.uri, '/blog');

    http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      blogs = json.decode(response.body)['blogs'];
      print(blogs);
      return blogs;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<bool> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print('token: $token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        return false;
      }
      if (token == '') {
        return false;
      }
      getNewToken();
      return true;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<void> getNewToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print('accessToken: $token');

      String? refreshToken = prefs.getString('x-refresh');
      print('refresh token: $refreshToken');

      final uri = Uri.https(Constants.uri, '/auth/refresh');
      http.Response res = await http.post(
        uri,
        body: jsonEncode({
          'refresh_token': refreshToken,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode == 201) {
        await prefs.setString(
            'x-auth-token', jsonDecode(res.body)['accessToken']);
        await prefs.setString(
            'x-refresh', jsonDecode(res.body)['refreshToken']);
        print('get new token success');
        print('new access token: ${prefs.getString('x-auth-token')}');
        print('new refresh token: ${prefs.getString('x-refresh')}');
      } else {
        print('error cannot get new token');
      }
    } catch (e) {
      print('error get new token');
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: ((context) => const SplashScreen()),
        ),
        (route) => false);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token != null || token != '') {
      return token;
    }
    return '';
  }

  Future<Map<String, dynamic>> fetchProfile(
      String token, BuildContext context) async {
    // String? activeToken = await getToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? activeToken = prefs.getString('x-auth-token');
    String? refreshToken = prefs.getString('x-refresh');

    final uri = Uri.https(Constants.uri, '/user/profile');
    final response = await http.get(uri, headers: <String, String>{
      'Connection': 'keep-alive',
      'Authorization': 'Bearer $activeToken',
    });

    print("active profile: $activeToken");
    print('refresh profile: $refreshToken');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = User.fromMap(data);
      Provider.of<UserProvider>(context, listen: false).updateUser(user);
      return data;
    } else {
      print('fetch profile failed: ${response.statusCode}');
      throw Exception('Failed to load profile');
    }
  }
}
