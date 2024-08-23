import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';

class category_pro with ChangeNotifier {
  bool categoriesIsLoading = false;
  List categoryName = [];
  List categoryCard = [];
  List categoryId = [];
  getShopCategoriesFunc(context) async {
    categoryName = [];
    categoryCard = [];
    categoryId = [];
    categoriesIsLoading = true;
    // notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(getCategoriesApi),
      );
      log("After succeffuly verified response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'].toString() == 'false') {
          List categoryData = resposne["category"];
          if (categoryData.isNotEmpty) {
            for (int i = 0; i < categoryData.length; i++) {
              final categoryIndex = categoryData[i];
              categoryName.add(categoryIndex["name"].toString());
              categoryCard.add(categoryIndex["card"].toString());
              categoryId.add(categoryIndex["category_id"].toString());
            }
          }

          log("categoryName: $categoryName");
          log("categoryId: $categoryId");
        }
      } else {
        showMyCustomSnackBar("Please Try again.", true, context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    categoriesIsLoading = false;
    notifyListeners();
  }

  bool subCategoriesIsLoading = false;
  List subCategoryName = [];
  List subCategoryCard = [];
  List subCategoryId = [];
  getShopSubCategoriesByIdFunc(String category_Id, context) async {
    subCategoryName = [];
    subCategoryCard = [];
    subCategoryId = [];
    subCategoriesIsLoading = true;

    try {
      final response =
          await http.get(Uri.parse(getSubCategoriesApi + category_Id));
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'].toString() == 'false') {
          List subCategoryData = resposne["subcategory"];
          if (subCategoryData.isNotEmpty) {
            for (int i = 0; i < subCategoryData.length; i++) {
              final categoryIndex = subCategoryData[i];
              subCategoryName.add(categoryIndex["name"].toString());
              subCategoryCard.add(categoryIndex["card"].toString());
              subCategoryId.add(categoryIndex["category_id"].toString());
            }
          }
        }
      } else {
        showMyCustomSnackBar("Please Try again.", true, context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    subCategoriesIsLoading = false;
    notifyListeners();
  }



}
