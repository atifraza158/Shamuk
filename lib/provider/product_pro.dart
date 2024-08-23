import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class products_pro with ChangeNotifier {
  bool productsIsLoading = false;
  List productName = [];
  List productUrl = [];
  List productCard = [];
  List productCategory = [];
  List productPrice = [];
  List productDiscount = [];

  getProducts(String keywords, String categoryId, String subCategoryId,
      String min, String max, String topRated, String sortBy, context) async {
    productName = [];
    productUrl = [];
    productCard = [];
    productCategory = [];
    productPrice = [];
    productDiscount = [];
    productsIsLoading = true;
    // notifyListeners();

    try {
      log("getProducts $categoryId");
      Map data = {
        'keywords': (keywords == "") ? '0' : keywords,
        'category_id': (categoryId == "") ? '0' : categoryId,
        'sub_category_id': (subCategoryId == "") ? '0' : subCategoryId,
        'min': (min == "") ? '0' : min,
        'max': (max == "") ? '0' : max,
        'top_rated': (topRated == "") ? '0' : topRated,
        'sort_by': (sortBy == "") ? '0' : sortBy,
      };
      final response = await http.post(Uri.parse(getProductsApi), body: data);
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        List subCategoryData = resposne["Product"];
        if (subCategoryData.isNotEmpty) {
          for (int i = 0; i < subCategoryData.length; i++) {
            final categoryIndex = subCategoryData[i];
            productName.add(categoryIndex["name"].toString());
            productUrl.add(categoryIndex["url"].toString());
            productCard.add(categoryIndex["card"].toString());
            productCategory.add(categoryIndex["category"].toString());
            productPrice.add(categoryIndex["price"].toString());
            productDiscount.add(categoryIndex["discount"].toString());
          }
        }
        log("productName: $productName");
      } else {
        log("No Products: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    productsIsLoading = false;
    notifyListeners();
  }

//sub category get func
  bool subcategoryProductsIsLoading = false;
  List subcategoryProductName = [];
  List subcategoryProductUrl = [];
  List subcategoryProductCard = [];
  List subcategoryProductCategory = [];
  List subcategoryProductPrice = [];
  List subcategoryProductDiscount = [];

  getSubCategoryProducts(
      String keywords,
      String categoryId,
      String subCategoryId,
      String min,
      String max,
      String topRated,
      String sortBy,
      context) async {
    subcategoryProductName = [];
    subcategoryProductUrl = [];
    subcategoryProductCard = [];
    subcategoryProductCategory = [];
    subcategoryProductPrice = [];
    subcategoryProductDiscount = [];

    subcategoryProductsIsLoading = false;
    // notifyListeners();

    try {
      log("getProducts $categoryId");
      Map data = {
        'keywords': (keywords == "") ? '0' : keywords,
        'category_id': (categoryId == "") ? '0' : categoryId,
        'sub_category_id': (subCategoryId == "") ? '0' : subCategoryId,
        'min': (min == "") ? '0' : min,
        'max': (max == "") ? '0' : max,
        'top_rated': (topRated == "") ? '0' : topRated,
        'sort_by': (sortBy == "") ? '0' : sortBy,
      };
      final response = await http.post(Uri.parse(getProductsApi), body: data);
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        List subCategoryData = resposne["Product"];
        if (subCategoryData.isNotEmpty) {
          for (int i = 0; i < subCategoryData.length; i++) {
            final categoryIndex = subCategoryData[i];

            subcategoryProductName.add(categoryIndex["name"].toString());
            subcategoryProductUrl.add(categoryIndex["url"].toString());
            subcategoryProductCard.add(categoryIndex["card"].toString());
            subcategoryProductCategory
                .add(categoryIndex["category"].toString());
            subcategoryProductPrice.add(categoryIndex["price"].toString());
            subcategoryProductDiscount
                .add(categoryIndex["discount"].toString());
          }
        }
        log("productName: $productName");
      } else {
        log("No Products: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    subcategoryProductsIsLoading = false;
    notifyListeners();
  }

  bool productDetailIsLoading = true;
  String dProductName = "";
  String dProductCategory = "";
  String dProductUrl = "";
  String dProductSubCategoryId = "";
  String dProductDiscount = "";
  String dProductPrice = "";
  //colors
  List dProductColors = [];
  //colors variables
  List dProductColorsName = [];
  List dProductColorsHex = [];

  //-------------------------
  String dProductRating = "";
  String dProductId = "";
  //sizes
  List dProductSize = [];

  //sizes variables
  List dProductSizesName = [];
  List dProductSizesStock = [];
  List dProductSizesSold = [];

  //---------------------------
  String dProductStock = "";
  String dProductDescription = "";
  List dProductImages = [];
  String dProductSpecification = "";
  //reviews
  List dProductReviewsUser = [];
  List dProductReviewsRating = [];
  List dProductReviewsDescrip = [];
  List dProductReviewsDate = [];
  //wishlist
  int dProductFavorite = 0;

  getProductDetails(String productUrl, context) async {
    counter = 1;
    dProductName = "";
    dProductCategory = "";
    dProductUrl = "";
    dProductSubCategoryId = "";
    dProductDiscount = "";
    dProductPrice = "";
    //colors
    dProductColors = [];
    //colors variables
    dProductColorsName = [];
    dProductColorsHex = [];
    //-----------
    dProductRating = "";
    dProductId = "";
    //sizes
    dProductSize = [];
    //sizes variables
    dProductSizesName = [];
    dProductSizesStock = [];
    dProductSizesSold = [];
    //-----------------------
    dProductStock = "";
    dProductDescription = "";
    dProductImages = [];
    dProductSpecification = "";
//reviews
    dProductReviewsUser = [];
    dProductReviewsRating = [];
    dProductReviewsDescrip = [];
    dProductReviewsDate = [];

//whishlist
    dProductFavorite = 0;
    productDetailIsLoading = true;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? user_id = prefs.getString('user_id');
      Map data = {
        'url': productUrl,
        'user_id': user_id??"0",
      };
      final response =
          await http.post(Uri.parse(getProductDetailApi), body: data);
      // log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //products
        if (resposne["Product"] != null) {
          List productDetailData = resposne["Product"];
          if (productDetailData.isNotEmpty) {
            var productData = resposne["Product"][0];
            log("productData: ${productData}");
            dProductName = productData["name"].toString();
            dProductCategory = productData["category"].toString();
            dProductUrl = productData["url"].toString();
            dProductSubCategoryId = productData["sub_category_id"].toString();
            dProductDiscount = productData["discount"].toString();
            dProductPrice = productData["price"].toString();
            //colors
            if (productData["colors"].toString() != "null") {
              dProductColors.add(productData["colors"].toString());
            }
            // log("dProductColors: $dProductColors");

            //decoding color array
            if (dProductColors.isNotEmpty) {
              List decodedeColors = [];
              decodedeColors = jsonDecode(dProductColors[0].toString());

              for (int i = 0; i < decodedeColors.length; i++) {
                dProductColorsName.add(decodedeColors[i]["name"].toString());
                dProductColorsHex.add(decodedeColors[i]["hex"].toString());
              }
            }
            //-----------------------------------------------------
            dProductRating = productData["rating"].toString();
            dProductId = productData["product_id"].toString();
            //size
            if (productData["size"].toString() != "null") {
              dProductSize.add(productData["size"].toString());
            }
            // log("dProductSize: $dProductSize");
            //decoding size array
            if (dProductSize.isNotEmpty) {
              List decodedeSizes = [];
              decodedeSizes = jsonDecode(dProductSize[0].toString());
              // log("decodedeSizes: $decodedeSizes");

              for (int i = 0; i < decodedeSizes.length; i++) {
                dProductSizesName.add(decodedeSizes[i]["size"].toString());
                dProductSizesStock.add(decodedeSizes[i]["stock"].toString());
                dProductSizesSold.add(decodedeSizes[i]["sold"].toString());
              }
            }
            //------------------------------------------------------
            dProductStock = productData["stock"].toString();
            dProductDescription = productData["description"].toString();
            //images
            if (productData["images"].toString() != "null") {
              dProductImages.add(productData["images"].toString());
            }
            dProductSpecification = productData["specification"].toString();

            log("imagesimagesimages: ${productData["images"].toString()}");
            // log("dProductPrice: $dProductPrice");
            // log("dProductColors: $dProductColors");
          }

          //reviews
          List productReviewsData = resposne["Reviews"];
          if (productReviewsData.isNotEmpty) {
            for (int i = 0; i < productReviewsData.length; i++) {
              final productReviewIndex = productReviewsData[i];
              dProductReviewsUser.add(productReviewIndex["user"].toString());
              dProductReviewsRating
                  .add(productReviewIndex["rating"].toString());
              dProductReviewsDescrip
                  .add(productReviewIndex["review"].toString());
              dProductReviewsDate.add(productReviewIndex["date"].toString());
            }
          }

//whishlist
          dProductFavorite = resposne["Wishlist"];
        }
      } else {
        log("No Data");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    productDetailIsLoading = false;
    notifyListeners();
  }

  addProductToWhislist(String productUrl, context) async {
    try {
      // dProductFavorite = 0;
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      log("Url: $productUrl ");
      log("user_id: $user_id ");
      Map data = {
        'user_id': user_id,
        'url': productUrl,
      };
      final response =
          await http.post(Uri.parse(addProductToWhishlistApi), body: data);
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        getProductDetails(productUrl, context);
        notifyListeners();
      } else {
        log("Request Failed Status Code: ${response.statusCode} ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    // productsIsLoading = false;
    notifyListeners();
  }

  int counter = 1;

  void incrementcounter() {
    counter++;

    notifyListeners();
  }

  void decrementcounter() {
    if (counter != 1) {
      counter--;
    }
    notifyListeners();
  }

  //give product rating
  bool productReviewIsLoading = false;
  void giveProductRatingFunc(
      String productUrl, double rating, String message, context) async {
    try {
      productReviewIsLoading = true;
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      log("rating: $rating");
      String convertedRating = rating.floor().toString();
      log("convertedRating: $convertedRating");

      Map data = {
        'user_id': user_id,
        'url': productUrl,
        'rating': convertedRating,
        'message': message,
      };
      final response = await http.post(Uri.parse(productReviewApi), body: data);
      log("Review response ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);

          getProductDetails(productUrl, context);
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode} ");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    productReviewIsLoading = false;
    notifyListeners();
  }
}
