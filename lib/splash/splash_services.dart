import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/services/notification_service.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  NotificationServices notificationServices = NotificationServices();
  late StreamSubscription subscription;

  bool isDeviceConnected = false;
  bool isAlertSet = false;
  isUserlogin(BuildContext context) async {
    final authProvider = Provider.of<auth_pro>(context, listen: false);
    authProvider.attempCouItinitalize();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    notificationServices.getDeviceToken().then((value) {
      // final post = Provider.of<auth_pro>(context, listen: false);
      authProvider.updateToken(value);
    });

   await authProvider.getUserIdFun();

    // if (userId != null) {
    authProvider.getCurrentUserData();

    log("replaced nameed called**********");
    context.replaceNamed('bottomNavBar', queryParams: {
      'selectedTab': '0',
    });
    // } else {
    //   context.pushNamed("loginScreen");
    // }
  }
}
