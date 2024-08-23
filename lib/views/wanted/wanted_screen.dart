import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/dummy_models/dummy_models.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/wanted_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/filled_box.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class WantedScreen extends StatefulWidget {
  const WantedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WantedScreen> createState() => _WantedScreenState();
}

class _WantedScreenState extends State<WantedScreen> {
  @override
  void initState() {
    final countryProvider = Provider.of<auth_pro>(context, listen: false);
    countryProvider.getCountryFunc(context);

    super.initState();
  }

  String? selectedPropertyType = 'Property type';
  List<String> propertyTypeitems = [
    'Property type',
    'Home',
    'Plot',
    'Commercial',
    'Industrial',
    'Multifamily',
    'Single-family home',
    'Apartment',
    'Condominium',
    'Detached house',
    'Retail',
    'Townhouse',
    'Commercial property',
    'Hotel',
    'Manufactured home',
    'Mixed-use',
    'Office',
    'Residential',
    'Acreage',
    'Agricultural properties',
    'Bungalow',
    'Personal property',
    'Commercial',
    'Cooperative',
    'Intangible property',
    'Land',
    'Residential properties',
  "Cabin",
    "Villa"
  ];

  //Selected Values
  int selectedPurposeValue = 0;
  String selectedPropertyTypeValue = "0";
  String? selectedcountryitems = 'Select Country';
  String selectedCountryValue = "0";
  String selectedStateValue = "0";
  String selectedCityValue = "0";
  bool isCountrySelected = false;
  bool isStateSelected = false;

  //textfield
  final _key = GlobalKey<FormState>();
  final TextEditingController addressC = TextEditingController();
  final TextEditingController fullNameC = TextEditingController();
  final TextEditingController phoneNumberC = TextEditingController();
  final TextEditingController additionalDetailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: FilledBox(
        onTap: () {
          //int selectedPurposeValue = 0;
          // String selectedPropertyTypeValue = "0";
          if (_key.currentState!.validate()) {
            if (selectedPropertyTypeValue != "0") {
              if (selectedCountryValue != "0") {
                if (selectedStateValue != "0") {
                  if (selectedCityValue != "0") {
                    final wantedProvider =
                        Provider.of<wanted_pro>(context, listen: false);
                    wantedProvider.userWantedFunc(
                        selectedPurposeValue.toString(),
                        selectedPropertyTypeValue,
                        selectedCountryValue,
                        selectedStateValue,
                        selectedCityValue,
                        addressC.text,
                        fullNameC.text,
                        phoneNumberC.text,
                        additionalDetailC.text,
                        context);
                  } else {
                    showMyCustomSnackBar("Please Select City", false, context);
                  }
                } else {
                  showMyCustomSnackBar("Please Select State", false, context);
                }
              } else {
                showMyCustomSnackBar("Please Select Country", false, context);
              }
            } else {
              showMyCustomSnackBar(
                  "Please Select Property Type", false, context);
            }
          }
        },
        height: 55,
        width: size.width,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        color: Palette.themecolor,
        child: const Center(
          child: Text(
            "Submit",
            style: TextStyle(
              color: themewhitecolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "For the first time Shamuk Portal , activate a team of experts in just 3 clicks to find the properties you need with completely secure and transparent transactions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CachedNetworkImage(
                imageUrl:
                    'https://new-multivendor.digitalelliptical.com/website/assets/images/wanted.png',
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: themegreycolor,
                  highlightColor: themegreytextcolor,
                  child: Container(
                    width: size.width,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: themegreycolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Tell us what you need",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: List.generate(
                  purposeModelList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPurposeValue = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: themegreytextcolor,
                            ),
                            color: selectedPurposeValue == index
                                ? Palette.themecolor
                                : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              purposeModelList[index].icon,
                              color: selectedPurposeValue == index
                                  ? themewhitecolor
                                  : themegreytextcolor,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              purposeModelList[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: selectedPurposeValue == index
                                    ? themewhitecolor
                                    : themegreytextcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Provide details by filling out the form",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //property type
              Row(
                children: const [
                  Icon(Icons.home),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Property Type",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: themegreytextcolor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.themecolor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  value: selectedPropertyType,
                  items: propertyTypeitems
                      .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              color: themeblackcolor,
                            ),
                          )))
                      .toList(),
                  onChanged: (item) {
                    for (var i = 0; i < propertyTypeitems.length; i++) {
                      if (propertyTypeitems[i] == item) {
                        log("i: $i");

                        setState(() {
                          selectedPropertyTypeValue = i.toString();
                        });
                        log("selectedPropertyType: $selectedPropertyTypeValue");
                      }
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              //country -- state -- city
              Consumer<auth_pro>(builder: ((context, modelValue, child) {
                return Column(
                  children: [
                    //country
                    Row(
                      children: const [
                        Icon(
                          Icons.place,
                          color: Palette.themecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Country Of Interest",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: "Country",
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.all(12),
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

                    const SizedBox(
                      height: 15,
                    ),
                    //state
                    (isCountrySelected)
                        ? Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.place,
                                    color: Palette.themecolor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "State Of Interest",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: "State",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: themegreytextcolor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Palette.themecolor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: const EdgeInsets.all(12),
                                  ),
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
                        : Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.place,
                                    color: Palette.themecolor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "State Of Interest",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: themegreytextcolor,
                                  ),
                                ),
                                child: const Text(
                                  "State",
                                  style: TextStyle(
                                      fontSize: 16, color: themegreytextcolor),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 15,
                    ),

                    (isStateSelected)
                        ? Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.place,
                                    color: Palette.themecolor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "City Of Interest",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: "City",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: themegreytextcolor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Palette.themecolor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: const EdgeInsets.all(12),
                                  ),
                                  items: modelValue.cityName
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
                                          i < modelValue.cityName.length;
                                          i++) {
                                        if (modelValue.cityName[i] == item) {
                                          log("i: $i");
                                          modelValue.cityId[i];
                                          log("modelValue.cityId[i]: ${modelValue.cityId[i]}");
                                          setState(() {
                                            selectedCityValue =
                                                modelValue.cityId[i];
                                            // isCountrySelected = true;
                                          });
                                          log("selectedCityValue: $selectedCityValue");
                                        }
                                      }
                                    });
                                  }),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.place,
                                    color: Palette.themecolor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "City Of Interest",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: themegreytextcolor,
                                  ),
                                ),
                                child: const Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 16, color: themegreytextcolor),
                                ),
                              ),
                            ],
                          ),
                  ],
                );
              })),

              const SizedBox(
                height: 20,
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    //address
                    Row(
                      children: const [
                        Icon(
                          Icons.place,
                          color: Palette.themecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: addressC,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: "Address",
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("Address is empty");
                          }
                          return null;
                        }),

                    const SizedBox(
                      height: 20,
                    ),
                    //Full Name
                    Row(
                      children: const [
                        Icon(
                          Icons.text_fields_sharp,
                          color: Palette.themecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: fullNameC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: "Full Name",
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("Full name is empty");
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    //Phone Number
                    Row(
                      children: const [
                        Icon(
                          Icons.call,
                          color: Palette.themecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: phoneNumberC,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: "Phone Number",
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("Phone Number is empty");
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    //Additional Details
                    Row(
                      children: const [
                        Icon(
                          Icons.description,
                          color: Palette.themecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Additional Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: additionalDetailC,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: "Addtional Details",
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("Addtional Details is empty");
                          }
                          return null;
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomSimpleRoundedButton(
              //   onTap: () {
              //     //int selectedPurposeValue = 0;
              //     // String selectedPropertyTypeValue = "0";
              //     if (_key.currentState!.validate()) {
              //       if (selectedPropertyTypeValue != "0") {
              //         if (selectedCountryValue != "0") {
              //           if (selectedStateValue != "0") {
              //             if (selectedCityValue != "0") {
              //               final wantedProvider =
              //                   Provider.of<wanted_pro>(context, listen: false);
              //               wantedProvider.userWantedFunc(
              //                   selectedPurposeValue.toString(),
              //                   selectedPropertyTypeValue,
              //                   selectedCountryValue,
              //                   selectedStateValue,
              //                   selectedCityValue,
              //                   addressC.text,
              //                   fullNameC.text,
              //                   phoneNumberC.text,
              //                   additionalDetailC.text,
              //                   context);
              //             } else {
              //               showMyCustomSnackBar(
              //                   "Please Select City", false, context);
              //             }
              //           } else {
              //             showMyCustomSnackBar(
              //                 "Please Select State", false, context);
              //           }
              //         } else {
              //           showMyCustomSnackBar(
              //               "Please Select Country", false, context);
              //         }
              //       } else {
              //         showMyCustomSnackBar(
              //             "Please Select Property Type", false, context);
              //       }
              //     }
              //   },
              //   buttoncolor: Palette.themecolor,
              //   height: kMinInteractiveDimension,
              //   width: size.width,
              //   borderRadius: BorderRadius.circular(8),
              //   child: const Text(
              //     "Submit",
              //     style: TextStyle(
              //       color: themewhitecolor,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
