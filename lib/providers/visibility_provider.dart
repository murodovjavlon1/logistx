import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _isObscured = false;
  String? _errorText;
  String? get errorText => _errorText;

  bool get isObscured => _isObscured;

  void toggleVisibility() {
    _isObscured = !_isObscured;
    notifyListeners();
  }

  void validatePassword(String password) {
    if (password.length < 8) {
      _errorText = "The password must be at least 8 characters long.";
    } else {
      _errorText = null;
    }
    notifyListeners();
  }
}
