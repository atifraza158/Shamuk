import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/utils/constants.dart';
import 'package:multivendor/views/auth/register_category_screen.dart';
import 'package:multivendor/views/auth/sign_up_screen.dart';
import 'package:multivendor/views/auth/verify_account_screen.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkValue = false;

  final _key = GlobalKey<FormState>();

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  //passwords variables
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Palette.themecolor,
          ),
          child: Column(
            children: [
              const Spacer(),
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
              Form(
                key: _key,
                child: Padding(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Palette.themecolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Login",
                              style: TextStyle(
                                color: themegreytextcolor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: themegreytextcolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: emailC,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: Palette.themecolor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: themelightgreycolor,
                              hintText: "Email",
                              hintStyle: const TextStyle(fontSize: 15),
                              errorStyle: const TextStyle(fontSize: 13),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "email is empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("email format is not correct.");
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: themegreytextcolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: passwordC,
                            obscureText: !isPasswordShow,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            cursorColor: Palette.themecolor,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: themelightgreycolor,
                                hintText: "Password",
                                hintStyle: const TextStyle(fontSize: 15),
                                errorStyle: const TextStyle(fontSize: 13),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPasswordShow = !isPasswordShow;
                                    });
                                  },
                                  child: isPasswordShow
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("password is empty");
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomSimpleRoundedButton(
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              final authProvider =
                                  Provider.of<auth_pro>(context, listen: false);
                              authProvider.account_login_func(
                                  emailC.text, passwordC.text, context);
                            }
                          },
                          buttoncolor: Palette.themecolor,
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: BorderRadius.circular(12),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: "Not registered yet? ",
                              style: const TextStyle(
                                color: themegreytextcolor,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => RouteNavigator.route(
                                          context,
                                          const SignupScreen(),
                                        ),
                                  text: "Create Account",
                                  style: const TextStyle(
                                    color: themegreytextcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
