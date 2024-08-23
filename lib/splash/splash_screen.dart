import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/services/notification_service.dart';
import 'package:multivendor/splash/splash_services.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/utils/constants.dart';
import 'package:multivendor/views/auth/verify_account_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
    
       SplashServices().isUserlogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              // color: themeblackcolor,
              color: Palette.themecolor),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                   appLogo,
                    width: size.width / 100 * 60,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 350.0),
                    child: SpinKitSquareCircle(
                      color: themewhitecolor,
                      size: 50.0,
                    )),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
