import 'package:flutter/material.dart';

class NightStateStepperProvider extends ChangeNotifier {
  int _step = 0;

  int get step => _step;

  void setUsername(int value) {
    _step = value;
    notifyListeners();
  }
}
