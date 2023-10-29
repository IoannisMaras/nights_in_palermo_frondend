import 'package:flutter/material.dart';
import 'package:nights_in_palermo/providers/websocket_notifier.dart';

class NightStateStepperProvider extends ChangeNotifier {
  int _step = 0;
  int _votedIndex = 0;

  int get step => _step;
  int get votedIndex => _votedIndex;

  void setStep(int value) {
    _step = value;
    notifyListeners();
  }

  void resetStep() {
    _step = 0;
    notifyListeners();
  }

  void nextStep(GameState game, int? index) {
    if (_step == 0) {
      _step = 1;
    } else if (_step == 1) {
      bool hasDoctor = false;
      for (Player player in game.players) {
        if (player.role == 'doctor') {
          hasDoctor = true;
          break;
        }
      }
      if (hasDoctor) {
        _step = 2;
      } else {
        if (index != null) {
          _votedIndex = index;
        }
        _step = 3;
      }
    } else if (_step == 2) {
      if (index != null) {
        _votedIndex = index;
      }
      _step = 3;
    }
    notifyListeners();
  }
}
