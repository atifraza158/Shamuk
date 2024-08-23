import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/utils/custom_loading_dialog.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/add_to_cart_widget.dart';
import 'package:multivendor/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart_pro with ChangeNotifier {
  bool productIsBeingAdded = false;
  productAddToCart(
      String url, String qty, String size, String color, context) async {
    try {
      log("qty $qty");
      log("size $size");
      log("color $color");
      productIsBeingAdded = true;
      notifyListeners();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('user_id');
      final String? cityId = prefs.getString('city_id');

      Map data = {
        'url': url,
        'qty': qty,
        'size': size,
        'color': color,
        'user_id': userId,
        'city_id': cityId,
      };
      final response =
          await http.post(Uri.parse(productAddToCartApi), body: data);

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponsne = jsonDecode(response.body);
        log("resposne: $decodedResponsne");
        if (decodedResponsne['error'].toString() == 'false') {
          showMyCustomSnackBar(
              decodedResponsne['message'].toString(), false, context);
          addToCartDialogWidget(context);
          getCartProducts(context, 0);
        } else {
          showMyCustomSnackBar(
              decodedResponsne['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode}.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }
    productIsBeingAdded = false;

    notifyListeners();
  }

  bool cartProductLoading = false;
  List cProductName = [];
  List cProductPrice = [];
  List cProductUrl = [];
  List cProductDiscount = [];
  List cProductQuantity = [];
  //size
  List cProductSizes = [];
  List cProductSelectedSizes = [];
  //colors
  List cProductColors = [];
  List cProductSelectedColors = [];
  List cProductCode = [];
  List cProductCard = [];
  List cProductStock = [];
  //total
  List cProductTotal = [];
//overall
  int overallAllCartProductTotal = 0;
  //shipment
  int overallAllCartProductShipment = 0;

//total+shipment
  int totalPlusShipmentOverallValue = 0;
  bool totalIsloading = false;
  getCartProducts(context, int type) async {
    try {
      if (type == 0) {
        cProductName = [];
        cProductPrice = [];
        cProductUrl = [];
        cProductDiscount = [];
        cProductQuantity = [];
        //size
        cProductSizes = [];
        cProductSelectedSizes = [];
        //colors
        cProductColors = [];
        cProductSelectedColors = [];
        cProductCode = [];
        cProductCard = [];
        cProductStock = [];

//total
        cProductTotal = [];
        overallAllCartProductTotal = 0;
        overallAllCartProductShipment = 0;
        totalPlusShipmentOverallValue = 0;
        cartProductLoading = true;
      } else {
        totalIsloading = true;
      }
      // notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? userId = prefs.getString('user_id');
      Map data = {
        'user_id': userId,
      };
      final response =
          await http.post(Uri.parse(getCartProductsApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        // log("decodedResponse: $decodedResponse");

        //Cart products
        if (type == 0) {
          List cartProductData = decodedResponse["cart"];
          // log("cartProductData: $cartProductData");

          if (cartProductData.isNotEmpty) {
            for (int i = 0; i < cartProductData.length; i++) {
              final cartProductIndex = cartProductData[i];
              cProductName.add(cartProductIndex["name"].toString());
              cProductPrice.add(cartProductIndex["price"].toString());
              cProductUrl.add(cartProductIndex["url"].toString());
              cProductDiscount.add(cartProductIndex["discount"].toString());
              cProductQuantity.add(cartProductIndex["qty"].toString());
              //size
              if (cartProductIndex["size"].toString() != "null") {
                cProductSizes.add(cartProductIndex["size"].toString());
              } else {
                cProductSizes.add("");
              }
              //cProductSelectedSizes
              if (cartProductIndex["selected_size"].toString() != "null") {
                cProductSelectedSizes
                    .add(cartProductIndex["selected_size"].toString());
              } else {
                cProductSelectedSizes.add("");
              }
              //cProductColors
              if (cartProductIndex["colors"].toString() != "null") {
                cProductColors.add(cartProductIndex["colors"].toString());
              } else {
                cProductColors.add("");
              }
              //cProductSelectedColors
              if (cartProductIndex["selected_color"].toString() != "null") {
                cProductSelectedColors
                    .add(cartProductIndex["selected_color"].toString());
              } else {
                cProductSelectedColors.add("");
              }
              cProductCode.add(cartProductIndex["code"].toString());
              cProductCard.add(cartProductIndex["card"].toString());
              cProductStock.add(cartProductIndex["stock"].toString());
              cProductTotal.add(cartProductIndex["total"].toString());
            }
            log("cProductStock=> ${cProductStock}");
          }
          // log("cProductTotal: $overallAllCartProductTotal");
          overallAllCartProductShipment =
              int.parse(decodedResponse["Shipment"].toString());
          // log("overallAllCartProductShipment: $overallAllCartProductShipment");
          //totalPlusShipmentOverallValue
          totalPlusShipmentOverallValue =
              overallAllCartProductTotal + overallAllCartProductShipment;
        }

        //
        overallAllCartProductTotal =
            int.parse(decodedResponse["Total"].toString());
      } else {
        log("No Data");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }
    totalIsloading = false;
    cartProductLoading = false;
    notifyListeners();
  }

  removeProductFromCart(String productCode, context) async {
    try {
      Map data = {
        'code': productCode,
      };
      final response =
          await http.post(Uri.parse(removeProductFromCartApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");
        if (decodedResponse['error'].toString() == 'false') {
          showMyCustomSnackBar(
              decodedResponse['message'].toString(), false, context);

          getCartProducts(context, 0);
          // applyCouponFunc(0, "", context);
          Navigator.pop(context);

          notifyListeners();
        } else {
          showMyCustomSnackBar(
              decodedResponse['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode}.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }
    notifyListeners();
  }

  //tapping stop
  int ontapIncreamentDecrement = 0;
  updateCartProductQuantity(
      String productCode, String quantity, context) async {
    try {
      ontapIncreamentDecrement = 1;
      notifyListeners();
      Map data = {
        'code': productCode,
        'qty': quantity,
      };
      final response =
          await http.post(Uri.parse(updateCartProductQuantityApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);

        if (decodedResponse['error'].toString() == 'false') {
          getCartProducts(context, 1);

          notifyListeners();
        } else {
          showMyCustomSnackBar(
              decodedResponse['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode}.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    ontapIncreamentDecrement = 0;
    notifyListeners();
  }

  //check coupon
  int couponDiscountValue = 0;
  double couponSaveValue = 0;
  applyCouponFunc(int productTotal, String couponCode, context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('appliedCoupon', couponCode);
      final String? appliedCouponCode = prefs.getString('appliedCoupon');
      log("appliedCouponCode: $appliedCouponCode ");
      couponDiscountValue = 0;
      couponSaveValue = 0;
      notifyListeners();
      Map data = {
        'coupon': appliedCouponCode,
      };
      final response = await http.post(Uri.parse(applyCouponApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");

        List couponArray = decodedResponse['coupon'];
        if (couponArray.isEmpty) {
          showMyCustomSnackBar("Coupon is not Valid", false, context);

          log("Coupon is empty");
        } else {
          showMyCustomSnackBar("Coupon is Valid", false, context);
          couponDiscountValue =
              int.parse(decodedResponse['coupon'][0]['discount'].toString());
          log("Coupon ${decodedResponse['coupon'][0]['discount']}");
          couponSaveValue = (productTotal / 100) *
              int.parse(decodedResponse['coupon'][0]['discount'].toString());
          log("couponSaveValue $couponSaveValue");
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode}.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }
    notifyListeners();
  }

//update Shipments details
  updateShipmentDetails(String countryId, String stateId, String cityId,
      String address, context) async {
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('country_id', countryId);
      await prefs.setString('state_id', stateId);
      await prefs.setString('city_id', cityId);
      await prefs.setString('address', address);
      getShipmentDetailsFunc(context);
      // getCartProducts(context, 0);
    } catch (e) {
      showMyCustomSnackBar("Catch Execption $e.", true, context);
    }
    Navigator.pop(context);
    notifyListeners();
  }

//shipment details
  String shipmentCountry = "";
  String shipmentState = "";
  String shipmentCity = "";
  String shipmentAddress = "";
  bool shipmentDetailsIsLoading = false;

  getShipmentDetailsFunc(BuildContext context) async {
    shipmentCountry = "";
    shipmentState = "";
    shipmentCity = "";
    shipmentAddress = "";

    shipmentDetailsIsLoading = true;
    // notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? userId = prefs.getString('user_id');
      final String? countryId = prefs.getString('country_id');
      final String? stateId = prefs.getString('state_id');
      final String? cityId = prefs.getString('city_id');
      final String? address = prefs.getString('address');
      Map data = {
        'user_id': userId,
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
      };
      final response =
          await http.post(Uri.parse(getShipmentDetailsApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");

        if (decodedResponse['error'].toString() == 'false') {
          shipmentCountry = decodedResponse["Country"].toString();
          shipmentState = decodedResponse["State"].toString();
          shipmentCity = decodedResponse["City"].toString();
          shipmentAddress = address.toString();
        }
      } else {
        log("Please Try again.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    shipmentDetailsIsLoading = false;
    notifyListeners();
  }

  //checkout
  bool checkoutIsLoading = false;

  checkoutfunc(String name, String email, String phone, String note,
      BuildContext context) async {
    try {
      checkoutIsLoading = true;
      show_loading_dialog(context);
      notifyListeners();

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? appliedCouponCode = prefs.getString('appliedCoupon');
      log("appliedCouponCode: $appliedCouponCode ");
      final String? userId = prefs.getString('user_id');
      final String? countryId = prefs.getString('country_id');
      final String? stateId = prefs.getString('state_id');
      final String? cityId = prefs.getString('city_id');
      final String? address = prefs.getString('address');
      log("Coupon: ${(appliedCouponCode.toString() != "null") ? appliedCouponCode : "0"}");
      Map data = {
        'user_id': userId,
        'coupon':
            (appliedCouponCode.toString() != "null") ? appliedCouponCode : "0",
        'name': name,
        'email': email,
        'phone': phone,
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
        'address': address,
        'note': note,
      };
      final response = await http.post(Uri.parse(checkoutApi), body: data);
      log("response.body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");
        if (decodedResponse['error'].toString() == 'false') {
          //clearing the coupon variables
          prefs.remove("appliedCoupon");
          couponDiscountValue = 0;
          couponSaveValue = 0;
          //
          getCartProducts(context, 0);
          Navigator.pop(context);
          // RouteNavigator.replacementroute(context, NavBar(selectedTab: 1));
          snackBar(context, "Order Place Successfully");
          context.replaceNamed('bottomNavBar', queryParams: {
            'selectedTab': '0',
          });

          notifyListeners();
        } else {
          showMyCustomSnackBar(
              decodedResponse['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode}.");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
      Navigator.pop(context);
    }
    checkoutIsLoading = false;
    notifyListeners();
  }
}
