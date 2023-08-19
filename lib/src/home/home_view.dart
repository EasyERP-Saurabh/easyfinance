import 'package:easyfinance/src/account/accounts_list/accounts_list_view.dart';
import 'package:easyfinance/src/category/categories_list/categories_list_view.dart';
import 'package:easyfinance/src/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: homeProvider.homeMenus.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, CategoriesListView.routeName);
                case 1:
                  Navigator.pushNamed(context, AccountsListView.routeName);
                case 2:
                // Navigator.pushNamed(context, TransactionsListView.routeName);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  homeProvider.homeMenus[index].icon,
                  size: 50,
                ),
                Text(
                  homeProvider.homeMenus[index].description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
