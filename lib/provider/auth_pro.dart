import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/splash/splash_screen.dart';
import 'package:multivendor/utils/custom_loading_dialog.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/auth/verify_account_screen.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class auth_pro with ChangeNotifier {
  //user signup form

  String? userId;
  getUserIdFun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
    notifyListeners();
  }

  account_creation_func(
      String fullname,
      String email,
      String phoneNumber,
      String password,
      String countryId,
      String stateId,
      String cityId,
      String address,
      context) async {
    // signup_is_being_loading = true;
    show_loading_dialog(context);
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceToken = prefs.getString("deviceToken") ?? "";

      log("Device Token: $deviceToken");
      Map data = {
        'name': fullname,
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
        'address': address,
        'token': deviceToken,
      };

      final response = await http.post(
        Uri.parse(accRegisterApi),
        body: data,
      );
      log("resposne: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        log("resposne: $resposne");
        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);

          // Navigator.popUntil(context, (route) => route.isFirst);
          RouteNavigator.replacementroute(context, const LoginScreen());
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
          Navigator.pop(context);
        }
      } else {
        showMyCustomSnackBar("Please try again.", true, context);
        Navigator.pop(context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption $e.", true, context);
      Navigator.pop(context);
    }
    notifyListeners();
  }

//user login function

  account_login_func(email, password, BuildContext context) async {
    try {
      show_loading_dialog(context);
      Map data = {'email': email, 'password': password};

      final response = await http.post(
        Uri.parse(accLoginApi),
        body: data,
      );
      log("login response >> ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        if (resposne['error'].toString() == 'true') {
          if (resposne['message'].toString() == "Account Not Verified") {
            showMyCustomSnackBar(
                resposne['message'].toString(), false, context);
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('userCode', resposne['code'].toString());
            log("User code: ${resposne['code'].toString()} ");

            // Navigator.popUntil(context, (route) => route.isFirst);
            RouteNavigator.replacementroute(
              context,
              const VerifyAccountScreen(),
            );
          } else {
            Navigator.pop(context);

            showMyCustomSnackBar(
                resposne['message'].toString(), false, context);
          }
        } else if (resposne['error'].toString() == 'false') {
          //storing credentials
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          //storing fullnanme
          await prefs.setString(
              'full_name', resposne['Account'][0]['name'].toString());
          await prefs.setString(
              'email', resposne['Account'][0]['email'].toString());

          await prefs.setString(
              'user_id', resposne['Account'][0]['user_id'].toString());

          await prefs.setString(
              'phone', resposne['Account'][0]['phone'].toString());
          await prefs.setString(
              'country_id', resposne['Account'][0]['country_id'].toString());

          await prefs.setString(
              'state_id', resposne['Account'][0]['state_id'].toString());
          await prefs.setString(
              'city_id', resposne['Account'][0]['city_id'].toString());
          await prefs.setString(
              'address', resposne['Account'][0]['address'].toString());

          log("full_name: ${resposne['Account'][0]['name'].toString()}");
          log("email: ${resposne['Account'][0]['email'].toString()}");
          log("user_id: ${resposne['Account'][0]['user_id'].toString()}");
          log("phone: ${resposne['Account'][0]['phone'].toString()}");
          log("country_id: ${resposne['Account'][0]['country_id'].toString()}");
          log("state_id: ${resposne['Account'][0]['state_id'].toString()}");
          log("city_id: ${resposne['Account'][0]['city_id'].toString()}");
          log("address: ${resposne['Account'][0]['address'].toString()}");
          getCurrentUserData();

          // RouteNavigator.replacementroute(context, NavBar(selectedTab: 0));
          getUserIdFun();
          Navigator.pop(context);
          context.replaceNamed('bottomNavBar', queryParams: {
            'selectedTab': '0',
          });
        }
      } else {
        Navigator.pop(context);
        showMyCustomSnackBar("Please Try again.", false, context);
      }
    } catch (e) {
      Navigator.pop(context);
      showMyCustomSnackBar("Exeption Caught: $e.", false, context);
    }
    notifyListeners();
  }

//user verify function

  // int verification = 0;
  user_verify_func(String otp, BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userCode = prefs.getString('userCode');
      log(("user code >>>>>>>>>>> $userCode"));
      Map data = {'code': userCode, 'otp': otp};
      final response = await http.post(
        Uri.parse(accVerifyOtpApi),
        body: data,
      );
      log("After succeffuly verified response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar("User Verified.", false, context);
          // verification = 1;
          // notifyListeners();

          //storing credentials
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          //storing fullnanme
          await prefs.setString(
              'full_name', resposne['Account'][0]['name'].toString());
          //storing user email
          await prefs.setString(
              'email', resposne['Account'][0]['email'].toString());
          //storing user id
          await prefs.setString(
              'user_id', resposne['Account'][0]['user_id'].toString());
          await prefs.setString(
              'phone', resposne['Account'][0]['phone'].toString());
          await prefs.setString(
              'country_id', resposne['Account'][0]['country_id'].toString());
          await prefs.setString(
              'state_id', resposne['Account'][0]['state_id'].toString());
          await prefs.setString(
              'city_id', resposne['Account'][0]['city_id'].toString());
          await prefs.setString(
              'address', resposne['Account'][0]['address'].toString());
          log("full_name: ${resposne['Account'][0]['name'].toString()}");
          log("email: ${resposne['Account'][0]['email'].toString()}");
          log("user_id: ${resposne['Account'][0]['user_id'].toString()}");
          getCurrentUserData();
          Navigator.popUntil(context, (route) => route.isFirst);
          // RouteNavigator.replacementroute(context, NavBar(selectedTab: 0));
          getUserIdFun();
          context.pushNamed('bottomNavBar', queryParams: {'selectedTab': '0'});
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        showMyCustomSnackBar("Please Try again.", true, context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }
    // verification = 2;

    notifyListeners();
  }

//attemp count
  int attempValue = 3;
  attempCouItinitalize() {
    attempValue = 3;
    notifyListeners();
  }

  attemptCountFunc() {
    attempValue -= 1;
    notifyListeners();
  }

  bool resendIsLoading = false;
  user_resend_request_func(context) async {
    try {
      attemptCountFunc();
      resendIsLoading = true;
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userCode = prefs.getString('userCode');
      log("$userCode");
      Map data = {
        'code': userCode,
      };
      final response = await http.post(Uri.parse(accResendOtpApi), body: data);
      Map<String, dynamic> resposne = jsonDecode(response.body);
      log(resposne.toString());
      if (response.statusCode == 200) {
        // // Optresend = resposne['otp'].toString();
        // log("OTP: ${resposne['otp'].toString()}");
        resendIsLoading = false;
        notifyListeners();
      } else {
        showMyCustomSnackBar("Please Try again.", true, context);
      }
    } catch (e) {
      showMyCustomSnackBar(
        "Catch Error: $e",
        true,
        context,
      );
    }
    resendIsLoading = false;
    notifyListeners();
  }

//get country
  bool countryIsLoading = false;
  List countryId = [];
  List countryName = [];
  getCountryFunc(context) async {
    countryId = [];
    countryName = [];

    countryIsLoading = true;
    // notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(getCountryApi),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //country
        List countryData = resposne["country"];
        if (countryData.isNotEmpty) {
          for (int i = 0; i < countryData.length; i++) {
            final countryIndex = countryData[i];
            countryId.add(countryIndex["country_id"].toString());
            countryName.add(countryIndex["name"].toString());
          }
        }

        log("countryName: $countryName");
      } else {
        log("No Data: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    countryIsLoading = false;
    notifyListeners();
  }

//get State
  bool stateIsLoading = false;
  List stateId = [];
  List stateName = [];
  getStateFunc(String countryId, context) async {
    stateId = [];
    stateName = [];
    stateIsLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$getStateApi/$countryId"),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //state
        List countryData = resposne["state"];
        if (countryData.isNotEmpty) {
          for (int i = 0; i < countryData.length; i++) {
            final countryIndex = countryData[i];
            stateId.add(countryIndex["state_id"].toString());
            stateName.add(countryIndex["name"].toString());
          }
          notifyListeners();
        }

        log("stateId: $stateId");
        log("stateName: $stateName");
      } else {
        log("No Data: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    stateIsLoading = false;
    notifyListeners();
  }

  //get City
  bool cityIsLoading = false;
  List cityId = [];
  List cityName = [];
  getCityFunc(String stateId, context) async {
    cityId = [];
    cityName = [];
    cityIsLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$getCityApi/$stateId"),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //city
        List countryData = resposne["city"];
        if (countryData.isNotEmpty) {
          for (int i = 0; i < countryData.length; i++) {
            final countryIndex = countryData[i];
            cityId.add(countryIndex["city_id"].toString());
            cityName.add(countryIndex["name"].toString());
          }
        }

        log("city: $cityName");
      } else {
        log("No Data: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    cityIsLoading = false;
    notifyListeners();
  }

  //user api data
  bool userCurrentDataIsLoading = false;
  String userCurrentFullName = "";
  String userCurrentEmail = "";
  String userCurrentPhone = "";
  String userCurrentCountryId = "";
  String userCurrentStateId = "";
  String userCurrentCityId = "";
  String userCurrentAddress = "";

  getCurrentUserDataFunc(context) async {
    userCurrentFullName = "";
    userCurrentEmail = "";
    userCurrentPhone = "";
    userCurrentCountryId = "";
    userCurrentStateId = "";
    userCurrentCityId = "";
    userCurrentAddress = "";

    userCurrentDataIsLoading = true;
    // notifyListeners();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? user_id = prefs.getString('user_id');
      log("user_id: $user_id");
      Map data = {
        'user_id': user_id,
      };
      final response = await http.post(
        Uri.parse(currentUserAccDataApi),
        body: data,
      );
      log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        //User
        List propertyDetailData = resposne["User"];
        if (propertyDetailData.isNotEmpty) {
          var propertyData = resposne["User"][0];
          //saving in shared prefrences
          //storing credentials
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          //storing fullnanme
          await prefs.setString('full_name', propertyData["name"].toString());
          await prefs.setString('email', propertyData["email"].toString());
          await prefs.setString('phone', propertyData["phone"].toString());
          await prefs.setString(
              'country_id', propertyData["country_id"].toString());
          await prefs.setString(
              'state_id', propertyData["state_id"].toString());
          await prefs.setString('city_id', propertyData["city_id"].toString());
          await prefs.setString('address', propertyData["address"].toString());
          //saving in variables
          userCurrentFullName = propertyData["name"].toString();
          userCurrentEmail = propertyData["email"].toString();
          userCurrentPhone = propertyData["phone"].toString();
          userCurrentCountryId = propertyData["country_id"].toString();
          userCurrentStateId = propertyData["state_id"].toString();
          userCurrentCityId = propertyData["city_id"].toString();
          userCurrentAddress = propertyData["address"].toString();
        }

        log("userCurrentFullName: $userCurrentFullName");
      } else {
        log("No Data: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    userCurrentDataIsLoading = false;
    notifyListeners();
  }

//user detail update function
  userDetailUpdatefunc(String fullname, String phoneNumber, String countryId,
      String stateId, String cityId, String address, context) async {
    show_loading_dialog(context);
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      log("country_id: $countryId");
      log("state_id: $countryId");
      log("city_id: $countryId");

      Map data = {
        'user_id': user_id,
        'name': fullname,
        'phone': phoneNumber,
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
        'address': address,
      };

      final response = await http.post(
        Uri.parse(userUpdateDetailApi),
        body: data,
      );

      log("resposne: ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);

          //calling the current user details func again when user detail updates
          getCurrentUserDataFunc(context);
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        showMyCustomSnackBar("Please try again.", true, context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption $e.", true, context);
    }
    Navigator.pop(context);
    notifyListeners();
  }

//user change password function
  userChangePasswordfunc(
      String oldPassword, String newPassword, context) async {
    show_loading_dialog(context);
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      Map data = {
        'user_id': user_id,
        'current_password': oldPassword,
        'new_password': newPassword,
      };

      final response = await http.post(
        Uri.parse(userChangePasswordApi),
        body: data,
      );

      log("resposne: ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          //removing stored things
          prefs.remove('userCode');
          prefs.remove('full_name');
          prefs.remove('email');
          prefs.remove('user_id');

          RouteNavigator.pushandremoveroute(context, const SplashScreen());
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
          Navigator.pop(context);
        }
      } else {
        showMyCustomSnackBar("Please try again.", true, context);
        Navigator.pop(context);
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption $e.", true, context);
    }
    // Navigator.pop(context);
    notifyListeners();
  }

  //user contact us

  userContactUsFunc(String fullName, String email, String subject,
      String message, BuildContext context) async {
    try {
      show_loading_dialog(context);
      notifyListeners();

      Map data = {
        'name': fullName,
        'email': email,
        'subject': subject,
        'message': message,
      };

      final response = await http.post(
        Uri.parse(userContactUsApi),
        body: data,
      );

      log("resposne: ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);
          // RouteNavigator.pushandremoveroute(context, NavBar(selectedTab: 0));
          context.pushNamed('bottomNavBar', queryParams: {'selectedTab': '0'});
        } else {
          Navigator.pop(context);
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        showMyCustomSnackBar("Please try again.", true, context);
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      showMyCustomSnackBar("Catch Execption $e.", true, context);
    }
    notifyListeners();
  }

//home slider country

  bool homeSliderIsLoading = false;
  List homeSliderCityId = [];
  List homeSliderName = [];
  List homeSliderImage = [];
  List cityDataHome = [];
  homeSliderCitiesFunc(context) async {
    homeSliderCityId = [];
    homeSliderName = [];
    homeSliderImage = [];
    homeSliderIsLoading = true;
    // notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(homeSliderCitiesAPi),
      );
      // log("Response response ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);

        List cityData = resposne["city"];
        cityDataHome = cityData;
        print("cityData: $cityData");
        if (cityData.isNotEmpty) {
          for (int i = 0; i < cityData.length; i++) {
            final propertyIndex = cityData[i];
            homeSliderCityId.add(propertyIndex["city_id"].toString());
            homeSliderName.add(propertyIndex["city"].toString());
            homeSliderImage.add(propertyIndex["card"].toString());
          }
        }
      } else {
        log("No Data: ");
      }
    } catch (e) {
      showMyCustomSnackBar("Catch Execption: $e.", true, context);
    }

    homeSliderIsLoading = false;
    notifyListeners();
  }

  Future<Map> getCityInfo(cityId) async {
    final response = await http.get(
      Uri.parse(getCityInfoId + cityId),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      return resposne['cityInfo'][0];
    } else {
      return Future.error("Data Empty");
    }
  }

  //current user details
  String getFullName = "";
  String getEmail = "";
  String getUserId = "";
  String getPhone = "";
  String getCountryId = "";
  String getStateId = "";
  String getCityId = "";
  String getAddress = "";

  void getCurrentUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? full_name = prefs.getString('full_name');
    final String? email = prefs.getString('email');
    final String? user_id = prefs.getString('user_id');
    final String? phone = prefs.getString('phone');
    final String? country_id = prefs.getString('country_id');
    final String? state_id = prefs.getString('state_id');
    final String? city_id = prefs.getString('city_id');
    final String? address = prefs.getString('address');

    getFullName = full_name.toString();
    getEmail = email.toString();
    getUserId = user_id.toString();
    getPhone = phone.toString();
    getCountryId = country_id.toString();
    getStateId = state_id.toString();
    getCityId = city_id.toString();
    getAddress = address.toString();

    notifyListeners();
  }

  void updateToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString("user_id") ?? "";
    //saving token for registeration api
    await prefs.setString('deviceToken', token.toString());
    String deviceToken = prefs.getString("deviceToken") ?? "";

    log("Device Token: $deviceToken");

    log("userid: $userid");

    final response = await http.post(Uri.parse(updateDeviceTokenApi), body: {
      'user_id': userid,
      'token': token,
    });
    // log("Token Update Response>>> ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      log("decoded response>>> $resposne");
    }
  }
}
