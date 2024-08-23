import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/property/property_components/property_vertical_images.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:widget_zoom/widget_zoom.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import '../../apis/apis_list.dart';
import '../../navigator.dart';
import '../../provider/product_pro.dart';
import '../../widgets/property_detail_slider.dart';
import '../product_details/property_pdf_view_screen.dart';
import '../product_details/widgets/property_contact_us_detail_widget.dart';
import '../product_details/widgets/property_details_widget.dart';
import '../product_details/widgets/property_overview_widget.dart';
import '../product_details/widgets/property_related_prop_widget.dart';
import 'property_components/property_card_button.dart';

// ignore: must_be_immutable
class PropertyDetailView extends StatefulWidget {
  PropertyDetailView({
    super.key,
    required this.id,
    required this.isProjectDetails,
    required this.productUrl,
  });
  final String id;
  final bool isProjectDetails;
  final String productUrl;

  @override
  State<PropertyDetailView> createState() => _PropertyDetailViewState();
}

class _PropertyDetailViewState extends State<PropertyDetailView> {
  double initialChildSize = 0.3;
  @override
  void initState() {
    if (widget.isProjectDetails == true) {
      final propertyProvider =
          Provider.of<properties_pro>(context, listen: false);
      propertyProvider.getPropertyDetails(widget.productUrl, context);
    } else {
      final DetailProvider = Provider.of<products_pro>(context, listen: false);
      DetailProvider.getProductDetails(widget.productUrl, context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Consumer<properties_pro>(
            builder: (context, modelValue, child) {
              // -- PROPERTY MAPS IMAGES

              List decodedeimages = [];
              if (modelValue.dPropertyImages.isNotEmpty) {
                decodedeimages =
                    jsonDecode(modelValue.dPropertyImages[0].toString());
              }

              // -- PROPERTY MAPS IMAGES
              List decodedPropertyMapImages = [];
              if (modelValue.dPropertyMapImages.isNotEmpty) {
                decodedPropertyMapImages =
                    jsonDecode(modelValue.dPropertyMapImages[0].toString());
              }

              return PropertyVerticalImages(
                items: (decodedeimages.isEmpty)
                    ? [modelValue.dPropertyCard]
                    : decodedeimages,
                productTitle: modelValue.dPropertyShopName,
                productDesc: modelValue.dPropertyDescription,
                isEmptyy: (decodedeimages.isEmpty) ? true : false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: primary_bg_color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                  ),
                  child: Consumer<properties_pro>(
                    builder: (context, modelValue, child) {
                      return modelValue.propertyDetailIsLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: themeredcolor,
                              ),
                            )
                          : SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Icon(
                                      initialChildSize >= 0.3
                                          // ? FontAwesome.up_open
                                          // : FontAwesome.down_open,
                                          ? FontAwesome.up_open
                                          : FontAwesome.down_open,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        modelValue.propertysIsLoading
                                            ? "Loading..."
                                            : modelValue.dPropertyPrice +
                                                " PKR",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesome.location,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                            Text(
                                              modelValue.propertyCountry[0]
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Small tags
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesome.bed,
                                          color: themegreytextcolor,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          modelValue.dPropertyBedroom,
                                          style: const TextStyle(
                                            color: themegreytextcolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          FontAwesome5.shower,
                                          color: themegreytextcolor,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          modelValue.dPropertyBathroom,
                                          style: const TextStyle(
                                            color: themegreytextcolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          ModernPictograms.grid,
                                          color: themegreytextcolor,
                                          size: 22,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : "n/a"}",
                                          style: const TextStyle(
                                            color: themegreytextcolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  // Title...
                                  Text(
                                    "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : "n/a"}, ${(modelValue.dPropertyTypeId.toString() == "1") ? "Home" : (modelValue.dPropertyTypeId.toString() == "2") ? "Plots" : (modelValue.dPropertyTypeId.toString() == "3") ? "Commercial" : "n/a"} ${(modelValue.dPropertyPurpose.toString() == "1") ? "for Rent" : (modelValue.dPropertyPurpose.toString() == "2") ? "for Sell" : "n/a"}, In ${modelValue.dPropertyLocation}, at ${modelValue.dPropertyCity}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  HtmlWidget(modelValue.dPropertyDescription
                                      .toString()),
                                  // Text(
                                  //   ,
                                  //   style: const TextStyle(
                                  //       color: themegreytextcolor),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // Adds-On
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Added on ${modelValue.dPropertyDate}",
                                        style: const TextStyle(
                                          color: themegreytextcolor,
                                        ),
                                      ),
                                      const Spacer(),
                                      modelValue.dPropertyPDF != ""
                                          ? InkWell(
                                              onTap: () {
                                                RouteNavigator.route(
                                                  context,
                                                  PropertyPdfViewScreen(
                                                    url:
                                                        getPropertyDetailPDFApi +
                                                            modelValue
                                                                .dPropertyPDF,
                                                    propertyAgency: modelValue
                                                        .dPropertyShopName,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                // height: size.height / 100 * 4,
                                                // width: size.width / 100 * 20,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      themeblackcolor
                                                          .withOpacity(0.6),
                                                      themeblackcolor
                                                          .withOpacity(0.9),
                                                    ],
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.picture_as_pdf,
                                                      color: themewhitecolor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Brochure",
                                                      style: TextStyle(
                                                        color: themewhitecolor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  // All Expansion Tiles
                                  // const Divider(
                                  //   height: 40,
                                  // ),
                                  // // -- OVERVIEW

                                  // Text(
                                  //   "Overview",
                                  //   style: TextStyle(
                                  //     fontSize: 21,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  // SizedBox(height: 10),
                                  // Container(
                                  //   padding: EdgeInsets.all(5),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //   ),
                                  //   child: propertyOverviewWidget(modelValue),
                                  // ),

                                  // SizedBox(height: 20),
                                  // Text(
                                  //   "Details",
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: propertyDetailWidget(modelValue),
                                  ),

                                  SizedBox(height: 20),

                                  contactUsDetailWidget(modelValue),

                                  SizedBox(height: 20),
                                  Text(
                                    "More Like this",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  relatedPropertyWidget(modelValue, size)
                                ],
                              ),
                            );
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Consumer<properties_pro>(
                  builder: (context, modelValue, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: GestureDetector(
                        onTap: () async {
                          await Share.share(
                              "${modelValue.dPropertyShopName}😊\n\nLink: ${getPropertyLinkShare + modelValue.dPropertyUrl}");
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          Consumer<properties_pro>(builder: (context, modelValue, child) {
        return Container(
          padding: EdgeInsets.all(20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PropertyCardButton(
                  onTap: () async {
                    var businessNo = modelValue.dPropertyBusinessEmail;
                    var emailAndroid = Uri.parse("mailto:$businessNo");
                    if (await canLaunchUrl(emailAndroid)) {
                      await launchUrl(emailAndroid);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email is not installed on the device"),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: PropertyCardButton(
                  onTap: () async {
                    if (modelValue.dPropertyPhoneNumber != "") {
                      await FlutterPhoneDirectCaller.callNumber(
                          modelValue.dPropertyPhoneNumber);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Phone Number is not available"),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Call",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: PropertyCardButton(
                  onTap: () async {
                    // testLaunchUrl();
                    // openWhatsApp(modelValue.dPropertyPhoneNumber, "message");
                    var whatsapp = modelValue.dPropertyPhoneNumber;
                    // var whatsappAndroid = Uri.parse(
                    //     "https://wa.me/$whatsapp?text=${Uri.encodeFull("message")}");
                    var whatsappAndroid = Uri.parse(
                        "https://wa.me/$whatsapp?text=${Uri.encodeFull("Hi There!")}");
                    if (await canLaunchUrl(whatsappAndroid)) {
                      await launchUrl(whatsappAndroid);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "WhatsApp is not installed on the device...................",
                          ),
                        ),
                      );
                    }
                  },
                  isGreen: true,
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesome.whatsapp,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Whatsapp",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void openWhatsApp(String phoneNumber, String message) async {
    final whatsappUrl =
        'https://wa.me/${phoneNumber.replaceFirst("0", "92")}?text=${Uri.encodeFull(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      print("Could not launch $whatsappUrl");
    }
  }

  void testLaunchUrl() async {
    const url = 'https://flutter.dev';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }

  List images = [
    'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyaminmellish-186077.jpg&fm=jpg',
    'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
    'https://assets-us-01.kc-usercontent.com/0542d611-b6d8-4320-a4f4-35ac5cbf43a6/57134553-0077-4e93-8cfd-58895d271ef8/homeowners-insurance-facebook.jpg',
    'https://images.ctfassets.net/n2ifzifcqscw/2Wv8SIq1OJusLJJbrbygAC/4c9cadb476862254bba99be62d242452/craftsman.png',
  ];
}
