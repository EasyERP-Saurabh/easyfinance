import 'package:easyfinance/src/day1/login/login_provider_day1.dart';
import 'package:easyfinance/src/day1/login/login_view_day1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppDay1 extends StatelessWidget {
  const MyAppDay1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case LoginViewDay1.routeName:
              default:
                return ChangeNotifierProvider(
                    create: (context) => LoginProviderDay1(),
                    child: const LoginViewDay1());
            }
          },
        );
      },
    );
  }
}
