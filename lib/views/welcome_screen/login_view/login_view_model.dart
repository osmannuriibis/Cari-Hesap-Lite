import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isPassVisible = false;
  set isPassVisible(bool value) {
    _isPassVisible = value;
    notifyListeners();
  }

  bool get isPassVisible => _isPassVisible;
}
