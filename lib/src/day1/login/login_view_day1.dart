import 'package:easyfinance/src/day1/login/login_provider_day1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewDay1 extends StatelessWidget {
  const LoginViewDay1({super.key});

  static const routeName = '/login_day1';

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProviderDay1>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Stack(children: [
        Form(
          key: loginProvider.loginFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: loginProvider.userIdController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: loginProvider.passwordController,
                ),
              ),
              TextButton(
                  onPressed: () {
                    loginProvider.login();
                  },
                  child: const Text('Login'))
            ],
          ),
        )
      ]),
    );
  }
}
