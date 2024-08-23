import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/utils/constants.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    final authProvider = Provider.of<auth_pro>(context, listen: false);
    authProvider.getCountryFunc(context);
    super.initState();
  }

  bool checkValue = false;
  final _key = GlobalKey<FormState>();
  final fullnameC = TextEditingController();
  final phoneNumberC = TextEditingController();
  final emailC = TextEditingController();
  final addressC = TextEditingController();

  final passwordC = TextEditingController();
  final cPasswordC = TextEditingController();

  //passwords variables
  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;

  //country
  List<String> countryitems = [
    'Select Country',
    'Pakistan',
  ];
  String? selectedcountryitems = 'Select Country';
  String selectedCountryValue = "0";
  String selectedStateValue = "0";
  String selectedCityValue = "0";
  bool isCountrySelected = false;
  bool isStateSelected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Palette.themecolor),
          child: SingleChildScrollView(
            child: Column(
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
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: themewhitecolor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
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
                                  "Let's Get Started",
                                  style: TextStyle(
                                    color: themegreytextcolor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Full Name",
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
                                controller: fullnameC,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: themelightgreycolor,
                                  hintText: "Full Name",
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
                                    return "Full name is empty";
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 20,
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
                              "Phone Number",
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
                                controller: phoneNumberC,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: themelightgreycolor,
                                  hintText: "Phone Number",
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
                                    return "Phone Number is empty";
                                  } else {
                                    return null;
                                  }
                                }),
                            //country
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Country",
                              style: TextStyle(
                                color: themegreytextcolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<auth_pro>(
                                builder: ((context, modelValue, child) {
                              return modelValue.countryIsLoading
                                  ? const CircularProgressIndicator()
                                  : DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: themelightgreycolor,
                                        hintText: "Country",
                                        hintStyle:
                                            const TextStyle(fontSize: 15),
                                        errorStyle:
                                            const TextStyle(fontSize: 13),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                      ),
                                      // value: modelValue
                                      //     .countryName[int.parse(selectedCountryValue)],
                                      items: modelValue.countryName
                                          .map(
                                            (item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: themeblackcolor,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (item) async {
                                        setState(() {
                                          for (var i = 0;
                                              i < modelValue.countryName.length;
                                              i++) {
                                            if (modelValue.countryName[i] ==
                                                item) {
                                              log("i: $i");
                                              modelValue.countryId[i];
                                              log("modelValue.countryId[i]: ${modelValue.countryId[i]}");
                                              setState(() {
                                                selectedCountryValue =
                                                    modelValue.countryId[i];
                                                isCountrySelected = true;
                                                isStateSelected = false;
                                              });

                                              final authProvider =
                                                  Provider.of<auth_pro>(context,
                                                      listen: false);

                                              authProvider.getStateFunc(
                                                  selectedCountryValue,
                                                  context);

                                              log("selectedCountryValue: $selectedCountryValue");
                                            }
                                          }
                                        });
                                      });
                            })),

                            // //state
                            (isCountrySelected)
                                ? Consumer<auth_pro>(
                                    builder: ((context, modelValue, child) {
                                    return modelValue.stateIsLoading
                                        ? const CircularProgressIndicator()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "State",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        themelightgreycolor,
                                                    hintText: "State",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                        fontSize: 13),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                  ),
                                                  // value: modelValue.stateName[
                                                  //     int.parse(selectedStateValue)],
                                                  items: modelValue.stateName
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  themeblackcolor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (item) {
                                                    setState(() {
                                                      for (var i = 0;
                                                          i <
                                                              modelValue
                                                                  .stateName
                                                                  .length;
                                                          i++) {
                                                        if (modelValue
                                                                .stateName[i] ==
                                                            item) {
                                                          log("i: $i");
                                                          modelValue.stateId[i];
                                                          log("modelValue.stateId[i]: ${modelValue.stateId[i]}");
                                                          setState(() {
                                                            selectedStateValue =
                                                                modelValue
                                                                    .stateId[i];
                                                            isStateSelected =
                                                                true;
                                                          });
                                                          //calling the city func

                                                          final authProvider =
                                                              Provider.of<
                                                                      auth_pro>(
                                                                  context,
                                                                  listen:
                                                                      false);

                                                          authProvider.getCityFunc(
                                                              selectedStateValue,
                                                              context);
                                                          log("selectedStateValue: $selectedStateValue");
                                                        }
                                                      }
                                                    });
                                                  }),
                                            ],
                                          );
                                  }))
                                : Container(),

                            //City
                            (isStateSelected)
                                ? Consumer<auth_pro>(
                                    builder: ((context, modelValue, child) {
                                    return modelValue.cityIsLoading
                                        ? const CircularProgressIndicator()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "City",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        themelightgreycolor,
                                                    hintText: "City",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                        fontSize: 13),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                  ),
                                                  // value: modelValue.stateName[
                                                  //     int.parse(selectedStateValue)],
                                                  items: modelValue.cityName
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  themeblackcolor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (item) {
                                                    setState(() {
                                                      for (var i = 0;
                                                          i <
                                                              modelValue
                                                                  .cityName
                                                                  .length;
                                                          i++) {
                                                        if (modelValue
                                                                .cityName[i] ==
                                                            item) {
                                                          log("i: $i");
                                                          modelValue.cityId[i];
                                                          log("modelValue.cityId[i]: ${modelValue.cityId[i]}");
                                                          setState(() {
                                                            selectedCityValue =
                                                                modelValue
                                                                    .cityId[i];
                                                            // isCountrySelected = true;
                                                          });
                                                          log("selectedCityValue: $selectedCityValue");
                                                        }
                                                      }
                                                    });
                                                  }),
                                            ],
                                          );
                                  }))
                                : Container(),
                          
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Address",
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
                                controller: addressC,
                                maxLines: 2,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: themelightgreycolor,
                                  hintText: "Address",
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
                                    return "Address is empty";
                                  } else {
                                    return null;
                                  }
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
                                  RegExp regex = RegExp(
                                      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                                  if (value == null || value.isEmpty) {
                                    return ("password is empty");
                                  } else if (value.length < 8) {
                                    return ("Password Must be more than 8 characters");
                                  } else if (!regex.hasMatch(value)) {
                                    return ("Password should contain Upper, Lower, Digit and Special character ");
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Confirm Password",
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
                                controller: cPasswordC,
                                obscureText: !isConfirmPasswordShow,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                cursorColor: Palette.themecolor,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: themelightgreycolor,
                                    hintText: "Confirm Password",
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
                                          isConfirmPasswordShow =
                                              !isConfirmPasswordShow;
                                        });
                                      },
                                      child: isConfirmPasswordShow
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "confirm password is empty";
                                  } else if (value != passwordC.text) {
                                    return "password dosent match";
                                  } else {
                                    return null;
                                  }
                                }),
                            CheckboxListTile(
                              value: checkValue,
                              contentPadding: EdgeInsets.zero,
                              activeColor: Palette.themecolor,
                              title: const Text(
                                "I accept the policy and terms",
                                style: TextStyle(
                                  color: themegreytextcolor,
                                  fontSize: 14,
                                ),
                              ),
                              checkboxShape: const CircleBorder(),
                              side: const BorderSide(
                                color: themegreytextcolor,
                                width: 2,
                              ),
                              onChanged: (bool? newValue) {
                                setState(() {
                                  checkValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomSimpleRoundedButton(
                              onTap: () {
                                if (_key.currentState!.validate()) {
                                  if (selectedCountryValue != "0" &&
                                      selectedStateValue != "0" &&
                                      selectedCityValue != "0") {
                                    if (checkValue == true) {
                                      final authProvider =
                                          Provider.of<auth_pro>(context,
                                              listen: false);

                                      authProvider.account_creation_func(
                                          fullnameC.text,
                                          emailC.text,
                                          phoneNumberC.text,
                                          passwordC.text,
                                          selectedCountryValue,
                                          selectedStateValue,
                                          selectedCityValue,
                                          addressC.text,
                                          context);
                                    } else {
                                      showMyCustomSnackBar(
                                          "Accept Policy to continue.",
                                          true,
                                          context);
                                    }
                                  } else {
                                    showMyCustomSnackBar(
                                        "Country, State or City is not selected.",
                                        true,
                                        context);
                                  }
                                }
                              },
                              buttoncolor: Palette.themecolor,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(12),
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            Center(
                              child: Text.rich(
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: const TextStyle(
                                    color: themegreytextcolor,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => RouteNavigator.route(
                                              context,
                                              const LoginScreen(),
                                            ),
                                      text: "Login",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
