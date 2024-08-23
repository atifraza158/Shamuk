import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/orders/review/leave_reaview_screen.dart';
import 'package:multivendor/views/services/PropertyDescriptionBottomSheet.dart';
import 'package:multivendor/views/services/view_professional_pdf.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/html_render.dart';
import 'package:multivendor/widgets/professional_detail_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ServiceDetailScreen extends StatefulWidget {
  String serviceProfessionalUrl;

  ServiceDetailScreen({Key? key, required this.serviceProfessionalUrl})
      : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  void initState() {
    final serviceProfessionalProvider =
        Provider.of<services_pro>(context, listen: false);
    serviceProfessionalProvider.getProfessionalDetailsFunc(
        widget.serviceProfessionalUrl, context);
    super.initState();
  }

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

  final servicesCategoryModel = [
    "Service",
    "Plumber",
    "Carpenter",
    "Electrician",
    "HVAC Technician",
    "Painter",
    "Mason",
    "Roofing Contractor",
    "Locksmith",
    "Plasterer/Drywaller",
    "Landscaper",
    "Flooring Installer",
    "Pest Control Technician",
    "Appliance Repair Technician",
    "Handyman",
    "Window Installer",
    "Tiler",
    "Insulation Installer",
    "Glazier",
    "Septic Tank Service Technician",
    "Fence Installer",
  ];

  @override
  Widget build(BuildContext context) {
    log("serviceProfessionalUrl: ${widget.serviceProfessionalUrl}");
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themewhitecolor,
          elevation: 2,
          iconTheme: const IconThemeData(color: Palette.themecolor),
          titleTextStyle: const TextStyle(
            color: themeblackcolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          title: const Text("Professional Detail's"),
        ),
        bottomNavigationBar:
            Consumer<services_pro>(builder: ((context, modelValuee, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: themewhitecolor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: themegreycolor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomSimpleRoundedButton(
                      onTap: () async {
                        var businessNo = modelValuee.dProfEmail;
                        var emailAndroid = Uri.parse("mailto:$businessNo");
                        try {
                          await launchUrl(emailAndroid);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Email is not installed on the device"),
                            ),
                          );
                        }
                      },
                      height: 48,
                      width: size.width / 100 * 35,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(12),
                      child: const Icon(
                        Icons.email,
                        color: themewhitecolor,
                        size: 28,
                      ),
                    ),
                  ),

                  //whatsapp
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomSimpleRoundedButton(
                      onTap: () async {
                        var whatsapp = modelValuee.dProfPhone;
                        if (whatsapp.isNotEmpty) {
                          launchWhatsAppUri(whatsapp);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Phone Number is not available"),
                          ));
                        }
                      },
                      height: 48,
                      width: size.width / 100 * 30,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  ),

                  SizedBox(
                    height: 85,
                    child: InkWell(
                      onTap: () async {
                        var whatsapp = modelValuee.dProfPhone;
                        if (whatsapp.isNotEmpty) {
                          await FlutterPhoneDirectCaller.callNumber(
                              modelValuee.dProfPhone);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Phone Number is not available"),
                          ));
                        }
                      },
                      child: Lottie.asset(
                          'assets/images/animated/call_button.json',
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
          );
        })),
        body: Consumer<services_pro>(builder: ((context, modelValue, child) {
          if (modelValue.dProfDetailIsLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            log("images: ${modelValue.dProfImagesName}");

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ProfessionalDetailSlider(
                      items: modelValue.dProfImagesName,
                      productTitle:
                          "${modelValue.dProfFirstName} ${modelValue.dProfLastName}",
                      productDesc: modelValue.dProfEmail,
                      isEmptyy:
                          (modelValue.dProfImagesName.isEmpty) ? true : false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Professional Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //HEADING
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Palette.themecolor.withOpacity(0.6),
                                    Palette.themecolor,
                                  ],
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "PROFESSIONAL DETAILS",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: themewhitecolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),

                            //CONTAINER
                            PhysicalModel(
                              color: themewhitecolor,
                              elevation: 2,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: getServiceProfileCardApi +
                                              modelValue.dProfProfileCard,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: size.height / 100 * 15,
                                            width: size.width / 100 * 25,
                                            decoration: BoxDecoration(
                                              color: themegreycolor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    getServiceProfileCardApi +
                                                        modelValue
                                                            .dProfProfileCard),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: themegreycolor,
                                            highlightColor: themegreytextcolor,
                                            child: Container(
                                              height: size.height / 100 * 15,
                                              width: size.width / 100 * 25,
                                              decoration: BoxDecoration(
                                                color: themegreycolor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${modelValue.dProfFirstName} ${modelValue.dProfLastName}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: themeorangecolor,
                                                  ),
                                                  Text(
                                                    " ( ${modelValue.dProfRating} Reviews)",
                                                    style: TextStyle(
                                                      color: themegreytextcolor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              (modelValue.dProfPdf == "null")
                                                  ? Container()
                                                  : Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomEnd,
                                                      child:
                                                          CustomSimpleRoundedButton(
                                                        onTap: () {
                                                          RouteNavigator.route(
                                                              context,
                                                              ViewProfessionalPdfViewScreen(
                                                                  url: getServiceProfessiobalDetailPDFApi +
                                                                      modelValue
                                                                          .dProfPdf));
                                                        },
                                                        height: size.height /
                                                            100 *
                                                            5,
                                                        width: size.width /
                                                            100 *
                                                            50,
                                                        buttoncolor:
                                                            Palette.themecolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              color:
                                                                  themewhitecolor,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "View PDF",
                                                              style: TextStyle(
                                                                color:
                                                                    themewhitecolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      height: 40,
                                    ),
                                    Text(
                                      " ${servicesCategoryModel[int.parse(modelValue.dProfServiceId)]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //Quick Response
                                    (modelValue.dProfQuick == "1")
                                        ? Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Palette.themecolor,
                                                size: 15,
                                              ),
                                              Text(
                                                " Quick Response",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //24/7 Avalible
                                    (modelValue.dProfAvailable == "1")
                                        ? Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Palette.themecolor,
                                                size: 15,
                                              ),
                                              Text(
                                                " 24/7 Avalible",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //Professional Service
                                    (modelValue.dProfProfessional == "1")
                                        ? Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Palette.themecolor,
                                                size: 15,
                                              ),
                                              Text(
                                                " Professional Service",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //Quality Work
                                    (modelValue.dProfQuality == "1")
                                        ? Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Palette.themecolor,
                                                size: 15,
                                              ),
                                              Text(
                                                " Quality Work",
                                                style: TextStyle(
                                                  color: themegreytextcolor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),

                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.all(12),
                          backgroundColor: themewhitecolor,
                          collapsedBackgroundColor: Palette.themecolor,
                          textColor: Palette.themecolor,
                          collapsedTextColor: themewhitecolor,
                          iconColor: Palette.themecolor,
                          collapsedIconColor: themewhitecolor,
                          leading: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.local_activity,
                              size: 25,
                              // color: themewhitecolor,
                            ),
                          ),
                          title: const Text(
                            "DESCRIPTION",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: HtmlRenderCustom(
                                  text: modelValue.dProfDescription,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              // Text(
                              //   (modelValue.dProfDescription == "null")
                              //       ? "Description not available"
                              //       : modelValue.dProfDescription,
                              //   textAlign: TextAlign.justify,

                              // ),
                            )
                          ],
                        ),

                        // SizedBox(
                        //   height: size.height / 100 * 2,
                        // ),

                        // //PROJECTS

                        // ExpansionTile(
                        //   tilePadding: EdgeInsets.zero,
                        //   childrenPadding: const EdgeInsets.all(12),
                        //   backgroundColor: themewhitecolor,
                        //   collapsedBackgroundColor: Palette.themecolor,
                        //   textColor: Palette.themecolor,
                        //   collapsedTextColor: themewhitecolor,
                        //   iconColor: Palette.themecolor,
                        //   collapsedIconColor: themewhitecolor,
                        //   leading: Container(
                        //     padding: const EdgeInsets.all(5),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     child: const Icon(
                        //       Icons.local_activity,
                        //       size: 25,
                        //       // color: themewhitecolor,
                        //     ),
                        //   ),
                        //   title: const Text(
                        //     "PROJECTS",
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   children: [
                        //     professionalDetailWidget(size),
                        //   ],
                        // ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),

                        //RATINGS & REVIEWS
                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.all(12),
                          backgroundColor: themewhitecolor,
                          collapsedBackgroundColor: Palette.themecolor,
                          textColor: Palette.themecolor,
                          collapsedTextColor: themewhitecolor,
                          iconColor: Palette.themecolor,
                          collapsedIconColor: themewhitecolor,
                          leading: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.local_activity,
                              size: 25,
                              // color: themewhitecolor,
                            ),
                          ),
                          title: const Text(
                            "Review / Ranting",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            professionalReviewRatingWidget(
                                modelValue, size, context)
                          ],
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),
                        //Contact Details column
                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.all(12),
                          backgroundColor: themewhitecolor,
                          collapsedBackgroundColor: Palette.themecolor,
                          textColor: Palette.themecolor,
                          collapsedTextColor: themewhitecolor,
                          iconColor: Palette.themecolor,
                          collapsedIconColor: themewhitecolor,
                          leading: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.local_activity,
                              size: 25,
                              // color: themewhitecolor,
                            ),
                          ),
                          title: const Text(
                            "Info",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            professsionalContactWidget(modelValue),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        })));
  }

  PhysicalModel professsionalContactWidget(services_pro modelValue) {
    return PhysicalModel(
      color: themewhitecolor,
      elevation: 2,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Agency
            PhysicalModel(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        "Agency",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${modelValue.dProfFirstName} ${modelValue.dProfLastName}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Email
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Email",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      modelValue.dProfEmail,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            PhysicalModel(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: const Text(
                        "Phone",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        modelValue.dProfPhone,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column professionalReviewRatingWidget(
      services_pro modelValue, Size size, BuildContext context) {
    return Column(
      children: [
        (modelValue.dProfReviewsUser.isEmpty)
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                    (modelValue.dProfReviewsUser.length >= 3)
                        ? 3
                        : modelValue.dProfReviewsUser.length, (index) {
                  return Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: themegreycolor,
                          blurRadius: 5.0,
                          offset: Offset(1, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Palette.themecolor,
                                  backgroundImage: AssetImage(
                                      "assets/images/png/projects.png"),
                                ),
                                SizedBox(width: size.width / 100 * 2),
                                Text(
                                  modelValue.dProfReviewsUser[index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(
                                int.parse(modelValue.dProfReviewsRating[index]),
                                (index) => const Icon(
                                  Icons.star,
                                  color: themeorangecolor,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          modelValue.dProfReviewsReview[index],
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Text(
                            modelValue.dProfReviewsDate[index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                }),
              ),
        (modelValue.dProfReviewsUser.length >= 2)
            ? TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      context: context,
                      builder: (context) => ProfessionalReviewsBottomSheet(
                          propertyTitle: "Hello",
                          propertyDescription: "dsfsdf",
                          modelValue: modelValue));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("View All Reviews"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.keyboard_capslock,
                    )
                  ],
                ))
            : Container(),
      ],
    );
  }

  Consumer<properties_pro> professionalDetailWidget(Size size) {
    return Consumer<properties_pro>(builder: ((context, modelValue, child) {
      return modelValue.propertysIsLoading
          ? loadingShimmer(size)
          : modelValue.propertyUrl.isEmpty
              ? Center(
                  child: Image.asset(
                    "assets/images/png/404.png",
                    height: 250,
                    width: 250,
                  ),
                )
              : SizedBox(
                  height: 260,
                  child: GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: modelValue.propertyUrl.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // RouteNavigator.route(
                              //   context,
                              //    ServiceDetailScreen(
                              //     isProjectDetails: true,
                              //     productUrl: modelValue.propertyUrl[index],
                              //   ),
                              // );
                            },
                            child: CachedNetworkImage(
                              imageUrl: getPropertyCardApi +
                                  modelValue.propertyCard[index],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 140,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: themegreycolor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      getPropertyCardApi +
                                          modelValue.propertyCard[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: themegreycolor,
                                highlightColor: themegreytextcolor,
                                child: Container(
                                  width: size.width,
                                  height: 200.0,
                                  decoration: const BoxDecoration(
                                    color: themegreycolor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 140.0),
                            child: Container(
                              width: size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                // color: themegreycolor,
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    themegreycolor,
                                    themegreycolor,
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                boxShadow: [
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
                                    children: [
                                      Text(
                                        (modelValue.propertyTypeId[index]
                                                    .toString() ==
                                                "1")
                                            ? "Home"
                                            : (modelValue.propertyTypeId[index]
                                                        .toString() ==
                                                    "2")
                                                ? "Plots"
                                                : (modelValue.propertyTypeId[
                                                                index]
                                                            .toString() ==
                                                        "3")
                                                    ? "Commerical"
                                                    : "",
                                        style: const TextStyle(
                                          color: themegreytextcolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (modelValue.propertyPurpose[index]
                                                    .toString() ==
                                                "1")
                                            ? " for Rent"
                                            : (modelValue.propertyTypeId[index]
                                                        .toString() ==
                                                    "2")
                                                ? " for Sell"
                                                : " for ",
                                        style: const TextStyle(
                                          color: themegreytextcolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${modelValue.propertyPrice[index]} PKR",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${modelValue.propertyArea[index]} ${(modelValue.propertyAreaUnit[index].toString() == "1") ? "Marla" : (modelValue.propertyAreaUnit[index].toString() == "2") ? "Square Feet" : (modelValue.propertyAreaUnit[index].toString() == "3") ? "Square Yards" : (modelValue.propertyAreaUnit[index].toString() == "4") ? "Square Meters" : (modelValue.propertyAreaUnit[index].toString() == "5") ? "Kanal" : ""}, ${(modelValue.propertyTypeId[index].toString() == "1") ? "Home" : (modelValue.propertyTypeId[index].toString() == "2") ? "Plots" : (modelValue.propertyTypeId[index].toString() == "3") ? "Commercial" : ""} ${(modelValue.propertyPurpose[index].toString() == "1") ? "for Rent" : (modelValue.propertyPurpose[index].toString() == "2") ? "for Sell" : ""}, In ${modelValue.propertyLocation[index]}, at ${modelValue.propertyCity[index]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themegreytextcolor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                        ],
                      );
                    },
                  ),
                );
    }));
  }

  Widget loadingShimmer(size) {
    return Shimmer.fromColors(
      baseColor: themegreycolor,
      highlightColor: themegreytextcolor,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: themegreycolor,
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: size.width / 100 * 75,
            height: 30.0,
            decoration: BoxDecoration(
              color: themegreycolor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  overview_widget(properties_pro modelValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Type
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    (modelValue.dPropertyTypeId.toString() == "1")
                        ? "Home"
                        : (modelValue.dPropertyTypeId.toString() == "2")
                            ? "Plots"
                            : (modelValue.dPropertyTypeId.toString() == "3")
                                ? "Commerical"
                                : "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Baths
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Baths",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  modelValue.dPropertyBathroom,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

//bedrooms
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Bedrooms",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    modelValue.dPropertyBedroom,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Baths
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Purpose",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  (modelValue.dPropertyPurpose.toString() == "1")
                      ? " Rent"
                      : (modelValue.dPropertyTypeId.toString() == "2")
                          ? " Sell"
                          : " ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        //area
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Area",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : ""}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

//Condition
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Condition",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${modelValue.dPropertyCondition}/10",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
