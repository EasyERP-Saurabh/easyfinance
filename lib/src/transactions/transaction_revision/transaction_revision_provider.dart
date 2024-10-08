import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

class TransactionRevisionProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<CategoryClass> categories = [];
  List<AccountClass> accounts = [];

  final transactionRevisionFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final remarkController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  CategoryClass? category;
  AccountClass? account;

  late FormMode formMode;

  TransactionRevisionProvider(BuildContext context, {int? id}) {
    listCategories();
    listAccounts();
    if (id == null) {
      formMode = FormMode.insert;
    } else {
      formMode = FormMode.update;
      idController.text = id.toString();
      readTransaction(id);
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

  listAccounts() async {
    try {
      //setAwaiterVisibility(true);
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
      //setAwaiterVisibility(false);
      notifyListeners();
    }
  }

  readTransaction(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.transactionRead,
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

      debugPrint('${jsonResponse['message']} tr');
      idController.text = jsonResponse['data']['id'];
      category = CategoryClass(
          id: int.parse(jsonResponse['data']['category_id']),
          categoryType: jsonResponse['data']['category_type'],
          description: jsonResponse['data']['category_description']);
      account = AccountClass(
          id: int.parse(jsonResponse['data']['account_id']),
          accountType: jsonResponse['data']['account_type'],
          description: jsonResponse['data']['account_description']);
      remarkController.text = jsonResponse['data']['remark'];
      amountController.text = jsonResponse['data']['amount'];
      dateController.text = DateFormat('yyyy-M-dd')
          .format(DateTime.parse(jsonResponse['data']['transaction_date']));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  insertTransaction(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (!transactionRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      if (category == null) throw Exception('Invalid Category');
      if (account == null) throw Exception('Invalid Account');

      var response = await http.post(Api.transactionInsert,
          headers: Api.headers,
          body: convert.jsonEncode({
            'transaction_date': DateFormat('yyyy-M-dd')
                .format(DateTime.parse(dateController.text)),
            'category_id': category!.id,
            'account_id': account!.id,
            'amount': amountController.text.trim(),
            'remark': remarkController.text.trim(),
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'transaction_revision',
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

  updateTransaction(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (!transactionRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      if (category == null) throw Exception('Invalid Category');
      if (account == null) throw Exception('Invalid Account');

      var response = await http.post(Api.transactionUpdate,
          headers: Api.headers,
          body: convert.jsonEncode({
            'id': idController.text,
            'transaction_date': DateFormat('yyyy-M-dd')
                .format(DateTime.parse(dateController.text)),
            'category_id': category!.id,
            'account_id': account!.id,
            'amount': amountController.text.trim(),
            'remark': remarkController.text.trim(),
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'transaction_revision',
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

  deleteTransaction() async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.transactionDelete,
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

  showDateHelper(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(9999));
    if (selectedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    } else {
      dateController.clear();
    }
  }

  setCategory(CategoryClass? category) {
    this.category = category;
    notifyListeners();
  }

  setAccount(AccountClass? account) {
    this.account = account;
    notifyListeners();
  }

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
