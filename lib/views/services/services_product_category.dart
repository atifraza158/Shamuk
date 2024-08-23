import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/dummy_models/dummy_models.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:multivendor/views/services/service_detail_screen.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/custom_text_button.dart';
import 'package:multivendor/widgets/image_slider.dart';
import 'package:multivendor/widgets/image_slider_two.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'modal/services_filters_bottem_sheet.dart';

class ServicesProductCategoryScreen extends StatefulWidget {
  final int serviceId;
  final String tilte;

  const ServicesProductCategoryScreen({
    Key? key,
    required this.serviceId,
    required this.tilte,
  }) : super(key: key);

  @override
  State<ServicesProductCategoryScreen> createState() =>
      _ServicesProductCategoryScreenState();
}

class _ServicesProductCategoryScreenState
    extends State<ServicesProductCategoryScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int activeIndex = 0;

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  void initState() {
    final servicesProvider = Provider.of<services_pro>(context, listen: false);
    servicesProvider.getServicesByServicesIdFunc(
        widget.serviceId.toString(), "", "", "", "", "", "", "", "", context);

    super.initState();
  }

  // final servicesCategoryModel = [
  //   "Service",
  //   "Plumber",
  //   "Carpenter",
  //   "Electrician",
  //   "HVAC Technician",
  //   "Painter",
  //   "Mason",
  //   "Roofing Contractor",
  //   "Locksmith",
  //   "Plasterer/Drywaller",
  //   "Landscaper",
  //   "Flooring Installer",
  //   "Pest Control Technician",
  //   "Appliance Repair Technician",
  //   "Handyman",
  //   "Window Installer",
  //   "Tiler",
  //   "Insulation Installer",
  //   "Glazier",
  //   "Septic Tank Service Technician",
  //   "Fence Installer",
  // ];

  launchWhatsAppUri(String phoneNumber) async {
    // final link = WhatsAppUnilink(
    //   phoneNumber: phoneNumber,
    //   text: "Hey! I'm inquiring about the apartment listing",
    // );
    // await launchUrl(link.asUri());

    var androidUrl = "whatsapp://send?phone=$phoneNumber&text=Hi,";
    var iosUrl = "https://wa.me/$phoneNumber?text=${Uri.parse('Hi,')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("WhatsApp is not installed"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    log("widget.serviceId: ${widget.serviceId}");
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: size.width,
            color: themedarkgreycolor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Get Matched with Local Professionals",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
//filters
                CustomOutlinedButton(
                  onTap: () async {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      context: context,
                      builder: (context) => SizedBox(
                        height: size.height / 100 * 70,
                        child: ServicesFiltersBottomSheet(
                          serviceId: widget.serviceId,
                        ),
                      ),
                    );
                  },
                  height: 55,
                  width: size.width,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: themewhitecolor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.poll,
                          color: themewhitecolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "SERVICE FILTERS",
                          style: TextStyle(
                            color: themewhitecolor,
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
          const SizedBox(
            height: 15,
          ),
          Consumer<services_pro>(builder: ((context, modelValue, child) {
            return modelValue.servicesIsLoading
                ? loadingShimmer(size)
                : modelValue.profFirstName.isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/png/no_professionals.png",
                          height: 350,
                          width: 350,
                        ),
                      )
                    : ListView.separated(
                        itemCount: modelValue.profFirstName.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            color: themedarkgreycolor,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              children: [
                                CarouselSlider(
                                  items: List.generate(
                                      modelValue.profServiceCard.length,
                                      (sliderindex) {
                                    log("modelValue.profServiceCard.length: ${modelValue.profServiceCard.length}");
                                    return Image.network(
                                      getServiceCardApi +
                                          modelValue.profServiceCard[index],
                                      width: size.width,
                                      fit: BoxFit.cover,
                                    );
                                  }),
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    autoPlay: false,
                                    height: 220,
                                    autoPlayCurve:
                                        Curves.fastLinearToSlowEaseIn,
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 2),
                                    viewportFraction: 1,
                                    onPageChanged: (pageindex, reason) {
                                      setActiveDot(pageindex);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 190,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                getServiceProfileCardApi +
                                                    modelValue.profProfileCard[
                                                        index]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 45.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                modelValue
                                                    .profServiceCard.length,
                                                (idx) {
                                                  return activeIndex == idx
                                                      ? const ActiveDot()
                                                      : const InactiveDot();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        modelValue.profFirstName[index] +
                                            " " +
                                            modelValue.profLastName[index],
                                        style: const TextStyle(
                                          color: themewhitecolor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: themeorangecolor,
                                          ),
                                          Text(
                                            " (${modelValue.profRating[index]} Reviews)",
                                            style: const TextStyle(
                                              color: themewhitecolor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.category_sharp,
                                            color: themewhitecolor,
                                          ),
                                          Text(
                                            " ${servicesmodel[int.parse(modelValue.profServiceId[index]) - 1].title}",
                                            // "${widget.tilte}",
                                            style: TextStyle(
                                              color: themewhitecolor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.verified_user_sharp,
                                            size: 25,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Verified By Shamuk",
                                            style: TextStyle(
                                              color: themewhitecolor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 85,
                                            child: InkWell(
                                              onTap: () async {
                                                if (modelValue
                                                        .dProfEmail[index] !=
                                                    "") {
                                                 
                                                  var businessNo = modelValue
                                                      .dProfEmail[index];
                                                  var emailAndroid = Uri.parse(
                                                      "mailto:$businessNo");
                                                  try {
                                                    await launchUrl(
                                                        emailAndroid);
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Email is not installed on the device"),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Phone Number is not available"),
                                                  ));
                                                }
                                              },
                                              child:
                                                  //  Lottie.asset(
                                                  //     'assets/images/animated/call_button.json',
                                                  //     fit: BoxFit.cover),
                                                  CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.green,
                                                child: Icon(
                                                  Icons.email,
                                                  color: themewhitecolor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          CustomSimpleRoundedButton(
                                            onTap: () {
                                              if (modelValue.profPhone[index] !=
                                                  "") {
                                                launchWhatsAppUri(modelValue
                                                    .profPhone[index]);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Phone Number is not available"),
                                                ));
                                              }
                                            },
                                            height: 55,
                                            width: size.width / 100 * 30,
                                            buttoncolor: Palette.themecolor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.call,
                                                  color: themewhitecolor,
                                                  size: 28,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Whatsapp",
                                                  style: TextStyle(
                                                    color: themewhitecolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CustomSimpleRoundedButton(
                                            onTap: () {
                                              RouteNavigator.route(
                                                  context,
                                                  ServiceDetailScreen(
                                                    serviceProfessionalUrl:
                                                        modelValue
                                                            .profUrl[index],
                                                  ));
                                            },
                                            height: 55,
                                            width: size.width / 100 * 30,
                                            buttoncolor: Palette.themecolor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.remove_red_eye,
                                                  color: themewhitecolor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "View",
                                                  style: TextStyle(
                                                    color: themewhitecolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, separator) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                      );
          }))
        ],
      ),
    );
  }

  Future<Object?> enableLocationAccess(context, size) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: SizedBox(
          height: size.height / 100 * 55,
          child: Column(
            children: [
              const Text(
                "See Local Pros",
                style: TextStyle(
                  color: themeblackcolor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "To see local pros who can work on your project, please enable location access",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeblackcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                "assets/images/svg/enable-location-1.svg",
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomSimpleRoundedButton(
                onTap: () {},
                buttoncolor: Palette.themecolor,
                height: 50,
                width: size.width,
                borderRadius: BorderRadius.circular(8),
                child: const Text(
                  "Enable Location Access",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextButton(
                buttonText: "Not Now",
                onTap: () {
                  Navigator.pop(context);
                },
                textstyle: const TextStyle(
                  color: themedarkgreycolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Object?> getInTouch(size) {
    return showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          titlePadding: const EdgeInsets.all(24),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: SizedBox(
            width: size.width / 100 * 95,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel_outlined),
                    ),
                  ),
                  const Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'For more information, please fill out the form and our team will get back to you',
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name",
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
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
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
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: themegreycolor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CountryCodePicker(
                                onChanged: print,
                                initialSelection: 'PK',
                                favorite: ['+92', 'PK'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                showDropDownButton: true,
                                textStyle: TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                padding: EdgeInsets.all(0),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone number",
                              hintStyle: TextStyle(
                                color: themeblackcolor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description",
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
                    height: 30,
                  ),
                  CustomSimpleRoundedButton(
                    onTap: () {
                      // RouteNavigator.pushandremoveroute(
                      //   context,
                      //   NavBar(
                      //     selectedTab: 1,
                      //   ),
                      // );
                    },
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    buttoncolor: Palette.themecolor,
                    borderRadius: BorderRadius.circular(8),
                    child: Text(
                      "Request Info".toUpperCase(),
                      style: const TextStyle(
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
