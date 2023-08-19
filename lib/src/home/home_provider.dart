import 'package:easyfinance/src/home/home_class.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;
  List<Home> homeMenus = [
    Home('Categories', Icons.category),
    Home('Accounts', Icons.account_balance),
    Home('Transactions', Icons.sync_alt),
  ];

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
