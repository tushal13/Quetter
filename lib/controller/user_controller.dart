import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  late bool isPasswordVisible;
  UserController() {
    isPasswordVisible = false;
  }
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
