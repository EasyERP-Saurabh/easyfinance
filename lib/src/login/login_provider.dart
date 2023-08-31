import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginProvider extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  bool isAwaiterVisible = false;
  bool isPasswordVisible = false;

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  login(BuildContext context) async {
    try {
      userIdController.text = 'user1';
      passwordController.text = '1234';
      if (!loginFormKey.currentState!.validate()) {
        throw Exception('Invalid Values');
      }
      setAwaiterVisibility(true);
      var response = await http.post(Api.login,
          headers: Api.headers,
          body: convert.jsonEncode({
            'username': userIdController.text.trim(),
            'password': passwordController.text.trim()
          }));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      var jsonResponse = convert.jsonDecode(response.body);

      if (!jsonResponse['success']) {
        throw Exception('Request Failed: ${jsonResponse['message']}');
      }

      if (jsonResponse['code'] != 1) {
        throw Exception(
            'Error Code ${jsonResponse['code']}: ${jsonResponse['message']}');
      }

      debugPrint(jsonResponse['message']);

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }
}
