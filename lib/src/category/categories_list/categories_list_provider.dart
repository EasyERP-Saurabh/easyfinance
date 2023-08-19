import 'package:easyfinance/src/category/category_class.dart';
import 'package:easyfinance/src/common/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CategoriesListProvider extends ChangeNotifier {
  bool isAwaiterVisible = false;

  List<CategoryClass> catagories = [];

  CategoriesListProvider(BuildContext context) {
    getCategories();
  }

  getCategories() async {
    try {
      setAwaiterVisibility(true);
      catagories = [];
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
        catagories.add(CategoryClass(
          id: int.parse(categoryJson['id']),
          description: categoryJson['description'],
          categoryType: categoryJson['category_type'],
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


/**
 * try {
      setAwaiterVisibility(true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setAwaiterVisibility(false);
    }
 */