import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    final authProvider = Provider.of<auth_pro>(context, listen: false);
    // authProvider.getCurrentUserDataFunc(context);
    setVariablesFunc();
    authProvider.getCountryFunc(context);

    super.initState();
  }

  setVariablesFunc() async {
    final authProvider = Provider.of<auth_pro>(context, listen: false);

    authProvider.getCurrentUserDataFunc(context);
    Future.delayed(const Duration(seconds: 3), () {
      fullnameC.text = authProvider.userCurrentFullName;
      phoneNumberC.text = authProvider.userCurrentPhone;

      if (authProvider.userCurrentAddress != "null") {
        addressC.text = authProvider.userCurrentAddress;
      }
    });
  }

  final _key = GlobalKey<FormState>();
  final fullnameC = TextEditingController();
  final phoneNumberC = TextEditingController();
  final addressC = TextEditingController();

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
    return Scaffold(
      backgroundColor: themegreycolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar:
          Consumer<auth_pro>(builder: ((context, modelValue, child) {
        return modelValue.userCurrentFullName != ""
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSimpleRoundedButton(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      log("selectedCountryValue: $selectedCountryValue");
                      log("selectedStateValue: $selectedStateValue");
                      log("selectedCityValue: $selectedCityValue");

                      final updateProvider =
                          Provider.of<auth_pro>(context, listen: false);
                      updateProvider.userDetailUpdatefunc(
                          fullnameC.text,
                          phoneNumberC.text,
                          selectedCountryValue,
                          selectedStateValue,
                          selectedCityValue,
                          addressC.text,
                          context);
                    }
                  },
                  buttoncolor: Palette.themecolor,
                  height: kMinInteractiveDimension,
                  width: MediaQuery.of(context).size.width * 0.85,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: themewhitecolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            : SizedBox();
      })),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Consumer<auth_pro>(builder: ((context, modelValue, child) {
              if (modelValue.userCurrentDataIsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (modelValue.userCurrentFullName != "") {
                log("modelValue.userCurrentFullName: ${modelValue.userCurrentFullName}");

                return Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Full Name",
                        style: TextStyle(
                          // color: themewhitecolor,
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
                            fillColor: themewhitecolor,
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
                        "Phone Number",
                        style: TextStyle(
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
                            fillColor: themewhitecolor,
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

                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Country",
                        style: TextStyle(
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
                            fillColor: themewhitecolor,
                            hintText: "Country",
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
                            contentPadding: const EdgeInsets.all(20),
                          ),
                          value: modelValue
                              .countryName[int.parse(selectedCountryValue)],
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
                          onChanged: (item) {
                            setState(() {
                              for (var i = 0;
                                  i < modelValue.countryName.length;
                                  i++) {
                                if (modelValue.countryName[i] == item) {
                                  log("i: $i");
                                  modelValue.countryId[i];
                                  log("modelValue.countryId[i]: ${modelValue.countryId[i]}");
                                  setState(() {
                                    selectedCountryValue =
                                        modelValue.countryId[i];
                                    isCountrySelected = true;
                                    isStateSelected = false;
                                  });
                                  final authProvider = Provider.of<auth_pro>(
                                      context,
                                      listen: false);

                                  authProvider.getStateFunc(
                                      selectedCountryValue, context);

                                  log("selectedCountryValue: $selectedCountryValue");
                                }
                              }
                            });
                          }),
                      //state
                      (isCountrySelected)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),

                                //State
                                const Text(
                                  "State",
                                  style: TextStyle(
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
                                      fillColor: themewhitecolor,
                                      hintText: "State",
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
                                      contentPadding: const EdgeInsets.all(20),
                                    ),
                                    // value: modelValue.stateName[
                                    //     int.parse(selectedStateValue)],
                                    items: modelValue.stateName
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
                                    onChanged: (item) {
                                      setState(() {
                                        for (var i = 0;
                                            i < modelValue.stateName.length;
                                            i++) {
                                          if (modelValue.stateName[i] == item) {
                                            log("i: $i");
                                            modelValue.stateId[i];
                                            log("modelValue.stateId[i]: ${modelValue.stateId[i]}");
                                            setState(() {
                                              selectedStateValue =
                                                  modelValue.stateId[i];
                                              isStateSelected = true;
                                            });
                                            //calling the city func

                                            final authProvider =
                                                Provider.of<auth_pro>(context,
                                                    listen: false);

                                            authProvider.getCityFunc(
                                                selectedStateValue, context);
                                            log("selectedStateValue: $selectedStateValue");
                                          }
                                        }
                                      });
                                    }),
                              ],
                            )
                          : Container(),

                      //address
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Address",
                        style: TextStyle(
                          // color: themewhitecolor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: addressC,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Palette.themecolor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: themewhitecolor,
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
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Image.asset(
                    "assets/images/png/404.png",
                    height: 250,
                    width: 250,
                  ),
                );
              }
            }))),
      ),
    );
  }
}
