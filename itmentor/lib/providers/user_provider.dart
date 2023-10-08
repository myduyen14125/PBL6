import 'package:flutter/cupertino.dart';
import 'package:itmentor/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    email: '',
    password: '',
    name: '',
    gender: false,
    dateOfBirth: '',
    phone: '',
    avatar: '',
    role: '',
    id: '',
    expiresIn: '',
    accessToken: '',
    refreshToken: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
