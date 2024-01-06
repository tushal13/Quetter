import 'package:flutter/material.dart';

class ButtonController extends ChangeNotifier {
  bool isButtonPressed = false;

  void toggleButton(bool value) {
    isButtonPressed = value;
    notifyListeners();
  }
}
