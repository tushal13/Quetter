import 'package:flutter/material.dart';

class IndexController extends ChangeNotifier {
  int index = 0;

  setIndex({required int val}) {
    index = val;
  }
}
