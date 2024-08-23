import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class services_pro with ChangeNotifier {
  bool servicesIsLoading = false;
  //proffessionals
  List profFirstName = [];
  List profLastName = [];
  List profUrl = [];
  List profProfessionalId = [];
  List profProfileCard = [];
  List profServiceId = [];
  List profDescription = [];
  List profRating = [];
  List profPhone = [];
  //images
  List profServiceCard = [];

  getServicesByServicesIdFunc(
      String serviceId,
      String quality,
      String professional,
      String available,
      String quick,
      String address,
      String cityId,
      String stateId,
      String countryId,
      context) async {
    profFirstName = [];
    profLastName = [];
    profUrl = [];
    profProfessionalId = [];
    profProfileCard = [];
    profServiceId = [];
    profDescription = [];
    profRating = [];
    profPhone = [];
    //images
    profServiceCard = [];

    try {
      servicesIsLoading = true;
      // notifyListeners();
      log("serviceId: $serviceId");
      Map data = {
        'service_id': (serviceId == "") ? '0' : serviceId,
        'quality': (quality == "") ? '0' : quality,
        'professional': (professional == "") ? '0' : professional,
        'available': (available == "") ? '0' : available,
        'quick': (quick == "") ? '0' : quick,
        'address': (address == "") ? '0' : address,
        'city_id': (cityId == "") ? '0' : cityId,
        'state_id': (stateId == "") ? '0' : stateId,
        'country_id': (countryId == "") ? '0' : countryId,
      };
      final response = await http.post(
        Uri.parse(getServicesByServiceIdApi),
        body: data,
      );
      // log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //professionals
        List professionalData = resposne["professional"];
        if (professionalData.isNotEmpty) {
          for (int i = 0; i < professionalData.length; i++) {
            final professionalIndex = professionalData[i];
            profFirstName.add(professionalIndex["first_name"].toString());
            profLastName.add(professionalIndex["last_name"].toString());
            profUrl.add(professionalIndex["url"].toString());
            profProfessionalId
                .add(professionalIndex["professional_id"].toString());
            profProfileCard.add(professionalIndex["profile"].toString());
            profServiceId.add(professionalIndex["service_id"].toString());
            profDescription.add(professionalIndex["description"].toString());
            profRating.add(professionalIndex["rating"].toString());
            profPhone.add(professionalIndex["phone"].toString());
          }
        }
        log("profUrl: $profUrl");

        //proffesional images
        List professionalImageData = resposne["Images"];
        log("Testtt: $professionalImageData");

        if (professionalImageData.isNotEmpty) {
          for (int i = 0; i < professionalImageData.length; i++) {
            for (var j = 0; j < professionalImageData[i].length; j++) {
              log("Count");
              log("professionalImageData: ${professionalImageData[i][j]}");
              log("profProfessionalId[i].toString(): ${profProfessionalId[i].toString()}");
              log("professionalImageData[j][i][professional_id]: ${professionalImageData[i][j]["professional_id"]}");
              log("Condition: ${profProfessionalId[i].toString() == professionalImageData[i][j]["professional_id"].toString()}");
              if (profProfessionalId[i].toString() ==
                  professionalImageData[i][j]["professional_id"].toString()) {
                profServiceCard
                    .add(professionalImageData[i][j]["name"].toString());
              } else {
                profServiceCard.add(
                    "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg");
              }
            }
          }
          log("profServiceCard: $profServiceCard");
        }
      } else {
        log("No Products: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    servicesIsLoading = false;
    notifyListeners();
  }

  bool dProfDetailIsLoading = false;
  //proffesional
  String dProfFirstName = "";
  String dProfLastName = "";
  String dProfProfileCard = "";
  String dProfUrl = "";
  String dProfServiceId = "";
  String dProfProfessionalId = "";
  String dProfQuick = "";
  String dProfAvailable = "";
  String dProfProfessional = "";
  String dProfQuality = "";
  String dProfDescription = "";
  String dProfRating = "";
  String dProfPdf = "";
  String dProfDate = "";
  String dProfEmail = "";
  String dProfPhone = "";
  //Projects
  List dProfProjectsName = [];
  List dProfProjectsCard = [];
  //Images
  List dProfImagesName = [];
  //Reviews
  List dProfReviewsUser = [];
  List dProfReviewsRating = [];
  List dProfReviewsReview = [];
  List dProfReviewsDate = [];

  getProfessionalDetailsFunc(String serviceUrl, context) async {
    //professional
    dProfFirstName = "";
    dProfLastName = "";
    dProfProfileCard = "";
    dProfUrl = "";
    dProfServiceId = "";
    dProfProfessionalId = "";
    dProfQuick = "";
    dProfAvailable = "";
    dProfProfessional = "";
    dProfQuality = "";
    dProfDescription = "";
    dProfRating = "";
    dProfPdf = "";
    dProfDate = "";
    dProfEmail = "";
    dProfPhone = "";
    //projects
    dProfProjectsName = [];
    dProfProjectsCard = [];
    //Images
    dProfImagesName = [];
    //Reviews
    dProfReviewsUser = [];
    dProfReviewsRating = [];
    dProfReviewsReview = [];
    dProfReviewsDate = [];

    dProfDetailIsLoading = true;

    try {
      log("url: $serviceUrl");
      Map data = {
        'url': serviceUrl,
      };
      final response = await http.post(
        Uri.parse(getServiceProfessiobalDetailApi),
        body: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //professionals

        List dProfessionalData = resposne["Professional"];
        if (dProfessionalData.isNotEmpty) {
          var professionalDetailData = resposne["Professional"][0];
          dProfFirstName = professionalDetailData["first_name"].toString();
          dProfLastName = professionalDetailData["last_name"].toString();
          dProfProfileCard = professionalDetailData["profile"].toString();
          dProfUrl = professionalDetailData["url"].toString();
          dProfServiceId = professionalDetailData["service_id"].toString();
          dProfProfessionalId =
              professionalDetailData["professional_id"].toString();
          dProfQuick = professionalDetailData["quick"].toString();
          dProfAvailable = professionalDetailData["available"].toString();
          dProfProfessional = professionalDetailData["professional"].toString();
          dProfQuality = professionalDetailData["quality"].toString();
          dProfDescription = professionalDetailData["description"].toString();
          dProfRating = professionalDetailData["rating"].toString();
          dProfPdf = professionalDetailData["pdf"].toString();
          dProfDate = professionalDetailData["date"].toString();
          dProfEmail = professionalDetailData["email"].toString();
          dProfPhone = professionalDetailData["phone"].toString();
          log("dProfFirstName: $dProfFirstName");
        }

//images
        List professionalImagesData = resposne["Images"];
        if (professionalImagesData.isNotEmpty) {
          for (int i = 0; i < professionalImagesData.length; i++) {
            final professionalReviewIndex = professionalImagesData[i];
            dProfImagesName.add(professionalReviewIndex["name"].toString());
          }
        }

        //Reviews
        List professionalReviewsData = resposne["Reviews"];
        if (professionalReviewsData.isNotEmpty) {
          for (int i = 0; i < professionalReviewsData.length; i++) {
            final professionalReviewIndex = professionalReviewsData[i];
            dProfReviewsUser.add(professionalReviewIndex["user"].toString());
            dProfReviewsRating
                .add(professionalReviewIndex["rating"].toString());
            dProfReviewsReview
                .add(professionalReviewIndex["review"].toString());
            dProfReviewsDate.add(professionalReviewIndex["date"].toString());
          }
        }
      } else {
        log("No professionals: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    dProfDetailIsLoading = false;
    notifyListeners();
  }

  //give product rating
  bool professionalReviewIsLoading = false;
  void giveProfessionalRatingFunc(
      String serviceUrl, double rating, String message, context) async {
    try {
      professionalReviewIsLoading = true;
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      log("rating: $rating");
      String convertedRating = rating.floor().toString();
      log("convertedRating: $convertedRating");

      Map data = {
        'user_id': user_id,
        'url': serviceUrl,
        'rating': convertedRating,
        'message': message,
      };
      final response =
          await http.post(Uri.parse(professionalReviewApi), body: data);
      log("Review response ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);
          Navigator.pop(context);
          getProfessionalDetailsFunc(serviceUrl, context);
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        log("Request Failed Status Code: ${response.statusCode} ");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    professionalReviewIsLoading = false;
    notifyListeners();
  }
}
