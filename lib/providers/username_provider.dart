import 'package:flutter/material.dart';


class UsernameProvider extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }
}