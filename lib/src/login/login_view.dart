import 'package:easyfinance/src/common/validators.dart';
import 'package:easyfinance/src/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
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
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'User ID'),
                  controller: loginProvider.userIdController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => Validators.isEmptyValidator(value),
                  decoration: const InputDecoration(hintText: 'Password'),
                  controller: loginProvider.passwordController,
                ),
              ),
              TextButton(
                  onPressed: () => loginProvider.login(context),
                  child: const Text('Login'))
            ],
          ),
        ),
        Visibility(
          visible: loginProvider.isAwaiterVisible,
          child: const Center(child: Text('Loading')),
        ),
      ]),
    );
  }
}
