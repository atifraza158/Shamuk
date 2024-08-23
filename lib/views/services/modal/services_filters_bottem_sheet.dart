import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class ServicesFiltersBottomSheet extends StatefulWidget {
  final int serviceId;

  ServicesFiltersBottomSheet({Key? key, required this.serviceId})
      : super(key: key);

  @override
  State<ServicesFiltersBottomSheet> createState() =>
      _ServicesFiltersBottomSheetState();
}

class _ServicesFiltersBottomSheetState
    extends State<ServicesFiltersBottomSheet> {
  //filters values

  bool selectedQuickValue = false;
  bool selectedAvailableValue = false;
  bool selectedProfessionalValue = false;
  bool selectedQualityValue = false;
  String selectedCountryValue = "0";
  String selectedStateValue = "0";
  String selectedCityValue = "0";
  String selectedServiceValue = "0";

  ///

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
    "Select Service",
    "Interior Designers & Decorators",
    "Kitchen & Bathroom Remodelers",
    "Hardwood Flooring Dealers",
    "Architects & Building Designers",
    "Home Builders",
    "Painters",
    "Design-Build Firms",
    "Roofing & Gutters",
    "Landscape Contractors",
    "Kitchen & Bathroom Designers",
    "Cabinets & Cabinetry",
    "Landscape Architects & Landscape Designers",
    "Appliance Repair Technician",
    "General Contractors",
    "Tile & Stone",
    "Home Stagers",
    "Swimming Pool Builders",
    "Plumbers",
    "Event Planner",
    "Digital Solutions",
    "Travel Partners",
    "Solar Solutions",
    "Others",
  ];
  String? selectedserviceitems = 'Select Service';

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
          backgroundColor: themewhitecolor,
          centerTitle: true,
          elevation: 1,
          title: const Text(
            "Service Filters",
            style:
                TextStyle(color: themeblackcolor, fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          // bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(5),
          //     child: Container(
          //       decoration: const BoxDecoration(
          //         border: Border(
          //           bottom: BorderSide(
          //             color: themegreycolor,
          //           ),
          //         ),
          //       ),
          //     )),
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
                        "Tell us what you need",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<services_pro>(
                          builder: ((context, modelValue, child) {
                        return modelValue.servicesIsLoading == true
                            ? CustomSimpleRoundedButton(
                                onTap: () {},
                                buttoncolor: themeorangecolor,
                                height: size.height / 100 * 4,
                                width: size.width / 100 * 20,
                                borderRadius: BorderRadius.circular(12),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: themewhitecolor,
                                  ),
                                ))
                            : CustomSimpleRoundedButton(
                                onTap: () {
                                  final servicesProvider =
                                      Provider.of<services_pro>(context,
                                          listen: false);
                                  servicesProvider.getServicesByServicesIdFunc(
                                      widget.serviceId.toString(),
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      context);
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
                              );
                      }))
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  //quick response -- 24/7 available
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedQuickValue = !selectedQuickValue;

                                log("selectedQuickValue: $selectedQuickValue");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: selectedQuickValue
                                    ? Palette.themecolor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: selectedQuickValue
                                        ? themewhitecolor
                                        : Palette.themecolor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Quick Response",
                                    style: TextStyle(
                                      color: selectedQuickValue
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //24/7

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedAvailableValue =
                                    !selectedAvailableValue;

                                log("selectedAvailableValue: $selectedAvailableValue");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: selectedAvailableValue
                                    ? Palette.themecolor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_available,
                                    color: selectedAvailableValue
                                        ? themewhitecolor
                                        : Palette.themecolor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "24/7 Available",
                                    style: TextStyle(
                                      color: selectedAvailableValue
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
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

                  //proffesional service -- quality work
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedProfessionalValue =
                                    !selectedProfessionalValue;

                                log("selectedProfessionalValue: $selectedProfessionalValue");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: selectedProfessionalValue
                                    ? Palette.themecolor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.design_services,
                                    color: selectedProfessionalValue
                                        ? themewhitecolor
                                        : Palette.themecolor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Professional Service",
                                    style: TextStyle(
                                      color: selectedProfessionalValue
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //quality work

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedQualityValue = !selectedQualityValue;

                                log("selectedQualityValue: $selectedQualityValue");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: selectedQualityValue
                                    ? Palette.themecolor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: selectedQualityValue
                                        ? themewhitecolor
                                        : Palette.themecolor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Quality Work",
                                    style: TextStyle(
                                      color: selectedQualityValue
                                          ? themewhitecolor
                                          : themeblackcolor,
                                      fontSize: 15,
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

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Country",
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
                      value: selectedcountryitems,
                      items: countryitems
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
                        // setState(
                        //   () => selectedcountryitems != item,
                        // );

                        setState(() {
                          selectedcountryitems != item;
                          for (var i = 0; i < countryitems.length; i++) {
                            if (countryitems[i] == item) {
                              log("i: $i");

                              setState(() {
                                selectedCountryValue = i.toString();
                              });
                              log("selectedCountryValue: $selectedCountryValue");
                            }
                          }
                        });
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  (selectedCountryValue != "0")
                      ? Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.place,
                                  color: Palette.themecolor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "State",
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
                                value: selectedstateitems,
                                items: stateitems
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
                                  for (var i = 0; i < stateitems.length; i++) {
                                    if (stateitems[i] == item) {
                                      log("i: $i");

                                      setState(() {
                                        selectedStateValue = i.toString();
                                      });
                                      log("selectedStateValue: $selectedStateValue");
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : Container(),

                  (selectedStateValue != "0")
                      ? Column(
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.place,
                                  color: Palette.themecolor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "City",
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
                                value: selectedcityitems,
                                items: cityitems
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
                                  for (var i = 0; i < cityitems.length; i++) {
                                    if (cityitems[i] == item) {
                                      log("i: $i");

                                      setState(() {
                                        selectedCityValue = i.toString();
                                      });
                                      log("selectedCityValue: $selectedCityValue");
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : Container(),

                  //service
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.place,
                            color: Palette.themecolor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Service",
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
                          value: selectedserviceitems,
                          items: serviceitems
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
                            for (var i = 0; i < serviceitems.length; i++) {
                              if (serviceitems[i] == item) {
                                log("i: $i");

                                setState(() {
                                  selectedServiceValue = i.toString();
                                });
                                log("selectedServiceValue: $selectedServiceValue");
                              }
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                  CustomSimpleRoundedButton(
                    onTap: () {
                      final servicesProvider =
                          Provider.of<services_pro>(context, listen: false);
                      servicesProvider.getServicesByServicesIdFunc(
                          selectedServiceValue,
                          (selectedQualityValue ? "1" : "0"),
                          (selectedProfessionalValue ? "1" : "0"),
                          (selectedAvailableValue ? "1" : "0"),
                          (selectedQuickValue ? "1" : "0"),
                          "",
                          selectedCityValue,
                          selectedStateValue,
                          selectedCountryValue,
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
