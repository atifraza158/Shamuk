import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/utils/custom_loading_dialog.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';

class wanted_pro with ChangeNotifier {
  bool wantedIsLoading = false;
  userWantedFunc(
      String purpose,
      String propertyType,
      String countryId,
      String stateId,
      String cityId,
      String location,
      String fullname,
      String phoneNumber,
      String additonalDetails,
      BuildContext context) async {
    wantedIsLoading = true;

    try {
      show_loading_dialog(context);
      notifyListeners();
      Map data = {
        'purpose': purpose,
        'type_id': propertyType,
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
        'location': location,
        'name': cityId,
        'phone': phoneNumber,
        'message': additonalDetails
      };

      final response = await http.post(
        Uri.parse(userWantedApi),
        body: data,
      );
      log("resposne: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        log("resposne: $resposne");
        if (resposne['error'].toString() == 'false') {
          showMyCustomSnackBar(resposne['message'].toString(), false, context);

          context.pushNamed('bottomNavBar', queryParams: {'selectedTab': '0'});
        } else {
          showMyCustomSnackBar(resposne['message'].toString(), true, context);
        }
      } else {
        showMyCustomSnackBar("Please try again.", true, context);
        Navigator.pop(context);
      }
      wantedIsLoading = false;
      notifyListeners();
    } catch (e) {
      showMyCustomSnackBar("Catch Execption $e.", true, context);
      Navigator.pop(context);
    }
  }
}
