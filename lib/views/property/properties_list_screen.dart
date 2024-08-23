import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/property/property_detail_view.dart';
import 'package:multivendor/views/property/property_filters_bottem_sheet.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'property_components/property_card_button.dart';

class PropertiesListScreen extends StatefulWidget {
  final bool? isShowAppBar;
  final bool country;
  PropertiesListScreen({
    Key? key,
    this.isShowAppBar = false,
    required this.country,
  }) : super(key: key);

  @override
  State<PropertiesListScreen> createState() => _PropertiesListScreenState();
}

class _PropertiesListScreenState extends State<PropertiesListScreen> {
  @override
  void initState() {
    final propertyProvider =
        Provider.of<properties_pro>(context, listen: false);
    String countryId = "";
    String stateId = "";
    String cityId = "";
    if (widget.country) {
      countryId = propertyProvider.propertyFilter.countryId.toString();
      stateId = propertyProvider.propertyFilter.stateId.toString();
      cityId = propertyProvider.propertyFilter.cityId.toString();
    }
    propertyProvider.getPropertiesFunc(
        "", "", countryId, stateId, cityId, "", "", "", "", "", "", context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.isShowAppBar == true
          ? AppBar(
              backgroundColor: Palette.themecolor,
              elevation: 0,
              leading: Container(),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: themewhitecolor,
                          child: Icon(
                            Icons.arrow_back,
                            color: Palette.themecolor,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Properties",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            //filters
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomOutlinedButton(
                  onTap: () async {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        context: context,
                        builder: (context) => PropertyFiltersBottomSheet(
                              country: widget.country,
                            ));
                  },
                  height: 55,
                  width: size.width,
                  borderRadius: BorderRadius.circular(12),
                  borderColor: Palette.themecolor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.poll,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Property Fitlers",
                        style: TextStyle(
                          color: Palette.themecolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Consumer<properties_pro>(builder: ((context, modelValue, child) {
              return modelValue.propertysIsLoading
                  ? loadingShimmer(size)
                  : modelValue.propertyUrl.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/png/property_not_found-r.png",
                                  height: 350,
                                  width: 300,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "No Property Found",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.themecolor.withOpacity(0.6),
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(20),
                            itemCount: modelValue.propertyUrl.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // RouteNavigator.route(
                                      //   context,
                                      //   ProductDetailsScreen(
                                      //     isProjectDetails: true,
                                      //     productUrl:
                                      //         modelValue.propertyUrl[index],
                                      //   ),
                                      // );
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return PropertyDetailView(
                                            isProjectDetails: true,
                                            id: modelValue.dPropertyTypeId,
                                            productUrl:
                                                modelValue.propertyUrl[index],
                                          );
                                        },
                                      ));
                                    },
                                    child: CachedNetworkImage(
                                      // imageUrl: getPropertyCardApi +
                                      //     modelValue.propertyCard[index],
                                      imageUrl:
                                          "https://sapphireassociate.com/wp-content/uploads/2022/04/property-house.jpg",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 220,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: themegreycolor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              getPropertyCardApi +
                                                  modelValue
                                                      .propertyCard[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: themegreycolor,
                                        highlightColor: themegreytextcolor,
                                        child: Container(
                                          width: size.width,
                                          height: 220.0,
                                          decoration: BoxDecoration(
                                            color: themegreycolor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Container(
                                    width: size.width,
                                    padding: EdgeInsets.only(
                                      top: 8,
                                      left: 15,
                                      right: 15,
                                      bottom: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: themewhitecolor,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.verified_user_rounded,
                                              size: 25,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Verified By Shamuk",
                                              style: TextStyle(
                                                color: themegreytextcolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              (modelValue.propertyTypeId[index]
                                                          .toString() ==
                                                      "1")
                                                  ? "Home"
                                                  : (modelValue.propertyTypeId[
                                                                  index]
                                                              .toString() ==
                                                          "2")
                                                      ? "Plots"
                                                      : (modelValue
                                                                  .propertyTypeId[
                                                                      index]
                                                                  .toString() ==
                                                              "3")
                                                          ? "Commerical"
                                                          : "",
                                              style: TextStyle(
                                                color: themegreytextcolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              (modelValue.propertyPurpose[index]
                                                          .toString() ==
                                                      "1")
                                                  ? " for Rent"
                                                  : (modelValue.propertyTypeId[
                                                                  index]
                                                              .toString() ==
                                                          "2")
                                                      ? " for Sell"
                                                      : " for ",
                                              style: TextStyle(
                                                color: themegreytextcolor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Palette.themecolor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                modelValue
                                                    .propertyCountry[index],
                                                style: TextStyle(
                                                  color: themewhitecolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //  SizedBox(
                                        //   height: 10,
                                        // ),
                                        Text(
                                          "${modelValue.propertyPrice[index]} PKR",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: themeblackcolor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${modelValue.propertyTitle[index] == "null" ? "" : modelValue.propertyTitle[index]} ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Palette.themecolor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${modelValue.propertyArea[index]} ${(modelValue.propertyAreaUnit[index].toString() == "1") ? "Marla" : (modelValue.propertyAreaUnit[index].toString() == "2") ? "Square Feet" : (modelValue.propertyAreaUnit[index].toString() == "3") ? "Square Yards" : (modelValue.propertyAreaUnit[index].toString() == "4") ? "Square Meters" : (modelValue.propertyAreaUnit[index].toString() == "5") ? "Kanal" : ""}, ${(modelValue.propertyTypeId[index].toString() == "1") ? "Home" : (modelValue.propertyTypeId[index].toString() == "2") ? "Plots" : (modelValue.propertyTypeId[index].toString() == "3") ? "Commercial" : ""} ${(modelValue.propertyPurpose[index].toString() == "1") ? "for Rent" : (modelValue.propertyPurpose[index].toString() == "2") ? "for Sell" : ""}, In ${modelValue.propertyLocation[index]}, at ${modelValue.propertyCity[index]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: themegreytextcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: PropertyCardButton(
                                                onTap: () async {
                                                  var businessNo = modelValue
                                                      .dPropertyBusinessEmail;
                                                  var emailAndroid = Uri.parse(
                                                      "mailto:$businessNo");
                                                  if (await canLaunchUrl(
                                                      emailAndroid)) {
                                                    await launchUrl(
                                                        emailAndroid);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Email is not installed on the device"),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.mail,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Email",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: PropertyCardButton(
                                                onTap: () async {
                                                  if (modelValue
                                                          .dPropertyPhoneNumber !=
                                                      "") {
                                                    await FlutterPhoneDirectCaller
                                                        .callNumber(modelValue
                                                            .dPropertyPhoneNumber);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Phone Number is not available"),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.call,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 4),
                                                    const Text(
                                                      "Call",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: PropertyCardButton(
                                                  onTap: () async {
                                                    // testLaunchUrl();
                                                    // openWhatsApp(modelValue.dPropertyPhoneNumber, "message");
                                                    var whatsapp = modelValue
                                                        .dPropertyPhoneNumber;
                                                    // var whatsappAndroid = Uri.parse(
                                                    //     "https://wa.me/$whatsapp?text=${Uri.encodeFull("message")}");
                                                    var whatsappAndroid = Uri.parse(
                                                        "https://wa.me/$whatsapp?text=${Uri.encodeFull("message")}");
                                                    if (await canLaunchUrl(
                                                        whatsappAndroid)) {
                                                      await launchUrl(
                                                          whatsappAndroid);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "WhatsApp is not installed on the device...................",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  isGreen: true,
                                                  child: Icon(
                                                    FontAwesome.whatsapp,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        );
            })),
          ],
        ),
      ),
    );
  }
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

Future<Object?> getInTouch(size, BuildContext context) {
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
