import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _userEmail = '';
  String _userRefEmp = '';

  void setUser(String name, String email, String refEmp) {
    _userName = name;
    _userEmail = email;
    _userRefEmp = refEmp;
    notifyListeners();
  }

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userRefEmp => _userRefEmp;
}
