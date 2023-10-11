import 'dart:convert';

import 'package:itmentor/models/user.dart';

class Blog {
  String id;
  String title;
  String content;
  User user;
  String createdAt;
  String updatedAt;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'user': user,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    User user = User.fromMap(map['user'] as Map<String, dynamic>);
    return Blog(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      user: user,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) =>
      Blog.fromMap(json.decode(source) as Map<String, dynamic>);
}
