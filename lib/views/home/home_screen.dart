import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/dummy_models/dummy_models.dart';
import 'package:multivendor/model/property/property_model.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/category_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/utils/constants.dart';
import 'package:multivendor/views/categories/category_screen.dart';
import 'package:multivendor/views/product_category/product_category_screen.dart';
import 'package:multivendor/views/product_details/product_details_screen.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:multivendor/widgets/custom_text_button.dart';
import 'package:multivendor/widgets/image_slider_two.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../property/property_detail_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final propertyProvider =
        Provider.of<properties_pro>(context, listen: false);
    propertyProvider.getPropertiesFunc(
        "", "", "", "", "", "", "", "", "", "", "", context);
    final categoryProvider = Provider.of<category_pro>(context, listen: false);
    categoryProvider.getShopCategoriesFunc(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: Center(
              child: Image.asset(
                appLogo,
                width: size.width / 100 * 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text.rich(
                  TextSpan(
                    text: "Here’s what you can do on ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Shamuk",
                        style: TextStyle(
                          color: Palette.themecolor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //categories
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 110,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      RouteNavigator.route(
                        context,
                        CategoryScreen(
                          category: index,
                          title: index == 0
                              ? "Shops"
                              : index == 1
                                  ? "Services"
                                  : index == 2
                                      ? "Wanted"
                                      : index == 3
                                          ? "Properties"
                                          : "",
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          index == 0
                              ? "assets/images/png/shop-icon.png"
                              : index == 1
                                  ? "assets/images/png/services_new.png"
                                  : index == 2
                                      ? "assets/images/png/wanted-icon.png"
                                      : "assets/images/png/property-icon.png",
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          index == 0
                              ? "Shop"
                              : index == 1
                                  ? "Professionals"
                                  : index == 2
                                      ? "Wanted"
                                      : "Properties",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: themeblackcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const FeedImageSlider(),
              const SizedBox(
                height: 50,
              ),
              //properties

              FutureBuilder<List<PropertyModelM>>(
                  future: Provider.of<properties_pro>(context, listen: false)
                      .getPropertyHome(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text.rich(
                                    TextSpan(
                                      text: "Latest ",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Properties",
                                          style: TextStyle(
                                            color: Palette.themecolor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomTextButton(
                                    buttonText: "View All",
                                    onTap: () {
                                      RouteNavigator.route(
                                        context,
                                        PropertiesListScreen(
                                          isShowAppBar: true,
                                          country: false,
                                        ),
                                      );
                                    },
                                    textstyle: const TextStyle(
                                      color: Palette.themecolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 260,
                              child: GridView.builder(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final model = snapshot.data![index];
                                  return InkWell(
                                    onTap: () {
                                      // RouteNavigator.route(
                                      //   context,
                                      //   ProductDetailsScreen(
                                      //     isProjectDetails: true,
                                      //     productUrl: model.url ?? "",
                                      //   ),
                                      // );

                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return PropertyDetailView(
                                            isProjectDetails: true,
                                            id: snapshot.data![index].typeId
                                                .toString(),
                                            productUrl: snapshot
                                                .data![index].url
                                                .toString(),
                                          );
                                        },
                                      ));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: themewhitecolor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getPropertyCardApi +
                                                    model.card!,
                                              ),
                                              fit: BoxFit.cover,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    (model.typeId.toString() ==
                                                            "1")
                                                        ? "Home"
                                                        : (model.typeId
                                                                    .toString() ==
                                                                "2")
                                                            ? "Plots"
                                                            : (model.typeId
                                                                        .toString() ==
                                                                    "3")
                                                                ? "Commerical"
                                                                : "",
                                                    style: const TextStyle(
                                                      color: themegreytextcolor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    (model.purpose.toString() ==
                                                            "1")
                                                        ? " for Rent"
                                                        : (model.purpose
                                                                    .toString() ==
                                                                "2")
                                                            ? " for Sell"
                                                            : " for ",
                                                    style: const TextStyle(
                                                      color: themegreytextcolor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${model.price} PKR",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: themeblackcolor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // Text(
                                                  //   "${modelValue.propertyArea[index]} ${(modelValue.propertyAreaUnit[index].toString() == "1") ? "Marla" : (modelValue.propertyAreaUnit[index].toString() == "2") ? "Square Feet" : (modelValue.propertyAreaUnit[index].toString() == "3") ? "Square Yards" : (modelValue.propertyAreaUnit[index].toString() == "4") ? "Square Meters" : (modelValue.propertyAreaUnit[index].toString() == "5") ? "Kanal" : ""}, ${(modelValue.propertyTypeId[index].toString() == "1") ? "Home" : (modelValue.propertyTypeId[index].toString() == "2") ? "Plots" : (modelValue.propertyTypeId[index].toString() == "3") ? "Commercial" : ""} ${(modelValue.propertyPurpose[index].toString() == "1") ? "for Rent" : (modelValue.propertyPurpose[index].toString() == "2") ? "for Sell" : ""}, In ${modelValue.propertyLocation[index]}, at ${modelValue.propertyCity[index]}",
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: const TextStyle(
                                                  //     color: themegreytextcolor,
                                                  //     fontSize: 15,
                                                  //     fontWeight: FontWeight.w500,
                                                  //   ),
                                                  // ),
                                                  Text(
                                                    model.title ?? "",
                                                    style: const TextStyle(
                                                      color: Palette.themecolor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  // const SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // // const Text(
                                                  //   "Homes",
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     color: themeredcolor,
                                                  //     fontSize: 12,
                                                  //     fontWeight: FontWeight.w500,
                                                  //   ),
                                                  // )
                                                  Text(
                                                    "${model.area} ${(model.areaUnit.toString() == "1") ? "Marla" : (model.areaUnit.toString() == "2") ? "Square Feet" : (model.areaUnit.toString() == "3") ? "Square Yards" : (model.areaUnit.toString() == "4") ? "Square Meters" : (model.areaUnit.toString() == "5") ? "Kanal" : ""}, ${(model.typeId.toString() == "1") ? "Home" : (model.typeId.toString() == "2") ? "Plots" : (model.typeId.toString() == "3") ? "Commercial" : ""} ${(model.purpose.toString() == "1") ? "for Rent" : (model.purpose.toString() == "2") ? "for Sell" : ""}, In ${model.location}, at ${model.city}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: themegreytextcolor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        //
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  }),
              // Consumer<properties_pro>(
              //   builder: ((context, modelValue, child) {
              //     return modelValue.propertysIsLoading
              //         ? loadingShimmer(size)
              //         : modelValue.propertyUrl.isEmpty
              //             ? Center(
              //                 child: Image.asset(
              //                   "assets/images/png/property_not_found-r.png",
              //                   height: 250,
              //                   width: 250,
              //                   fit: BoxFit.cover,
              //                 ),
              //               )
              //             : SizedBox(
              //                 height: 260,
              //                 child: GridView.builder(
              //                   padding: const EdgeInsets.only(
              //                     left: 20,
              //                     right: 20,
              //                     bottom: 20,
              //                   ),
              //                   primary: false,
              //                   shrinkWrap: true,
              //                   itemCount: modelValue.propertyUrl.length,
              //                   scrollDirection: Axis.horizontal,
              //                   gridDelegate:
              //                       const SliverGridDelegateWithFixedCrossAxisCount(
              //                     mainAxisExtent: 200,
              //                     crossAxisSpacing: 20,
              //                     mainAxisSpacing: 20,
              //                     crossAxisCount: 1,
              //                   ),
              //                   itemBuilder: (context, index) {
              //                     return InkWell(
              //                       onTap: () {
              //                         RouteNavigator.route(
              //                           context,
              //                           ProductDetailsScreen(
              //                             isProjectDetails: true,
              //                             productUrl:
              //                                 modelValue.propertyUrl[index],
              //                           ),
              //                         );
              //                       },
              //                       child: Column(
              //                         children: [
              //                           Container(
              //                             height: 120,
              //                             width: size.width,
              //                             decoration: BoxDecoration(
              //                               color: themewhitecolor,
              //                               borderRadius:
              //                                   const BorderRadius.only(
              //                                 topLeft: Radius.circular(20),
              //                                 topRight: Radius.circular(20),
              //                               ),
              //                               image: DecorationImage(
              //                                 image: NetworkImage(
              //                                   getPropertyCardApi +
              //                                       modelValue
              //                                           .propertyCard[index],
              //                                 ),
              //                                 fit: BoxFit.cover,
              //                               ),
              //                             ),
              //                           ),
              //                           Container(
              //                             width: size.width,
              //                             padding: const EdgeInsets.all(12),
              //                             decoration: const BoxDecoration(
              //                               color: themewhitecolor,
              //                               // gradient: LinearGradient(
              //                               //   begin: Alignment.topRight,
              //                               //   end: Alignment.bottomLeft,
              //                               //   colors: [
              //                               //     themegreycolor,
              //                               //     themegreycolor,
              //                               //   ],
              //                               // ),
              //                               borderRadius: BorderRadius.only(
              //                                 bottomLeft: Radius.circular(20),
              //                                 bottomRight: Radius.circular(20),
              //                               ),
              //                               boxShadow: [
              //                                 BoxShadow(
              //                                   color: themegreycolor,
              //                                   blurRadius: 10,
              //                                 ),
              //                               ],
              //                             ),
              //                             child: Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Row(
              //                                   children: [
              //                                     Text(
              //                                       (modelValue.propertyTypeId[
              //                                                       index]
              //                                                   .toString() ==
              //                                               "1")
              //                                           ? "Home"
              //                                           : (modelValue
              //                                                       .propertyTypeId[
              //                                                           index]
              //                                                       .toString() ==
              //                                                   "2")
              //                                               ? "Plots"
              //                                               : (modelValue
              //                                                           .propertyTypeId[
              //                                                               index]
              //                                                           .toString() ==
              //                                                       "3")
              //                                                   ? "Commerical"
              //                                                   : "",
              //                                       style: const TextStyle(
              //                                         color: themegreytextcolor,
              //                                         fontSize: 14,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                       ),
              //                                     ),
              //                                     Text(
              //                                       (modelValue.propertyPurpose[
              //                                                       index]
              //                                                   .toString() ==
              //                                               "1")
              //                                           ? " for Rent"
              //                                           : (modelValue
              //                                                       .propertyTypeId[
              //                                                           index]
              //                                                       .toString() ==
              //                                                   "2")
              //                                               ? " for Sell"
              //                                               : " for ",
              //                                       style: const TextStyle(
              //                                         color: themegreytextcolor,
              //                                         fontSize: 14,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       "${modelValue.propertyPrice[index]} PKR",
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                       style: const TextStyle(
              //                                         color: themeblackcolor,
              //                                         fontSize: 20,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                       ),
              //                                     ),
              //                                     const SizedBox(
              //                                       height: 5,
              //                                     ),
              //                                     // Text(
              //                                     //   "${modelValue.propertyArea[index]} ${(modelValue.propertyAreaUnit[index].toString() == "1") ? "Marla" : (modelValue.propertyAreaUnit[index].toString() == "2") ? "Square Feet" : (modelValue.propertyAreaUnit[index].toString() == "3") ? "Square Yards" : (modelValue.propertyAreaUnit[index].toString() == "4") ? "Square Meters" : (modelValue.propertyAreaUnit[index].toString() == "5") ? "Kanal" : ""}, ${(modelValue.propertyTypeId[index].toString() == "1") ? "Home" : (modelValue.propertyTypeId[index].toString() == "2") ? "Plots" : (modelValue.propertyTypeId[index].toString() == "3") ? "Commercial" : ""} ${(modelValue.propertyPurpose[index].toString() == "1") ? "for Rent" : (modelValue.propertyPurpose[index].toString() == "2") ? "for Sell" : ""}, In ${modelValue.propertyLocation[index]}, at ${modelValue.propertyCity[index]}",
              //                                     //   overflow:
              //                                     //       TextOverflow.ellipsis,
              //                                     //   style: const TextStyle(
              //                                     //     color: themegreytextcolor,
              //                                     //     fontSize: 15,
              //                                     //     fontWeight: FontWeight.w500,
              //                                     //   ),
              //                                     // ),
              //                                     Text(
              //                                       "${modelValue.propertyTitle[index] == "null" ? "" : modelValue.propertyTitle[index]}",
              //                                       style: const TextStyle(
              //                                         color: themegreytextcolor,
              //                                         fontSize: 15,
              //                                         fontWeight:
              //                                             FontWeight.w500,
              //                                       ),
              //                                       maxLines: 1,
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                     ),
              //                                     // const SizedBox(
              //                                     //   height: 5,
              //                                     // ),
              //                                     // // const Text(
              //                                     //   "Homes",
              //                                     //   overflow:
              //                                     //       TextOverflow.ellipsis,
              //                                     //   style: TextStyle(
              //                                     //     color: themeredcolor,
              //                                     //     fontSize: 12,
              //                                     //     fontWeight: FontWeight.w500,
              //                                     //   ),
              //                                     // )
              //                                     Text(
              //                                       "${modelValue.propertyArea[index]} ${(modelValue.propertyAreaUnit[index].toString() == "1") ? "Marla" : (modelValue.propertyAreaUnit[index].toString() == "2") ? "Square Feet" : (modelValue.propertyAreaUnit[index].toString() == "3") ? "Square Yards" : (modelValue.propertyAreaUnit[index].toString() == "4") ? "Square Meters" : (modelValue.propertyAreaUnit[index].toString() == "5") ? "Kanal" : ""}, ${(modelValue.propertyTypeId[index].toString() == "1") ? "Home" : (modelValue.propertyTypeId[index].toString() == "2") ? "Plots" : (modelValue.propertyTypeId[index].toString() == "3") ? "Commercial" : ""} ${(modelValue.propertyPurpose[index].toString() == "1") ? "for Rent" : (modelValue.propertyPurpose[index].toString() == "2") ? "for Sell" : ""}, In ${modelValue.propertyLocation[index]}, at ${modelValue.propertyCity[index]}",
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                       style: const TextStyle(
              //                                         color: themegreytextcolor,
              //                                         fontSize: 13,
              //                                         fontWeight:
              //                                             FontWeight.w400,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ],
              //                             ),
              //                           ),

              //                           //
              //                         ],
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               );
              //   }),
              // ),

              const SizedBox(
                height: 10,
              ),

              ///Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text.rich(
                      TextSpan(
                        text: "Shop By ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Category",
                            style: TextStyle(
                              color: Palette.themecolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextButton(
                      buttonText: "View All",
                      onTap: () {
                        RouteNavigator.route(
                          context,
                          const CategoryScreen(
                            title: "All Shops",
                            category: 0,
                          ),
                        );
                      },
                      textstyle: const TextStyle(
                        color: Palette.themecolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<category_pro>(
                builder: ((context, modelValue, child) {
                  return modelValue.categoriesIsLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : modelValue.categoryName.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 100 * 4,
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/png/no_subcategory_product.png",
                                    height: 350,
                                    width: 350,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 250,
                              child: GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10.0),
                                itemCount: modelValue.categoryName.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      RouteNavigator.route(
                                        context,
                                        ProductCategoryScreen(
                                          title: modelValue.categoryName[index],
                                          productCategory: 0,
                                          categoryId:
                                              modelValue.categoryId[index],
                                          serviceId: 0,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: themewhitecolor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        // alignment: Alignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.network(
                                            // "assets/images/png/kitchen.png",
                                            getCategoriesCardApi +
                                                modelValue.categoryCard[index],
                                            // height: 100,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Text(
                                            modelValue.categoryName[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: themeblackcolor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                }),
              ),
              const SizedBox(
                height: 30,
              ),

              ///Professionals
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text.rich(
                      TextSpan(
                        text: "Find ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Professionals",
                            style: TextStyle(
                              color: Palette.themecolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextButton(
                      buttonText: "View All",
                      onTap: () {
                        RouteNavigator.route(
                          context,
                          const CategoryScreen(category: 1, title: "Services"),
                        );
                      },
                      textstyle: const TextStyle(
                        fontSize: 18,
                        color: Palette.themecolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 280,
                child: GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: servicesmodel.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        RouteNavigator.route(
                          context,
                          ProductCategoryScreen(
                            title: servicesmodel[index].title,
                            productCategory: 1,
                            categoryId: "",
                            serviceId: index + 1,
                          ),
                        );
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: themegreytextcolor,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(servicesmodel[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeblackcolor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              servicesmodel[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
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
}
