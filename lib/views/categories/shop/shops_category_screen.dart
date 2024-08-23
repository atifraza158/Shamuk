import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/category_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/categories/category_screen.dart';
import 'package:multivendor/views/categories/shop/shop_filters_bottem_sheet.dart';
import 'package:multivendor/views/product_category/product_category_screen.dart';
import 'package:multivendor/views/product_details/product_details_screen.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_outlined_button.dart';
import 'package:multivendor/widgets/shimmers/maincategoryproduct_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShopsCategoryScreen extends StatefulWidget {
  const ShopsCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopsCategoryScreen> createState() => _ShopsCategoryScreenState();
}

class _ShopsCategoryScreenState extends State<ShopsCategoryScreen> {
  @override
  void initState() {
    final categoryProvider = Provider.of<category_pro>(context, listen: false);
    categoryProvider.getShopCategoriesFunc(context);

    final productProvider = Provider.of<products_pro>(context, listen: false);

    productProvider.getProducts("", "", "", "", "", "", "", context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // filters
          // Align(
          //   alignment: AlignmentDirectional.topEnd,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: CustomOutlinedButton(
          //       onTap: () async {},
          //       height: 55,
          //       width: size.width,
          //       borderRadius: BorderRadius.circular(12),
          //       borderColor: Palette.themecolor,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           Icon(
          //             Icons.poll,
          //             color: Palette.themecolor,
          //           ),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           Text(
          //             "Filters",
          //             style: TextStyle(
          //               color: Palette.themecolor,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(
            height: 20,
          ),
          //Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(
                  TextSpan(
                    text: "Find ",
                    style: TextStyle(
                      color: themeblackcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Categories",
                        style: TextStyle(
                          color: Palette.themecolor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // CustomIconButton(
                //   onTap: () {
                //     showModalBottomSheet(
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //       ),
                //       context: context,
                //       builder: (context) => const ShopFiltersBottomSheet(),
                //     );
                //   },
                //   child: const CircleAvatar(
                //     backgroundColor: Palette.themecolor,
                //     child: Icon(
                //       Icons.search,
                //       color: themewhitecolor,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
//categories
          Consumer<category_pro>(builder: ((context, modelValue, child) {
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
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        itemCount: modelValue.categoryName.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 80,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              RouteNavigator.route(
                                context,
                                ProductCategoryScreen(
                                  title: modelValue.categoryName[index],
                                  productCategory: 0,
                                  categoryId: modelValue.categoryId[index],
                                  serviceId: 0,
                                ),
                              );
                            },
                            child: Container(
                              width: size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: themegreycolor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      modelValue.categoryName[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: themeblackcolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Container(
                                  //   height: 50,
                                  //   width: 80,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(
                                  //         getCategoriesCardApi +
                                  //             modelValue.categoryCard[index],
                                  //       ),
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      getCategoriesCardApi +
                                          modelValue.categoryCard[index],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   width: size.width,
                            //   decoration: BoxDecoration(
                            //       color: themeblackcolor,
                            //       borderRadius: BorderRadius.circular(25)),
                            //   child: Stack(
                            //     alignment: AlignmentDirectional.bottomEnd,
                            //     children: [
                            //       ClipRRect(
                            //         borderRadius: BorderRadius.circular(15),
                            //         child: Image.network(
                            //           getCategoriesCardApi +
                            //               modelValue.categoryCard[index],
                            //           height: size.height / 100 * 15,
                            //           width: size.width,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //       Container(
                            //         width: size.width,
                            //         height: size.height / 100 * 15,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(15),
                            //           color: themeblackcolor.withOpacity(0.3),
                            //         ),
                            //       ),
                            //       Container(
                            //         width: size.width,
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 15, vertical: 10),
                            //         decoration: BoxDecoration(
                            //           color: themeblackcolor.withOpacity(0.8),
                            //           borderRadius: const BorderRadius.only(
                            //             bottomLeft: Radius.circular(15),
                            //             bottomRight: Radius.circular(15),
                            //           ),
                            //         ),
                            //         child: Text(
                            //           modelValue.categoryName[index],
                            //           style: const TextStyle(
                            //             fontSize: 17,
                            //             color: themewhitecolor,
                            //             fontWeight: FontWeight.w600,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          );
                        },
                      );
          })),
          //shop products
        
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Text.rich(
          //     TextSpan(
          //       text: "Shop ",
          //       style: TextStyle(
          //         color: themeblackcolor,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       children: [
          //         TextSpan(
          //           text: "Products",
          //           style: TextStyle(
          //             color: Palette.themecolor,
          //             fontSize: 22,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Consumer<products_pro>(
          //   builder: ((context, modelValue, child) {
          //     return modelValue.productsIsLoading
          //         ? const MainCategoriesProductLoadingWidget()
          //         : modelValue.productName.isEmpty
          //             ? Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Center(
          //                     child: Image.asset(
          //                       "assets/images/png/empty_box.png",
          //                       height: 250,
          //                       width: 250,
          //                     ),
          //                   ),
          //                   const Text(
          //                     "No Products availables",
          //                     style: TextStyle(
          //                       color: themeblackcolor,
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   )
          //                 ],
          //               )
          //             : GridView.builder(
          //                 padding: const EdgeInsets.all(20),
          //                 primary: false,
          //                 shrinkWrap: true,
          //                 itemCount: modelValue.productName.length,
          //                 gridDelegate:
          //                     const SliverGridDelegateWithFixedCrossAxisCount(
          //                   crossAxisCount: 2,
          //                   mainAxisExtent: 257,
          //                   mainAxisSpacing: 20,
          //                   crossAxisSpacing: 20,
          //                 ),
          //                 itemBuilder: (context, index) {
          //                   return CachedNetworkImage(
          //                     imageUrl: getProductCardApi +
          //                         modelValue.productCard[index],
          //                     imageBuilder: (context, imageProvider) =>
          //                         GestureDetector(
          //                       onTap: () {
          //                         RouteNavigator.route(
          //                             context,
          //                             ProductDetailsScreen(
          //                               isProjectDetails: false,
          //                               productUrl:
          //                                   modelValue.productUrl[index],
          //                             ));
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(15),
          //                           color: themewhitecolor,
          //                           boxShadow: const [
          //                             BoxShadow(
          //                               color: themegreycolor,
          //                               blurRadius: 10,
          //                               offset: Offset(5, 0),
          //                             ),
          //                           ],
          //                         ),
          //                         child: Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Stack(
          //                               children: [
          //                                 Container(
          //                                   height: 150,
          //                                   width: size.width,
          //                                   decoration: BoxDecoration(
          //                                     borderRadius:
          //                                         const BorderRadius.only(
          //                                       topLeft: Radius.circular(15),
          //                                       topRight: Radius.circular(15),
          //                                     ),
          //                                     image: DecorationImage(
          //                                       image: NetworkImage(
          //                                         getProductCardApi +
          //                                             modelValue
          //                                                 .productCard[index],
          //                                       ),
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                             Padding(
          //                               padding: const EdgeInsets.all(10.0),
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     modelValue.productCategory[index],
          //                                     overflow: TextOverflow.ellipsis,
          //                                     style: const TextStyle(
          //                                       color: themeblackcolor,
          //                                       fontSize: 18,
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 5,
          //                                   ),
          //                                   SizedBox(
          //                                     width: size.width / 100 * 20,
          //                                     child: Text(
          //                                       modelValue.productName[index],
          //                                       overflow: TextOverflow.ellipsis,
          //                                       style: const TextStyle(
          //                                         color: themegreytextcolor,
          //                                         fontSize: 14,
          //                                         fontWeight: FontWeight.bold,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 2,
          //                                   ),
          //                                   Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment
          //                                             .spaceBetween,
          //                                     children: [
          //                                       Text(
          //                                         "Rs.${(((int.parse(modelValue.productPrice[index]) / 100) * int.parse(modelValue.productDiscount[index]) - int.parse(modelValue.productPrice[index])).abs())}/-",
          //                                         style: const TextStyle(
          //                                           fontFamily: 'Ubuntu-Bold',
          //                                           fontSize: 18,
          //                                           color: Palette.themecolor,
          //                                           fontWeight: FontWeight.bold,
          //                                         ),
          //                                       ),
          //                                       const Icon(
          //                                         Icons
          //                                             .arrow_circle_right_sharp,
          //                                         color: Palette.themecolor,
          //                                         size: 35,
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     placeholder: (context, url) => Shimmer.fromColors(
          //                       baseColor: themegreycolor,
          //                       highlightColor: themegreytextcolor,
          //                       child: Container(
          //                         width: size.width,
          //                         height: 150.0,
          //                         decoration: BoxDecoration(
          //                           color: themegreycolor,
          //                           borderRadius: BorderRadius.circular(12),
          //                         ),
          //                       ),
          //                     ),
          //                     errorWidget: (context, url, error) =>
          //                         const Icon(Icons.error),
          //                   );
          //                 },
          //               );
          //   }),
          // ),

        
        ],
      ),
    );
  }

  Widget shimmerHomePropertyLoadingEffect() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Row(
            children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 3,
            ),
            child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                )),
          );
        })),
      ),
    );
  }
}

/**
 * // child: Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.topLeft,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(left: 20.0),
                          //         child: Text(
                          //           modelValue.categoryName[index],
                          //           style: const TextStyle(
                          //             color: themewhitecolor,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Align(
                          //       alignment: Alignment.bottomRight,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(top: 20.0),
                          //         child: Image.network(
                          //           getCategoriesCardApi +
                          //               modelValue.categoryCard[index],
                          //           height: 100,
                          //           width: 200,
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
 */