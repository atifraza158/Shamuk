import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class order_pro with ChangeNotifier {
  bool ordersListIsLoading = false;
  List orderName = [];
  List orderEmail = [];
  List orderPhone = [];
  List orderStatus = [];
  List orderCode = [];
  List orderDate = [];
  List orderTime = [];

  getOrdersListFunc(context) async {
    try {
    orderName = [];
    orderEmail = [];
    orderPhone = [];
    orderStatus = [];
    orderCode = [];
    orderDate = [];
    orderTime = [];
    ordersListIsLoading = true;
    // notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('user_id');
      Map data = {
        'user_id': userId,
      };
      final response =
          await http.post(Uri.parse(getOrderListingApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");

        //Order List
        List ordersListData = decodedResponse["Order"];
        log("ordersListData: $ordersListData");

        if (ordersListData.isNotEmpty) {
          for (int i = 0; i < ordersListData.length; i++) {
            final orderIndex = ordersListData[i];

            orderName.add(orderIndex["name"].toString());
            orderEmail.add(orderIndex["email"].toString());
            orderPhone.add(orderIndex["phone"].toString());
            orderStatus.add(orderIndex["status"].toString());
            orderCode.add(orderIndex["code"].toString());
            orderDate.add(orderIndex["date"].toString());
            orderTime.add(orderIndex["time"].toString());
          }
        }
      } else {
        log("No Data");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    ordersListIsLoading = false;
    notifyListeners();
  }

  clearProductSummaryVariablesFunc() {
    dorderName = "";
    dorderEmail = "";
    dorderPhone = "";
    dorderOrderId = "";

    dorderStatus = "";
    dorderDate = "";
    dorderTime = "";
    dorderNote = "";
    dorderCode = "";
    dorderCountry = "";
    dorderState = "";
    dorderCity = "";
    dorderAddress = "";
    dorderCoupon = "";
    dorderShipment = "";
    dorderTotal = "";
    dorderSave = "";
    //cart product list
    // dOrderCartProductList = [];
    dCartShipment = [];
    dCartCharges = [];
    dCartQty = [];
    dCartDiscount = [];
    dCartPrice = [];
    dCartName = [];
    dCartCard = [];
    dCartColor = [];
    dCartSize = [];
    dCartStock = [];
    dCartStatus = [];
    dCartCode = [];
    dCartUrl = [];
  }

  ///order details
  bool orderDetailIsLoading = false;
  String dorderName = "";
  String dorderEmail = "";
  String dorderPhone = "";
  String dorderOrderId = "";
  String dorderStatus = "";
  String dorderDate = "";
  String dorderTime = "";
  String dorderNote = "";
  String dorderCode = "";
  String dorderCountry = "";
  String dorderState = "";
  String dorderCity = "";
  String dorderAddress = "";
  String dorderCoupon = "";
  String dorderShipment = "";
  String dorderTotal = "";
  String dorderSave = "";
  //cart product list
  // List dOrderCartProductList = [];
  List dCartShipment = [];
  List dCartCharges = [];
  List dCartQty = [];
  List dCartDiscount = [];
  List dCartPrice = [];
  List dCartName = [];
  List dCartCard = [];
  List dCartColor = [];
  List dCartSize = [];
  List dCartStock = [];
  List dCartStatus = [];
  List dCartCode = [];
  List dCartUrl = [];

  getOrderDetailSummaryFunc(String orderCode, context) async {
    clearProductSummaryVariablesFunc();
    // orderDetailIsLoading = true;
    // notifyListeners();
    try {
      Map data = {
        'code': orderCode,
      };
      final response =
          await http.post(Uri.parse(getOrderDetailApi), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        log("decodedResponse: $decodedResponse");

        // Order Summary
        Map<String, dynamic> ordersListData = decodedResponse["order"];
        if (ordersListData.isNotEmpty) {
          dorderName = ordersListData["name"].toString();
          dorderEmail = ordersListData["email"].toString();
          dorderPhone = ordersListData["phone"].toString();
          dorderOrderId = ordersListData["order_id"].toString();
          dorderStatus = ordersListData["status"].toString();
          dorderDate = ordersListData["date"].toString();
          dorderTime = ordersListData["time"].toString();
          dorderNote = ordersListData["note"].toString();
          dorderCode = ordersListData["code"].toString();
          dorderCountry = ordersListData["country"].toString();
          dorderState = ordersListData["state"].toString();
          dorderCity = ordersListData["city"].toString();
          dorderAddress = ordersListData["address"].toString();
          dorderCoupon = ordersListData["coupon"].toString();
        }
          dorderShipment = decodedResponse["Shipment"].toString();
        
          dorderTotal = decodedResponse["Total"].toString();
        
        dorderSave = decodedResponse["Save"].toString();

        //Cart Product List
        List cartProductsData = decodedResponse["Cart"];
        if (cartProductsData.isNotEmpty) {
          for (int i = 0; i < cartProductsData.length; i++) {
            final cartIndex = cartProductsData[i];

            dCartShipment.add(cartIndex["shipment"].toString());
            dCartCharges.add(cartIndex["charges"].toString());
            dCartQty.add(cartIndex["qty"].toString());
            dCartDiscount.add(cartIndex["discount"].toString());
            dCartPrice.add(cartIndex["price"].toString());
            dCartName.add(cartIndex["name"].toString());
            dCartCard.add(cartIndex["card"].toString());
            dCartColor.add(cartIndex["color"].toString());
            dCartSize.add(cartIndex["size"].toString());
            dCartStock.add(cartIndex["stock"].toString());
            dCartStatus.add(cartIndex["status"].toString());
            dCartCode.add(cartIndex["code"].toString());
            dCartUrl.add(cartIndex["url"].toString());
          }
        }
      } else {
        log("No Data");
      }
    } catch (e) {
      log("Catch: $e");
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    // orderDetailIsLoading = false;
    notifyListeners();
  }
}
