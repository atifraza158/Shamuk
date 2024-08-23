import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:provider/provider.dart';

import '../../property/property_detail_view.dart';

relatedPropertyWidget(properties_pro modelValue, Size size) {
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // RouteNavigator.route(
                            //   context,
                            //   ProductDetailsScreen(
                            //     isProjectDetails: true,
                            //     productUrl: modelValue.propertyUrl[index],
                            //   ),
                            // );

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PropertyDetailView(
                                  isProjectDetails: true,
                                  id: modelValue.dPropertyTypeId,
                                  productUrl: modelValue.propertyUrl[index],
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 120,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: themewhitecolor,
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
                        ),
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: themewhitecolor,
                            // gradient: LinearGradient(
                            //   begin: Alignment.topRight,
                            //   end: Alignment.bottomLeft,
                            //   colors: [
                            //     themegreycolor,
                            //     themegreycolor,
                            //   ],
                            // ),
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
                                            : (modelValue.propertyTypeId[index]
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
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${modelValue.propertyPrice[index]} PKR",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: themeblackcolor,
                                      fontSize: 20,
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Homes",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: themeredcolor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ],
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
