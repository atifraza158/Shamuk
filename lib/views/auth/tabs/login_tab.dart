import 'package:flutter/material.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/forgot_password/forgot_password_screen.dart';
import 'package:multivendor/widgets/custom_elevated_button.dart';
import 'package:multivendor/widgets/custom_text_button.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Enter your Email",
              style: TextStyle(
                color: themeblackcolor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email here",
                hintStyle: const TextStyle(fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: themegreycolor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Palette.themecolor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter your Password",
              style: TextStyle(
                color: themeblackcolor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password Here",
                hintStyle: const TextStyle(fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: themegreycolor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Palette.themecolor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: CustomTextButton(
                buttonText: "Forgot Password?",
                onTap: () {
                  RouteNavigator.route(
                    context,
                    const ForgotPasswordScreen(),
                  );
                },
                textstyle: const TextStyle(
                  color: Palette.themecolor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CustomElevatedButton(
                onTap: () {
                  RouteNavigator.pushandremoveroute(
                    context,
                    NavBar(
                      selectedTab: 0,
                    ),
                  );
                },
                buttonSize: Size(size.width / 100 * 80, 55),
                buttoncolor: Palette.themecolor.withOpacity(0.75),
                borderRadius: BorderRadius.circular(30),
                elevation: 10,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: CustomSimpleRoundedButton(
            //     onTap: () {
            //       RouteNavigator.pushandremoveroute(
            //         context,
            //         NavBar(
            //           selectedTab: 0,
            //         ),
            //       );
            //     },
            //     height: 50,
            //     width: size.width / 100 * 80,
            //     buttoncolor: Palette.themecolor.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(12),
            //     child: const Text(
            //       "Login",
            //       style: TextStyle(
            //         color: Palette.themecolor,
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
