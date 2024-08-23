import 'dart:convert';
import 'dart:developer';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:lottie/lottie.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/cart_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/login_screen.dart';
import 'package:multivendor/views/orders/review/leave_reaview_screen.dart';
import 'package:multivendor/views/product_details/product_details_reviews_screen.dart';
import 'package:multivendor/views/product_details/property_pdf_view_screen.dart';
import 'package:multivendor/views/product_details/widgets/property_contact_us_detail_widget.dart';
import 'package:multivendor/views/product_details/widgets/property_related_prop_widget.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/expandable_text_widget.dart';
import 'package:multivendor/widgets/filled_box.dart';
import 'package:multivendor/widgets/html_render.dart';
import 'package:multivendor/widgets/image_slider.dart';
import 'package:multivendor/widgets/image_slider_ebazar.dart';
import 'package:multivendor/widgets/outlined_box.dart';
import 'package:multivendor/widgets/product_detail_slider.dart';
import 'package:multivendor/widgets/property_detail_slider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'widgets/property_details_widget.dart';
import 'widgets/property_map_images_widget.dart';
import 'widgets/property_overview_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final bool? isProjectDetails;
  final String productUrl;

  ProductDetailsScreen({
    Key? key,
    required this.isProjectDetails,
    required this.productUrl,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // int? selectedsize;
  int? selectedcolor;
  String fetchedColor = "";
  int? selectedSize;
  String fetchedSize = "";

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
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

  launchWhatsAppUri(String phoneNumber) async {
    final link = WhatsAppUnilink(
      phoneNumber: phoneNumber,
      text: "Hey! I'm inquiring about the apartment listing",
    );
    await launchUrl(link.asUri());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return widget.isProjectDetails == true
        ? projectDetails(size)
        : productDetails(size);
  }

  Widget projectDetails(size) {
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: themewhitecolor,
          elevation: 0,
          iconTheme: IconThemeData(color: Palette.themecolor),
          titleTextStyle: TextStyle(
            color: themeblackcolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          title: Text("Property Detail's"),
        ),
        bottomNavigationBar:
            Consumer<properties_pro>(builder: ((context, modelValuee, child) {
          return Padding(
            padding: EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: themewhitecolor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CustomSimpleRoundedButton(
                      onTap: () async {
                        var businessNo = modelValuee.dPropertyBusinessEmail;
                        var emailAndroid = Uri.parse("mailto:$businessNo");
                        if (await canLaunchUrl(emailAndroid)) {
                          await launchUrl(emailAndroid);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            color: themewhitecolor,
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //whatsapp
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CustomSimpleRoundedButton(
                      onTap: () async {
                        var whatsapp = modelValuee.dPropertyPhoneNumber;
                        var whatsappAndroid = Uri.parse(
                            "whatsapp://send?phone=$whatsapp&text=Hell Hassaan Ali Here");
                        if (await canLaunchUrl(whatsappAndroid)) {
                          await launchUrl(whatsappAndroid);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "WhatsApp is not installed on the device"),
                            ),
                          );
                        }
                      },
                      height: 48,
                      width: size.width / 100 * 30,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                        if (modelValuee.dPropertyPhoneNumber != "") {
                          await FlutterPhoneDirectCaller.callNumber(
                              modelValuee.dPropertyPhoneNumber);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Phone Number is not available"),
                            ),
                          );
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
        body: Consumer<properties_pro>(builder: ((context, modelValue, child) {
          if (modelValue.propertyDetailIsLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            // -- PROPERTY SLIDER IMAGES
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

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  image slider
                  PropertyDetailSlider(
                    items: (decodedeimages.isEmpty)
                        ? [modelValue.dPropertyCard]
                        : decodedeimages,
                    productTitle: modelValue.dPropertyShopName,
                    productDesc: modelValue.dPropertyDescription,
                    isEmptyy: (decodedeimages.isEmpty) ? true : false,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Rs.${modelValue.dPropertyPrice}/-",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Palette.themecolor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                modelValue.dPropertyCountry,
                                style: TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bed,
                                color: themegreytextcolor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                modelValue.dPropertyBedroom,
                                style: TextStyle(
                                  color: themegreytextcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.shower,
                                color: themegreytextcolor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                modelValue.dPropertyBathroom,
                                style: TextStyle(
                                  color: themegreytextcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.code,
                                color: themegreytextcolor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : ""}",
                                style: TextStyle(
                                  color: themegreytextcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : ""}, ${(modelValue.dPropertyTypeId.toString() == "1") ? "Home" : (modelValue.dPropertyTypeId.toString() == "2") ? "Plots" : (modelValue.dPropertyTypeId.toString() == "3") ? "Commercial" : ""} ${(modelValue.dPropertyPurpose.toString() == "1") ? "for Rent" : (modelValue.dPropertyPurpose.toString() == "2") ? "for Sell" : ""}, In ${modelValue.dPropertyLocation}, at ${modelValue.dPropertyCity}",
                        // style:  TextStyle(
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        // ),
                        Text(
                          modelValue.dPropertyTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // HtmlRenderCustom(
                        //   text: modelValue.dPropertyDescription,
                        //   style:  TextStyle(color: themegreytextcolor),
                        // ),
                        // Text(
                        //   modelValue.dPropertyDescription,
                        //   style:  TextStyle(color: themegreytextcolor),
                        // ),
                        //  SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Added on ${modelValue.dPropertyDate}",
                                style: TextStyle(
                                  color: themegreytextcolor,
                                ),
                              ),
                              Spacer(),
                              modelValue.dPropertyPDF != ""
                                  ? InkWell(
                                      onTap: () {
                                        RouteNavigator.route(
                                            context,
                                            PropertyPdfViewScreen(
                                              url: getPropertyDetailPDFApi +
                                                  modelValue.dPropertyPDF,
                                              propertyAgency:
                                                  modelValue.dPropertyShopName,
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        height: size.height / 100 * 5,
                                        width: size.width / 100 * 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              themeblackcolor.withOpacity(0.6),
                                              themeblackcolor.withOpacity(0.9),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              IconButton(
                                  splashRadius: 20,
                                  onPressed: () async {
                                    await Share.share(
                                        "${modelValue.dPropertyShopName}😊\n\nLink: ${getPropertyLinkShare + modelValue.dPropertyUrl}");
                                    // FlutterClipboard.copy(getPropertyLinkShare +
                                    //         modelValue.dPropertyUrl)
                                    //     .then((value) {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar( SnackBar(
                                    //           content: Text("Link Copied")));
                                    // });
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.green,
                                  ))
                            ]),

                        Divider(
                          height: 40,
                        ),
                        // -- OVERVIEW
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(12),
                            backgroundColor: themewhitecolor,
                            collapsedBackgroundColor: Palette.themecolor,
                            textColor: Palette.themecolor,
                            collapsedTextColor: themewhitecolor,
                            iconColor: Palette.themecolor,
                            collapsedIconColor: themewhitecolor,
                            title: Text(
                              "OVERVIEW",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              propertyOverviewWidget(modelValue),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),
                        // -- DETAILS
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(12),
                            backgroundColor: themewhitecolor,
                            collapsedBackgroundColor: Palette.themecolor,
                            textColor: Palette.themecolor,
                            collapsedTextColor: themewhitecolor,
                            iconColor: Palette.themecolor,
                            collapsedIconColor: themewhitecolor,
                            title: Text(
                              "DETAILS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              propertyDetailWidget(modelValue),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),
                        //Contact Details column
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(12),
                            backgroundColor: themewhitecolor,
                            collapsedBackgroundColor: Palette.themecolor,
                            textColor: Palette.themecolor,
                            collapsedTextColor: themewhitecolor,
                            iconColor: Palette.themecolor,
                            collapsedIconColor: themewhitecolor,
                            title: Text(
                              "CONTACT US DETAILS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [contactUsDetailWidget(modelValue)],
                          ),
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),

                        //Product Maps
                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(12),
                            backgroundColor: themewhitecolor,
                            collapsedBackgroundColor: Palette.themecolor,
                            textColor: Palette.themecolor,
                            collapsedTextColor: themewhitecolor,
                            iconColor: Palette.themecolor,
                            collapsedIconColor: themewhitecolor,
                            title: Text(
                              "Agent ID",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              propertyMapImagesWidget(
                                  modelValue, decodedPropertyMapImages, size)
                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.height / 100 * 2,
                        ),

                        //RELATED PRODUCTS

                        Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(12),
                            backgroundColor: themewhitecolor,
                            collapsedBackgroundColor: Palette.themecolor,
                            textColor: Palette.themecolor,
                            collapsedTextColor: themewhitecolor,
                            iconColor: Palette.themecolor,
                            collapsedIconColor: themewhitecolor,
                            title: Text(
                              "RELATED PROPERTIES",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [relatedPropertyWidget(modelValue, size)],
                          ),
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

  Widget loadingShimmer(size) {
    return Shimmer.fromColors(
      baseColor: themegreycolor,
      highlightColor: themegreytextcolor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: themegreycolor,
          ),
          SizedBox(
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

  Widget productDetails(size) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: themewhitecolor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeblackcolor,
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: themeblackcolor),
        ),
      ),
      bottomNavigationBar: Consumer<products_pro>(
        builder: (BuildContext context, modelValue, Widget? child) {
          return FilledBox(
            onTap: () {
              if (modelValue.dProductSize.isNotEmpty) {
                if (selectedSize != null) {
                  if (modelValue.dProductColors.isNotEmpty) {
                    if (selectedcolor != null) {
                      if (Provider.of<auth_pro>(context, listen: false)
                              .userId !=
                          null) {
                        final cartProvider =
                            Provider.of<cart_pro>(context, listen: false);
                        cartProvider.productAddToCart(
                            modelValue.dProductUrl,
                            modelValue.counter.toString(),
                            fetchedSize,
                            fetchedColor,
                            context);
                      } else {
                        RouteNavigator.route(
                          context,
                          LoginScreen(),
                        );
                      }
                    } else {
                      showMyCustomSnackBar(
                          "Please Select Color First!", true, context);
                    }
                  }
                } else {
                  showMyCustomSnackBar(
                      "Please Select Size First!", true, context);
                }
              } else {
                if (modelValue.dProductColors.isNotEmpty) {
                  if (selectedcolor != null) {
                    if (Provider.of<auth_pro>(context, listen: false).userId !=
                        null) {
                      final cartProvider =
                          Provider.of<cart_pro>(context, listen: false);
                      cartProvider.productAddToCart(
                          modelValue.dProductUrl,
                          modelValue.counter.toString(),
                          fetchedSize,
                          fetchedColor,
                          context);
                    } else {
                      RouteNavigator.route(
                        context,
                        LoginScreen(),
                      );
                    }
                  } else {
                    showMyCustomSnackBar(
                        "Please Select Color First!", true, context);
                  }
                } else {
                  if (Provider.of<auth_pro>(context, listen: false).userId !=
                      null) {
                    final cartProvider =
                        Provider.of<cart_pro>(context, listen: false);
                    cartProvider.productAddToCart(
                        modelValue.dProductUrl,
                        modelValue.counter.toString(),
                        fetchedSize,
                        fetchedColor,
                        context);
                  } else {
                    RouteNavigator.route(
                      context,
                      LoginScreen(),
                    );
                  }
                }
              }
              //  final cartProvider =
              //             Provider.of<cart_pro>(context, listen: false);
              //         cartProvider.productAddToCart(
              //             modelValue.dProductUrl,
              //             modelValue.counter.toString(),
              //             fetchedSize,
              //             fetchedColor,
              //             context);
            },
            height: 55,
            width: size.width,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.zero,
            color: Palette.themecolor,
            child: Center(
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: themewhitecolor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: Consumer<products_pro>(
      //   builder: ((context, modelValue, child) {
      //     if (modelValue.productDetailIsLoading) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children:  [
      //           Center(child: CircularProgressIndicator()),
      //         ],
      //       );
      //     } else {
      //       return Padding(
      //         padding:  EdgeInsets.all(12.0),
      //         child: Row(
      //           children: [
      //             Text(
      //               "Rs.${(((int.parse(modelValue.dProductPrice) / 100) * int.parse(modelValue.dProductDiscount) - int.parse(modelValue.dProductPrice)).abs())}/-",
      //               style:  TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //              Spacer(),
      //             Consumer<cart_pro>(
      //               builder: ((context, cartValue, child) {
      //                 return cartValue.productIsBeingAdded
      //                     ? Container(
      //                         padding:  EdgeInsets.all(5.0),
      //                         height: 40,
      //                         width: size.width / 100 * 60,
      //                         decoration: BoxDecoration(
      //                             border: Border.all(
      //                               color: themegreytextcolor,
      //                             ),
      //                             borderRadius: BorderRadius.circular(5)),
      //                         child:  Center(
      //                           child: CircularProgressIndicator(
      //                             color: themegreytextcolor,
      //                             strokeWidth: 3,
      //                           ),
      //                         ),
      //                       )
      //                     : CustomOutlinedButton(
      //                         onTap: () {
      // if (modelValue.dProductSize.isNotEmpty) {
      //   if (selectedSize != null) {
      //     if (modelValue.dProductColors.isNotEmpty) {
      //       if (selectedcolor != null) {
      //         final cartProvider =
      //             Provider.of<cart_pro>(context,
      //                 listen: false);
      //         cartProvider.productAddToCart(
      //             modelValue.dProductUrl,
      //             modelValue.counter.toString(),
      //             fetchedSize,
      //             fetchedColor,
      //             context);
      //       } else {
      //         showMyCustomSnackBar(
      //             "Please Select Color First!",
      //             true,
      //             context);
      //       }
      //     }
      //   } else {
      //     showMyCustomSnackBar(
      //         "Please Select Size First!",
      //         true,
      //         context);
      //   }
      // } else {
      //   if (modelValue.dProductColors.isNotEmpty) {
      //     if (selectedcolor != null) {
      //       final cartProvider =
      //           Provider.of<cart_pro>(context,
      //               listen: false);
      //       cartProvider.productAddToCart(
      //           modelValue.dProductUrl,
      //           modelValue.counter.toString(),
      //           fetchedSize,
      //           fetchedColor,
      //           context);
      //     } else {
      //       showMyCustomSnackBar(
      //           "Please Select Color First!",
      //           true,
      //           context);
      //     }
      //   }
      // }
      //                         },
      //                         height: 40,
      //                         width: size.width / 100 * 60,
      //                         borderRadius: BorderRadius.circular(4),
      //                         borderColor: themegreytextcolor,
      //                         child:  Text(
      //                           "Add to Cart",
      //                           style: TextStyle(
      //                             color: themegreytextcolor,
      //                             fontSize: 13,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       );
      //               }),
      //             ),
      //           ],
      //         ),
      //       );
      //     }
      //   }),
      // ),
      body: Consumer<products_pro>(
        builder: ((context, modelValue, child) {
          if (modelValue.productDetailIsLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
//images
            log("modelValue.dProductImages: ${modelValue.dProductImages}");
            List decodedeimages = [];
            if (modelValue.dProductImages.isNotEmpty) {
              decodedeimages =
                  jsonDecode(modelValue.dProductImages[0].toString());
            }

            log("Decoded Images: $decodedeimages");

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                modelValue.dProductName,
                                style: TextStyle(
                                  color: Palette.themecolor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Rating : (${modelValue.dProductRating})",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: themeyellowcolor,
                                    size: 18,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              FilledBox(
                                color: themedarkgreycolor,
                                borderRadius: BorderRadius.circular(20),
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 15,
                                ),
                                child: Text(
                                  modelValue.dProductCategory.toUpperCase(),
                                  style: TextStyle(
                                    color: themewhitecolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        ImageSlider(
                          height: size.height / 100 * 50,
                          isNetworkImage: true,
                          autoPlay: true,
                          images: decodedeimages,
                          useShadow: false,
                          enableInfiniteScroll: false,
                          isEmpty: (decodedeimages.isEmpty) ? true : false,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "PKR. ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  children: [
                                    // TextSpan(
                                    //   text:
                                    //       // "${(((int.parse(modelValue.dProductPrice) / 100) * int.parse(modelValue.dProductDiscount) - int.parse(modelValue.dProductPrice)).abs())}/-",
                                    //       "${((int.parse(modelValue.dProductPrice == "" ? "0" : modelValue.dProductPrice) / 100) * int.parse(modelValue.dProductDiscount == "" ? "0" : modelValue.dProductDiscount) -
                                    //       int.parse(modelValue.dProductPrice == "" ? "0" : modelValue.dProductPrice))}",
                                    //   style:  TextStyle(
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),

                                    TextSpan(
                                      text:
                                          "${(((int.parse(modelValue.dProductPrice) / 100) * int.parse(modelValue.dProductDiscount) - int.parse(modelValue.dProductPrice)).abs())}/-",
                                      // "${((int.parse(modelValue.dProductPrice == "" ? "0" : modelValue.dProductPrice) / 100) * int.parse(modelValue.dProductDiscount == "" ? "0" : modelValue.dProductDiscount) - int.parse(modelValue.dProductPrice == "" ? "0" : modelValue.dProductPrice))}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Palette.themecolor,
                                    size: 20,
                                  ),
                                  Text(
                                    " 6100+ sold recently",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              modelValue.dProductColorsName.isEmpty
                                  ? Container()
                                  : Row(
                                      children: [
                                        Text(
                                          "Colors:",
                                          style: TextStyle(
                                            color: themeblackcolor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: List.generate(
                                              modelValue
                                                  .dProductColorsName.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedcolor = index;
                                                        fetchedColor = modelValue
                                                                .dProductColorsHex[
                                                            index];
                                                      });
                                                      log("fetchedColor: $fetchedColor");
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2,
                                                              vertical: 2),
                                                      child: Container(
                                                        height: size.height /
                                                            100 *
                                                            6,
                                                        width: size.width /
                                                            100 *
                                                            9,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: (selectedcolor ==
                                                                  index)
                                                              ? Border.all(
                                                                  color:
                                                                      themegreytextcolor,
                                                                  width: 5)
                                                              : Border.all(
                                                                  color:
                                                                      themewhitecolor,
                                                                  width: 0),
                                                          color: Color(int.parse(
                                                              "0xFF${(modelValue.dProductColorsHex[index]).toString().substring(1)}")),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      ],
                                    ),
                              modelValue.dProductSizesName.isEmpty
                                  ? Container()
                                  : Row(
                                      children: [
                                        Text(
                                          "Sizes:",
                                          style: TextStyle(
                                            color: themeblackcolor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: List.generate(
                                              modelValue
                                                  .dProductSizesName.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedSize = index;
                                                        fetchedSize = modelValue
                                                                .dProductSizesName[
                                                            index];
                                                      });
                                                      log("fetchedSize: $fetchedSize");

                                                      final counterProviderr =
                                                          Provider.of<
                                                                  products_pro>(
                                                              context,
                                                              listen: false);
                                                      counterProviderr.counter =
                                                          1;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2,
                                                              vertical: 2),
                                                      child: Container(
                                                        height: size.height /
                                                            100 *
                                                            5,
                                                        width: size.width /
                                                            100 *
                                                            9,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (selectedSize ==
                                                                  index)
                                                              ? Palette
                                                                  .themecolor
                                                              : Palette
                                                                  .themecolor
                                                                  .withOpacity(
                                                                      0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          modelValue
                                                                  .dProductSizesName[
                                                              index],
                                                          style: TextStyle(
                                                            color:
                                                                themewhitecolor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      ],
                                    ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Quantity counter
                                  Consumer<products_pro>(
                                    builder: ((context, counterModel, child) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Palette.themecolor,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Row(
                                          children: [
                                            CustomIconButton(
                                              onTap: () {
                                                final counterProvider =
                                                    Provider.of<products_pro>(
                                                        context,
                                                        listen: false);
                                                counterProvider
                                                    .decrementcounter();
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: themewhitecolor,
                                                size: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${counterModel.counter}',
                                              style: TextStyle(
                                                color: themewhitecolor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomIconButton(
                                              onTap: () {
                                                if (modelValue
                                                    .dProductSize.isEmpty) {
                                                  final counterProvider =
                                                      Provider.of<products_pro>(
                                                          context,
                                                          listen: false);
                                                  counterProvider
                                                      .incrementcounter();
                                                } else {
                                                  if (selectedSize != null) {
                                                    final counterProvider =
                                                        Provider.of<
                                                                products_pro>(
                                                            context,
                                                            listen: false);
                                                    counterProvider
                                                        .incrementcounter();
                                                  } else {
                                                    showMyCustomSnackBar(
                                                        "Size Not Selected Yet",
                                                        true,
                                                        context);
                                                  }
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: themewhitecolor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  Consumer<products_pro>(
                                    builder: ((context, whishlistValue, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (Provider.of<auth_pro>(context,
                                                      listen: false)
                                                  .userId !=
                                              null) {
                                            final whishListProvider =
                                                Provider.of<products_pro>(
                                                    context,
                                                    listen: false);
                                            whishListProvider
                                                .addProductToWhislist(
                                                    modelValue.dProductUrl,
                                                    context);
                                          } else {
                                            RouteNavigator.route(
                                              context,
                                              LoginScreen(),
                                            );
                                          }
                                        },
                                        child:
                                            (whishlistValue.dProductFavorite ==
                                                    0)
                                                ? CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        themegreytextcolor,
                                                    child: Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: themewhitecolor,
                                                      size: 16,
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Palette.themecolor,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: themewhitecolor,
                                                      size: 16,
                                                    ),
                                                  ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              //  SizedBox(height: 20),
                              // OutlinedBox(
                              //   width: double.infinity,
                              //   padding:  EdgeInsets.all(12),
                              //   borderRadius: BorderRadius.circular(12),
                              //   child: Row(
                              //     children: [
                              //        Text(
                              //         "Free Delivery by Tomorrow with SHAMUK",
                              //         style: TextStyle(
                              //           color: themeblackcolor,
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //        Spacer(),
                              //       FilledBox(
                              //         height: 20,
                              //         width: 30,
                              //         color: Palette.themecolor,
                              //         padding: EdgeInsets.zero,
                              //         borderRadius: BorderRadius.circular(12),
                              //         child:  Center(
                              //           child: Icon(
                              //             Icons.arrow_forward,
                              //             color: themewhitecolor,
                              //             size: 16,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        FilledBox(
                          padding: EdgeInsets.zero,
                          color: themelightgreycolor,
                          child: TabBar(
                            controller: tabController,
                            labelColor: Palette.themecolor,
                            indicatorColor: Palette.themecolor,
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelColor: themeblackcolor,
                            tabs: [
                              Tab(
                                text: "Overview",
                                height: 50,
                              ),
                              Tab(
                                text: "Specifications",
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: [
                  overview(modelValue),
                  specs(modelValue),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget specs(modelValue) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child:
            // ExpandableTextWidget(modelValue.dProductSpecification),
            HtmlRenderCustom(
          text: modelValue.dProductSpecification,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget overview(modelValue) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: HtmlRenderCustom(
          text: modelValue.dProductDescription,
          style: TextStyle(
            fontSize: 16,
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
      duration: Duration(milliseconds: 700),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          titlePadding: EdgeInsets.all(24),
          actionsPadding: EdgeInsets.all(0),
          buttonPadding: EdgeInsets.all(0),
          title: SizedBox(
            width: size.width / 100 * 95,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ),
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'For more information, please fill out the form and our team will get back to you',
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themegreycolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.themecolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themegreycolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.themecolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
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
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
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
                        Expanded(
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
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themegreycolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.themecolor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
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
