import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/splash/splash_screen.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/utils/constants.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyAccountScreen extends StatefulWidget {
 
  const VerifyAccountScreen({
    Key? key,
   
  }) : super(key: key);

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  // int attempValue = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Verify Account"),
        actions: [
          IconButton(
            onPressed: () {
              RouteNavigator.replacementroute(context, const SplashScreen());
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration:  BoxDecoration(
            color: Palette.themecolor,
          
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                     appLogo,
                      width: size.width / 100 * 30,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Your Account is not Verified\nPlease Verify your account to continue.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themegreytextcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: OtpTextField(
                          fieldWidth: 40,
                          numberOfFields: 6,
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          borderWidth: 4.0,
                          textStyle: const TextStyle(
                            color: Palette.themecolor,
                            fontWeight: FontWeight.w600,
                          ),
                          borderColor: Palette.themecolor,
                          borderRadius: BorderRadius.circular(15),
                          focusedBorderColor: Palette.themecolor,
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) async {
                            //condition == 0 nothing
                            //condition == 1 verified
                            //condition == 2 unvarified
                            final verifyProvider =
                                Provider.of<auth_pro>(context, listen: false);
                            verifyProvider.user_verify_func(
                                verificationCode, context);
                            Future.delayed(const Duration(seconds: 5), () {
                              // if (verifyProvider.verification == 1) {
                              //   log("Acc verified");
                              // } else {
                              //   log("otp incorrect");

                              // }
                            });
                          }, // end onSubmit
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<auth_pro>(builder: ((context, value, child) {
                        return Column(
                          children: [
                            Text(
                              "You have only ${value.attempValue} attemps left.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: themegreytextcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomSimpleRoundedButton(
                              onTap: () {
                                if (value.attempValue <= 3 &&
                                    value.attempValue > 0) {
                                  final resendProvider = Provider.of<auth_pro>(
                                      context,
                                      listen: false);
                                  // resendProvider.attemptCountFunc();
                                  resendProvider
                                      .user_resend_request_func(context);
                                } else {
                                  showMyCustomSnackBar(
                                      "No Attemp Left.", false, context);
                                }
                              },
                              buttoncolor: Palette.themecolor,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(12),
                              child: value.resendIsLoading
                                  ? const CircularProgressIndicator(
                                      color: themewhitecolor,
                                    )
                                  : const Text(
                                      "RESEND REQUEST",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
