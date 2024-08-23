import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class PropertyFiltersBottomSheet extends StatefulWidget {
  final bool country;
  PropertyFiltersBottomSheet({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  State<PropertyFiltersBottomSheet> createState() =>
      _PropertyFiltersBottomSheetState();
}

class _PropertyFiltersBottomSheetState
    extends State<PropertyFiltersBottomSheet> {
  load() {
    if (widget.country) {
      final propertyProvider =
          Provider.of<properties_pro>(context, listen: false);
      final authProvider = Provider.of<auth_pro>(context, listen: false);

      selectedCountryValue =
          propertyProvider.propertyFilter.countryId.toString();
      country = propertyProvider.propertyFilter.country;
      authProvider.getStateFunc(selectedCountryValue, context);
      isCountrySelected = true;
      //
      state = propertyProvider.propertyFilter.state.toString();
      selectedStateValue = propertyProvider.propertyFilter.stateId.toString();
      authProvider.getCityFunc(selectedStateValue, context);
      //
      city = propertyProvider.propertyFilter.city.toString();
      selectedCityValue = propertyProvider.propertyFilter.cityId.toString();
    }
  }

  //filters values
  String selectedPurposeValue = "0";
  String selectedPropertyTypeValue = "0";
  String selectedCountryValue = "0";
  String selectedStateValue = "0";
  String selectedCityValue = "0";
  String? country;
  String? state;
  String? city;
  final locationTextC = TextEditingController();
  double selectedConditionRating = 0;
  double selectedBedRoomValue = 0;
  double selectedBathroomValue = 0;
  final selectedMinValue = TextEditingController(text: "0");
  final selectedMaxValue = TextEditingController(text: "0");

  //
  bool topRated = false;
  bool mostViewed = false;
  bool isCountrySelected = false;
  bool isStateSelected = false;
  int? selectedIndex;
  double rating = 1;
  List<String> propertyTypeitems = [
    "Property type",
    "Home",
    "Plot",
    "Commercial",
    "Industrial",
    "Multifamily",
    "Single-family home",
    "Apartment",
    "Condominium",
    "Detached house",
    "Retail",
    "Townhouse",
    "Commercial property",
    "Hotel",
    "Manufactured home",
    "Mixed-use",
    "Office",
    "Residential",
    "Acreage",
    "Agricultural properties",
    "Bungalow",
    "Personal property",
    "Commercial",
    "Cooperative",
    "Intangible property",
    "Land",
    "Residential properties",
    "Cabin",
    "Villa"
  ];
  String? selectedPropertyType = 'Property type';

  // country

  List<String> countryitems = [
    'Select Country',
    'Pakistan',
  ];
  String? selectedcountryitems = 'Select Country';

// state
  List<String> stateitems = [
    'Select State',
    'Punjab',
  ];
  String? selectedstateitems = 'Select State';

// city
  List<String> cityitems = [
    'Select City',
    'Lahore',
  ];
  String? selectedcityitems = 'Select City';

  // service
  List<String> serviceitems = [
    'Select Service',
    'Carpenter',
  ];
  String? selectedserviceitems = 'Select Service';

  // category
  List<String> categoryitems = [
    'Select Category',
    'Mobiles',
    'Dining',
  ];
  String? selectedcategoryitems = 'Select Category';

  // subcategory
  List<String> subcategoryitems = [
    'Select Sub Category',
    'Used Mobile',
  ];
  String? selectedsubcategoryitems = 'Select Sub Category';
  @override
  void initState() {
    load();
    selectedPurposeValue = "2";
    selectedIndex = 1;
    final authProvider = Provider.of<auth_pro>(context, listen: false);
    authProvider.getCountryFunc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.transparent),
          backgroundColor: Palette.themecolor,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Property Filters",
            style: TextStyle(color: themewhitecolor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: themegreycolor,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themewhitecolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: themegreycolor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tell us what you want",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomSimpleRoundedButton(
                        onTap: () {
                          final propertyProvider = Provider.of<properties_pro>(
                              context,
                              listen: false);
                          propertyProvider.getPropertiesFunc("", "", "", "", "",
                              "", "", "", "", "", "", context);

                          Navigator.pop(context);
                        },
                        buttoncolor: themeorangecolor,
                        height: size.height / 100 * 4,
                        width: size.width / 100 * 20,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text(
                          "Clear All",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //purpose
                  Row(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedPurposeValue = "${index + 1}";
                            });
                            log("selectedIndex: $selectedIndex");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Palette.themecolor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: themegreytextcolor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  index == 0 ? Icons.key : CupertinoIcons.home,
                                  color: selectedIndex == index
                                      ? themewhitecolor
                                      : themegreytextcolor,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  index == 0 ? "Rent" : "Sale",
                                  style: TextStyle(
                                    color: selectedIndex == index
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
                    height: 20,
                  ),
                  //property type
                   Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Property type",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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

                  // const Row(
                  //   children: [
                  //     Icon(
                  //       Icons.place,
                  //       color: Palette.themecolor,
                  //     ),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     Text(
                  //       "Country",
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //             const BorderSide(color: themegreytextcolor),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //             const BorderSide(color: Palette.themecolor),
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       contentPadding: const EdgeInsets.all(12),
                  //     ),
                  //     value: selectedcountryitems,
                  //     items: countryitems
                  //         .map(
                  //           (item) => DropdownMenuItem(
                  //             value: item,
                  //             child: Text(
                  //               item,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //                 color: themeblackcolor,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (item) {
                  //       setState(() {
                  //         selectedcountryitems = item.toString();
                  //         for (var i = 0; i < countryitems.length; i++) {
                  //           if (countryitems[i] == item) {
                  //             log("i: $i");

                  //             setState(() {
                  //               selectedCountryValue = i.toString();
                  //             });
                  //             log("selectedCountryValue: $selectedCountryValue");
                  //           }
                  //         }
                  //       });
                  //     }),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // (selectedCountryValue != "0")
                  //     ? Column(
                  //         children: [
                  //           const Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.place,
                  //                 color: Palette.themecolor,
                  //               ),
                  //               SizedBox(
                  //                 width: 6,
                  //               ),
                  //               Text(
                  //                 "State",
                  //                 style: TextStyle(
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           DropdownButtonFormField(
                  //               decoration: InputDecoration(
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       color: themegreytextcolor),
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       color: Palette.themecolor),
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 contentPadding: const EdgeInsets.all(12),
                  //               ),
                  //               value: selectedstateitems,
                  //               items: stateitems
                  //                   .map(
                  //                     (item) => DropdownMenuItem(
                  //                       value: item,
                  //                       child: Text(
                  //                         item,
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           color: themeblackcolor,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )
                  //                   .toList(),
                  //               onChanged: (item) {
                  //                 for (var i = 0; i < stateitems.length; i++) {
                  //                   if (stateitems[i] == item) {
                  //                     log("i: $i");

                  //                     setState(() {
                  //                       selectedStateValue = i.toString();
                  //                     });
                  //                     log("selectedStateValue: $selectedStateValue");
                  //                   }
                  //                 }
                  //               }),
                  //           const SizedBox(
                  //             height: 30,
                  //           ),
                  //         ],
                  //       )
                  //     : Container(),
                  // (selectedStateValue != "0")
                  //     ? Column(
                  //         children: [
                  //           const Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.place,
                  //                 color: Palette.themecolor,
                  //               ),
                  //               SizedBox(
                  //                 width: 6,
                  //               ),
                  //               Text(
                  //                 "City",
                  //                 style: TextStyle(
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           DropdownButtonFormField(
                  //               decoration: InputDecoration(
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       color: themegreytextcolor),
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderSide: const BorderSide(
                  //                       color: Palette.themecolor),
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 contentPadding: const EdgeInsets.all(12),
                  //               ),
                  //               value: selectedcityitems,
                  //               items: cityitems
                  //                   .map(
                  //                     (item) => DropdownMenuItem(
                  //                       value: item,
                  //                       child: Text(
                  //                         item,
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           color: themeblackcolor,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )
                  //                   .toList(),
                  //               onChanged: (item) {
                  //                 for (var i = 0; i < cityitems.length; i++) {
                  //                   if (cityitems[i] == item) {
                  //                     log("i: $i");

                  //                     setState(() {
                  //                       selectedCityValue = i.toString();
                  //                     });
                  //                     log("selectedCityValue: $selectedCityValue");
                  //                   }
                  //                 }
                  //               }),
                  //           const SizedBox(
                  //             height: 30,
                  //           ),
                  //         ],
                  //       )
                  //     : Container(),
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
                  Consumer<auth_pro>(builder: ((context, modelValue, child) {
                    return modelValue.countryIsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField(
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
                            value: country,
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
                            });
                  })),

                  // //state
                  (isCountrySelected)
                      ? Consumer<auth_pro>(
                          builder: ((context, modelValue, child) {
                          return modelValue.stateIsLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          hintText: "State",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: themegreytextcolor),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Palette.themecolor),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                        ),
                                        value: state,
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
                                              if (modelValue.stateName[i] ==
                                                  item) {
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
                                                    Provider.of<auth_pro>(
                                                        context,
                                                        listen: false);

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
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          hintText: "City",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: themegreytextcolor),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Palette.themecolor),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                        ),

                                        // decoration: InputDecoration(
                                        //   filled: true,
                                        //   fillColor: themelightgreycolor,
                                        //   hintText: "City",
                                        //   hintStyle:
                                        //       const TextStyle(fontSize: 15),
                                        //   errorStyle:
                                        //       const TextStyle(fontSize: 13),
                                        //   enabledBorder: OutlineInputBorder(
                                        //     borderSide: BorderSide.none,
                                        //     borderRadius:
                                        //         BorderRadius.circular(12),
                                        //   ),
                                        //   focusedBorder: OutlineInputBorder(
                                        //     borderSide: BorderSide.none,
                                        //     borderRadius:
                                        //         BorderRadius.circular(12),
                                        //   ),
                                        //   contentPadding:
                                        //       const EdgeInsets.all(20),
                                        // ),
                                        // value: modelValue.stateName[
                                        //     int.parse(selectedStateValue)],
                                        value: city,
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
                                              if (modelValue.cityName[i] ==
                                                  item) {
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
                                );
                        }))
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  //location text
                   Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: locationTextC,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: themegreytextcolor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Palette.themecolor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "Location",
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

//                   //conditions
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Condition",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "${selectedConditionRating.toStringAsPrecision(2)}/10",
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   Slider(
//                     min: 0,
//                     max: 10,
//                     value: selectedConditionRating,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedConditionRating = value;
//                       });
//                       log("selectedConditionRating: $selectedConditionRating");
//                     },
//                     divisions: 10,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
// //bedrooms
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Bedrooms",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "${selectedBedRoomValue.toStringAsPrecision(2)}/10",
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   Slider(
//                     min: 0,
//                     max: 10,
//                     value: selectedBedRoomValue,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedBedRoomValue = value;
//                       });
//                       log("selectedBedRoomValue: $selectedBedRoomValue");
//                     },
//                     divisions: 10,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Bathrooms",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "${selectedBathroomValue.toStringAsPrecision(2)}/10",
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   Slider(
//                     min: 0,
//                     max: 10,
//                     value: selectedBathroomValue,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedBathroomValue = value;
//                       });
//                       log("selectedBathroomValue: $selectedBathroomValue");
//                     },
//                     divisions: 10,
//                   ),
                 
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //min --- max
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: selectedMinValue,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "100",
                            hintStyle: const TextStyle(
                              color: themeblackcolor,
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "To",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: selectedMaxValue,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "200",
                            hintStyle: const TextStyle(
                              color: themeblackcolor,
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomSimpleRoundedButton(
                    onTap: () {
                      log("selectedCountryValue $selectedCountryValue");

                      final propertyProvider =
                          Provider.of<properties_pro>(context, listen: false);
                      propertyProvider.getPropertiesFunc(
                          selectedPurposeValue,
                          selectedPropertyTypeValue,
                          selectedCountryValue,
                          selectedStateValue,
                          selectedCityValue,
                          locationTextC.text,
                          selectedConditionRating.toStringAsPrecision(1),
                          selectedBedRoomValue.toStringAsPrecision(1),
                          selectedBathroomValue.toStringAsPrecision(1),
                          selectedMinValue.text,
                          selectedMaxValue.text,
                          context);
                      Navigator.pop(context);
                    },
                    buttoncolor: Palette.themecolor,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(12),
                    child: const Text(
                      "FIND",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
