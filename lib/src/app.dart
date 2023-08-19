import 'package:easyfinance/src/category/categories_list/categories_list_provider.dart';
import 'package:easyfinance/src/category/categories_list/categories_list_view.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_provider.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_view.dart';
import 'package:easyfinance/src/home/home_provider.dart';
import 'package:easyfinance/src/home/home_view.dart';
import 'package:easyfinance/src/login/login_provider.dart';
import 'package:easyfinance/src/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppDay1 extends StatelessWidget {
  const MyAppDay1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case HomeView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => HomeProvider(),
                    child: const HomeView());
              case CategoriesListView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => CategoriesListProvider(context),
                    child: const CategoriesListView());
              case CategoryRevisionView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => CategoryRevisionProvider(context,
                        id: routeSettings.arguments as int?),
                    child: const CategoryRevisionView());
              case LoginView.routeName:
              default:
                return ChangeNotifierProvider(
                    create: (context) => LoginProvider(),
                    child: const LoginView());
            }
          },
        );
      },
    );
  }
}
