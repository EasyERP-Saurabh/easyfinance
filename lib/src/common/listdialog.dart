import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:flutter/material.dart';

class ListDialog {
  static AlertDialog getCategoryListDialog(context, List<CategoryClass> list) =>
      AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].description),
                      onTap: () =>
                          Navigator.of(context).pop<CategoryClass>(list[index]),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(null)),
          ]);

  static AlertDialog getAccountListDialog(context, List<AccountClass> list) =>
      AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].description),
                      onTap: () =>
                          Navigator.of(context).pop<AccountClass>(list[index]),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(null)),
          ]);
}
