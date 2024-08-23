import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/model/filter/property_filter_m.dart';
import 'package:multivendor/model/property/property_model.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class properties_pro with ChangeNotifier {
  PropertyFilterM propertyFilter = PropertyFilterM();
  bool propertysIsLoading = false;
  List propertyTypeId = [];
  List propertyTitle = [];
  List propertyPurpose = [];
  List propertyUrl = [];
  List propertyCard = [];
  List propertyCountry = [];
  List propertyState = [];
  List propertyCity = [];
  List propertyLocation = [];
  List propertyArea = [];
  List propertyAreaUnit = [];
  List propertyPrice = [];
  List propertyBedroom = [];
  List propertyBathroom = [];
  List propertyCondition = [];
  List propertyBusinessPhone = [];

  getPropertiesFunc(
      String purpose,
      String typeId,
      String country,
      String stateId,
      String cityId,
      String location,
      String condition,
      String bedroom,
      String bathroom,
      String min,
      String max,
      context) async {
// notifyListeners();

    try {
      propertyTypeId = [];
      propertyTitle = [];
      propertyPurpose = [];
      propertyUrl = [];
      propertyCard = [];
      propertyCountry = [];
      propertyState = [];
      propertyCity = [];
      propertyLocation = [];
      propertyArea = [];
      propertyAreaUnit = [];
      propertyPrice = [];
      propertyBedroom = [];
      propertyBathroom = [];
      propertyCondition = [];
      propertyBusinessPhone = [];
      propertysIsLoading = true;
      log("propertyUrl $propertyUrl");
      log("purpose $purpose");
      Map data = {
        'purpose': (purpose == "") ? '0' : purpose,
        'type_id': (typeId == "") ? '0' : typeId,
        'country': (country == "") ? '0' : country,
        'state_id': (stateId == "") ? '0' : stateId,
        'city_id': (cityId == "") ? '0' : cityId,
        'location': (location == "") ? '0' : location,
        'condition': (condition == "") ? '0' : condition,
        'bedroom': (bedroom == "") ? '0' : bedroom,
        'bathroom': (bathroom == "") ? '0' : bathroom,
        'min': (min == "") ? '0' : min,
        'max': (max == "") ? '0' : max,
      };
      final response = await http.post(
        Uri.parse(getAllPropertiesApi),
        body: data,
      );
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        List propertyData = resposne["property"];
        if (propertyData.isNotEmpty) {
          for (int i = 0; i < propertyData.length; i++) {
            final propertyIndex = propertyData[i];
            propertyTitle.add(propertyIndex["title"].toString());
            propertyTypeId.add(propertyIndex["type_id"].toString());
            propertyPurpose.add(propertyIndex["purpose"].toString());
            propertyUrl.add(propertyIndex["url"].toString());
            propertyCard.add(propertyIndex["card"].toString());
            propertyCountry.add(propertyIndex["country"].toString());
            propertyState.add(propertyIndex["state"].toString());
            propertyCity.add(propertyIndex["city"].toString());
            propertyLocation.add(propertyIndex["location"].toString());
            propertyArea.add(propertyIndex["area"].toString());
            propertyAreaUnit.add(propertyIndex["area_unit"].toString());
            propertyPrice.add(propertyIndex["price"].toString());
            propertyBedroom.add(propertyIndex["bedroom"].toString());
            propertyBathroom.add(propertyIndex["bathroom"].toString());
            propertyCondition.add(propertyIndex["condition"].toString());
            propertyBusinessPhone
                .add(propertyIndex["business_phone"].toString());
          }
        }
        log("productName: $propertyPurpose");
      } else {
        log("No Products: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    propertysIsLoading = false;
    notifyListeners();
  }

  Future<List<PropertyModelM>> getPropertyHome() async {
    List<PropertyModelM> data = [];
    try {
      Map body = {
        'purpose': '0',
        'type_id': '0',
        'country': '0',
        'state_id': '0',
        'city_id': '0',
        'location': '0',
        'condition': '0',
        'bedroom': '0',
        'bathroom': '0',
        'min': '0',
        'max': '0',
      };
      final response = await http.post(
        Uri.parse(getAllPropertiesApi),
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        if (result['property'].isNotEmpty) {
          for (int i = 0; i < result['property'].length; i++) {
            data.add(PropertyModelM.fromJson(result['property'][i]));
          }
        }
      }
      return data;
    } catch (e) {
      return Future.error(e);
    }
  }

  bool propertyDetailIsLoading = true;
  String dPropertyTitle = "";
  String dPropertyTypeId = "";
  String dPropertyArea = "";
  String dPropertyAreaUnit = "";
  String dPropertyPrice = "";
  String dPropertyPurpose = "";
  String dPropertyLocation = "";
  String dPropertyDate = "";
  String dPropertyTime = "";
  String dPropertyBedroom = "";
  String dPropertyBathroom = "";
  String dPropertyCondition = "";
  String dPropertyDescription = "";
  List dPropertyImages = [];
  String dPropertyCountry = "";
  String dPropertyShopName = "";
  String dPropertyBusinessEmail = "";
  String dPropertyPhoneNumber = "";
  String dPropertyState = "";
  String dPropertyCity = "";
  String dPropertyJoinDate = "";
  String dPropertyPDF = "";
  String dPropertyCard = "";
  List dPropertyMapImages = [];
  String dPropertyUrl = "";

  getPropertyDetails(String propertyUrl, context) async {
    log("Property Url: $propertyUrl");
    propertyDetailIsLoading = true;
    dPropertyTitle = "";
    dPropertyTypeId = "";
    dPropertyArea = "";
    dPropertyAreaUnit = "";
    dPropertyPrice = "";
    dPropertyPurpose = "";
    dPropertyLocation = "";
    dPropertyDate = "";
    dPropertyTime = "";
    dPropertyBedroom = "";
    dPropertyBathroom = "";
    dPropertyCondition = "";
    dPropertyDescription = "";
    dPropertyImages = [];
    dPropertyCountry = "";
    dPropertyShopName = "";
    dPropertyBusinessEmail = "";
    dPropertyPhoneNumber = "";
    dPropertyState = "";
    dPropertyCity = "";
    dPropertyJoinDate = "";
    dPropertyPDF = "";
    dPropertyCard = "";
    dPropertyMapImages = [];
    dPropertyUrl = "";

    // notifyListeners();
    log("url: $propertyUrl");
    try {
      Map data = {
        'url': propertyUrl,
      };
      final response =
          await http.post(Uri.parse(getPropertyDetailApi), body: data);

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //products
        List propertyDetailData = resposne["Property"];
        if (propertyDetailData.isNotEmpty) {
          var propertyData = resposne["Property"][0];
          dPropertyTitle = propertyData["title"].toString();
          dPropertyTypeId = propertyData["type_id"].toString();
          dPropertyArea = propertyData["area"].toString();
          dPropertyAreaUnit = propertyData["area_unit"].toString();
          dPropertyPrice = propertyData["price"].toString();
          dPropertyPurpose = propertyData["purpose"].toString();
          dPropertyLocation = propertyData["location"].toString();
          dPropertyDate = propertyData["date"].toString();
          dPropertyTime = propertyData["time"].toString();
          dPropertyBedroom = propertyData["bedroom"].toString();
          dPropertyBathroom = propertyData["bathroom"].toString();
          dPropertyCondition = propertyData["condition"].toString();
          dPropertyDescription = propertyData["description"].toString();

          if (propertyData["images"] != null) {
            dPropertyImages.add(propertyData["images"].toString());
          }

          dPropertyCountry = propertyData["country"].toString();
          dPropertyShopName = propertyData["shop_name"].toString();
          dPropertyBusinessEmail = propertyData["business_email"].toString();
          dPropertyPhoneNumber = propertyData["business_phone"].toString();
          dPropertyState = propertyData["state"].toString();
          dPropertyCity = propertyData["city"].toString();
          dPropertyJoinDate = propertyData["join_date"].toString();
          dPropertyPDF = propertyData["pdf"].toString();
          dPropertyCard = propertyData["card"].toString();
          if (propertyData["maps"] != null) {
            dPropertyMapImages.add(propertyData["maps"].toString());
          }
          dPropertyUrl = propertyData["url"].toString();

          log("dPropertyUrl: $dPropertyUrl");
        }
      } else {
        log("No Data");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    propertyDetailIsLoading = false;
    notifyListeners();
  }
}
