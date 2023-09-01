import 'package:easyfinance/src/budget/budget_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BudgetListProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<BudgetClass> budgets = [];

  BudgetListProvider(BuildContext context) {
    getBudgets();
  }

  getBudgets() async {
    try {
      setAwaiterVisibility(true);
      budgets = [];
      var response = await http.post(Api.budgetList,
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
        budgets.add(BudgetClass(
          id: int.parse(transactionJson['id']),
          budgetMonth: int.parse(transactionJson['budget_month']),
          budgetYear: int.parse(transactionJson['budget_year']),
          categoryId: int.parse(transactionJson['category_id']),
          categoryDescription: transactionJson['description'],
          categoryType: transactionJson['category_type'],
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

  deleteBudget(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.budgetDelete,
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
