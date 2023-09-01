import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BudgetRevisionProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<CategoryClass> categories = [];
  List<AccountClass> accounts = [];

  final budgetRevisionFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final remarkController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final amountController = TextEditingController();
  CategoryClass? category;

  late FormMode formMode;

  BudgetRevisionProvider(BuildContext context, {int? id}) {
    listCategories();
    if (id == null) {
      formMode = FormMode.insert;
    } else {
      formMode = FormMode.update;
      idController.text = id.toString();
      readBudget(id);
    }
  }

  listCategories() async {
    try {
      //setAwaiterVisibility(true);
      categories = [];
      var response = await http.post(Api.categoriesList,
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
      for (var categoryJson in jsonResponse['data']) {
        categories.add(CategoryClass(
          id: int.parse(categoryJson['id']),
          description: categoryJson['description'],
          categoryType: categoryJson['category_type'],
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      //setAwaiterVisibility(false);
      notifyListeners();
    }
  }

  readBudget(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.budgetRead,
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

      debugPrint('${jsonResponse['message']} bg');
      idController.text = jsonResponse['data']['id'];
      monthController.text = jsonResponse['data']['budget_month'];
      yearController.text = jsonResponse['data']['budget_year'];
      category = CategoryClass(
          id: int.parse(jsonResponse['data']['category_id']),
          categoryType: jsonResponse['data']['category_type'],
          description: jsonResponse['data']['description']);
      remarkController.text = jsonResponse['data']['remark'];
      amountController.text = jsonResponse['data']['amount'];
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  insertBudget(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (!budgetRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      if (category == null) throw Exception('Invalid Category');

      var response = await http.post(Api.budgetInsert,
          headers: Api.headers,
          body: convert.jsonEncode({
            'budget_month': monthController.text,
            'budget_year': yearController.text,
            'category_id': category!.id,
            'amount': amountController.text.trim(),
            'remark': remarkController.text.trim(),
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'budget_revision',
            'machine_id': 'ipaddress',
          }));
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
      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  updateBudget(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (!budgetRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      if (category == null) throw Exception('Invalid Category');

      var response = await http.post(Api.budgetUpdate,
          headers: Api.headers,
          body: convert.jsonEncode({
            'id': idController.text,
            'budget_month': monthController.text,
            'budget_year': yearController.text,
            'category_id': category!.id,
            'amount': amountController.text.trim(),
            'remark': remarkController.text.trim(),
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'budget_revision',
            'machine_id': 'ipaddress',
          }));
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
      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  deleteBudget() async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.budgetDelete,
          headers: Api.headers,
          body: convert.jsonEncode({'id': idController.text}));
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

  setCategory(CategoryClass? category) {
    this.category = category;
    notifyListeners();
  }

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
