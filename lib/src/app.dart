import 'package:easyfinance/src/account/account_revision/account_revision_provider.dart';
import 'package:easyfinance/src/account/account_revision/account_revision_view.dart';
import 'package:easyfinance/src/account/accounts_list/accounts_list_provider.dart';
import 'package:easyfinance/src/account/accounts_list/accounts_list_view.dart';
import 'package:easyfinance/src/category/categories_list/categories_list_provider.dart';
import 'package:easyfinance/src/category/categories_list/categories_list_view.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_provider.dart';
import 'package:easyfinance/src/category/category_revision/category_revision_view.dart';
//ksutar 22/aug: added transaction
import 'package:easyfinance/src/transactions/transactions_list/transactions_list_provider.dart';
import 'package:easyfinance/src/transactions/transactions_list/transactions_list_view.dart';
import 'package:easyfinance/src/transactions/transaction_revision/transaction_revision_provider.dart';
import 'package:easyfinance/src/transactions/transaction_revision/transaction_revision_view.dart';
//
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
              //Category
              case CategoriesListView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => CategoriesListProvider(context),
                    child: const CategoriesListView());
              case CategoryRevisionView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => CategoryRevisionProvider(context,
                        id: routeSettings.arguments as int?),
                    child: const CategoryRevisionView());
              //Account
              case AccountsListView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => AccountsListProvider(context),
                    child: const AccountsListView());
              case AccountRevisionView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => AccountRevisionProvider(context,
                        id: routeSettings.arguments as int?),
                    child: const AccountRevisionView());
              //Transaction
              case TransactionsListView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => TransactionsListProvider(context),
                    child: const TransactionsListView());
              case TransactionRevisionView.routeName:
                return ChangeNotifierProvider(
                    create: (context) => TransactionRevisionProvider(context,
                        id: routeSettings.arguments as int?),
                    child: const TransactionRevisionView());
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
