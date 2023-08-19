import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AccountsListProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<AccountClass> accounts = [];

  AccountsListProvider(BuildContext context) {
    getAccounts();
  }

  getAccounts() async {
    try {
      setAwaiterVisibility(true);
      accounts = [];
      var response = await http.post(Api.accountsList,
          headers: Api.headers, body: convert.jsonEncode({}));
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
      for (var accountJson in jsonResponse['data']) {
        accounts.add(AccountClass(
          id: int.parse(accountJson['id']),
          description: accountJson['description'],
          accountType: accountJson['account_type'],
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  deleteAccount(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.accountDelete,
          headers: Api.headers, body: convert.jsonEncode({'id': id}));
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
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
