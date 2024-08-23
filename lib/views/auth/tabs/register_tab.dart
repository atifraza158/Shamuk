import 'package:flutter/material.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/home/home_screen.dart';
import 'package:multivendor/widgets/custom_elevated_button.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  bool visiblePass = true;
  bool visibleConfirmPass = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New\nAccount",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: themelightgreycolor,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: themeblackcolor,
                          size: 60,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Upload your\nprofile picture",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Enter your Name",
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
                cursorColor: Palette.themecolor,
                decoration: InputDecoration(
                  hintText: "Name here",
                  hintStyle: const TextStyle(fontSize: 15),
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
                height: 20,
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
                cursorColor: Palette.themecolor,
                decoration: InputDecoration(
                  hintText: "Email here",
                  hintStyle: const TextStyle(fontSize: 15),
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
                cursorColor: Palette.themecolor,
                obscureText: visiblePass,
                decoration: InputDecoration(
                  hintText: "Password Here",
                  hintStyle: const TextStyle(fontSize: 15),
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
                  suffixIcon: CustomIconButton(
                    onTap: () {
                      if (visiblePass == true) {
                        setState(() {
                          visiblePass = false;
                        });
                      } else if (visiblePass == false) {
                        setState(() {
                          visiblePass = true;
                        });
                      }
                    },
                    child: Icon(
                      visiblePass == false ? Icons.lock_open : Icons.lock,
                      color: Palette.themecolor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Confirm your Password",
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
                cursorColor: Palette.themecolor,
                obscureText: visibleConfirmPass,
                decoration: InputDecoration(
                  hintText: "Password Here Again",
                  hintStyle: const TextStyle(fontSize: 15),
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
                  suffixIcon: CustomIconButton(
                    onTap: () {
                      if (visibleConfirmPass == true) {
                        setState(() {
                          visibleConfirmPass = false;
                        });
                      } else if (visibleConfirmPass == false) {
                        setState(() {
                          visibleConfirmPass = true;
                        });
                      }
                    },
                    child: Icon(
                      visibleConfirmPass == false
                          ? Icons.lock_open
                          : Icons.lock,
                      color: Palette.themecolor,
                    ),
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
                    "Sign up",
                    style: TextStyle(
                      color: themewhitecolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
