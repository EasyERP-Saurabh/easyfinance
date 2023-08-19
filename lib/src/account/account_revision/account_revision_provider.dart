import 'package:easyfinance/src/account/account_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AccountRevisionProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  final accountRevisionFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final descriptionController = TextEditingController();

  late FormMode formMode;

  AccountType? accountType;

  AccountRevisionProvider(BuildContext context, {int? id}) {
    if (id == null) {
      formMode = FormMode.insert;
      accountType = AccountType.bank;
    } else {
      formMode = FormMode.update;
      idController.text = id.toString();
      readAccount(id);
    }
  }

  readAccount(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.accountRead,
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
      idController.text = jsonResponse['data']['id'];
      descriptionController.text = jsonResponse['data']['description'];
      accountType = getAccountType(jsonResponse['data']['account_type']);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  insertAccount(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (accountType == null) throw Exception('Select Account Type');
      if (!accountRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      var response = await http.post(Api.accountInsert,
          headers: Api.headers,
          body: convert.jsonEncode({
            'description': descriptionController.text.trim(),
            'account_type': accountType!.value,
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'account_revision',
            'machine_id': 'ipaddress'
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

  updateAccount(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (accountType == null) throw Exception('Select Account Type');
      if (!accountRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      var response = await http.post(Api.accountUpdate,
          headers: Api.headers,
          body: convert.jsonEncode({
            'id': idController.text,
            'description': descriptionController.text.trim(),
            'account_type': accountType!.value,
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'account_revision',
            'machine_id': 'ipaddress'
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

  deleteAccount() async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.accountDelete,
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

  setAccountType(AccountType newAccountType) {
    accountType = newAccountType;
    notifyListeners();
  }

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
