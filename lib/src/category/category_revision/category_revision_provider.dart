import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:easyfinance/src/common/form_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CategoryRevisionProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  final categoryRevisionFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final descriptionController = TextEditingController();

  late FormMode formMode;

  CategoryType? categoryType;

  CategoryRevisionProvider(BuildContext context, {int? id}) {
    if (id == null) {
      formMode = FormMode.insert;
      categoryType = CategoryType.expenditure;
    } else {
      formMode = FormMode.update;
      idController.text = id.toString();
      getCategory(id);
    }
  }

  getCategory(int id) async {
    try {
      setAwaiterVisibility(true);
      var response = await http.post(Api.categoryRead,
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
      categoryType = getCategorytype(jsonResponse['data']['category_type']);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  insert(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (categoryType == null) throw Exception('Select Category Type');
      if (!categoryRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      var response = await http.post(Api.categoryInsert,
          headers: Api.headers,
          body: convert.jsonEncode({
            'description': descriptionController.text.trim(),
            'category_type': categoryType!.value,
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'category_revision',
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
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  update(BuildContext context) async {
    try {
      setAwaiterVisibility(true);
      if (categoryType == null) throw Exception('Select Category Type');
      if (!categoryRevisionFormKey.currentState!.validate()) {
        throw Exception('Invalid Input');
      }
      var response = await http.post(Api.categoryUpdate,
          headers: Api.headers,
          body: convert.jsonEncode({
            'id': idController.text,
            'description': descriptionController.text.trim(),
            'category_type': categoryType!.value,
            'user': 'user1',
            'datetime': '2023-08-19 11:14:30',
            'program_id': 'category_revision',
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
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
  }

  setCategoryType(CategoryType newCategoryType) {
    categoryType = newCategoryType;
    notifyListeners();
  }

  setAwaiterVisibility(bool newVisibility) {
    isAwaiterVisible = newVisibility;
    notifyListeners();
  }
}
