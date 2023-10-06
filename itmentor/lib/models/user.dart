// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String firstName;
  String lastName;
  String avatar;
  String email;
  String password;
  String dateOfBirth;
  bool gender;
  String phone;
  String role;
  String id;
  String expiresIn;
  String accessToken;
  String refreshToken;

  User({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.role,
    required this.id,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'email': email,
      'password': password,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone': phone,
      'role': role,
      'expiresIn': expiresIn,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatar: map['avatar'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      id: map['_id'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
