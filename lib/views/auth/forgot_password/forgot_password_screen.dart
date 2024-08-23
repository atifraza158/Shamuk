import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: themewhitecolor,
        elevation: 0,
        iconTheme: const IconThemeData(color: themeblackcolor),
        titleTextStyle: const TextStyle(
          color: themeblackcolor,
          fontSize: 20,
        ),
        title: const Text("Forgot Your Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/svg/forgot-password-red.svg",
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your registered email below to receive password reset instruction",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Enter your Email",
                      style: TextStyle(
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
                        hintStyle: const TextStyle(fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: themegreycolor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Palette.themecolor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                     const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: CustomSimpleRoundedButton(
                        onTap: () {},
                        height: 50,
                        width: size.width / 100 * 80,
                        buttoncolor: Palette.themecolor,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text(
                          "Send password reset email",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
