import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/transactions/transaction_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TransactionsListProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<TransactionClass> transactions = [];

  TransactionsListProvider(BuildContext context) {
    getTransactions();
  }

  getTransactions() async {
    try {
      setAwaiterVisibility(true);
      transactions = [];
      var response = await http.post(Api.transactionsList,
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
      for (var transactionJson in jsonResponse['data']) {
        transactions.add(TransactionClass(
          id: int.parse(transactionJson['id']),
          transactionDate: DateTime.parse(transactionJson['transaction_date']),
          categoryId: int.parse(transactionJson['category_id']),
          accountId: int.parse(transactionJson['account_id']),
          amount: double.parse(transactionJson['amount']),
          remark: transactionJson['remark'],
        ));
      }
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
