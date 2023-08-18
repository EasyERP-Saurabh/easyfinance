import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

class LoginProviderDay1 extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  bool isAwaiterVisible = false;
  bool isPasswordVisible = false;

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }

  login() async {}
}
