import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

propertyMapImagesWidget(properties_pro modelValue,List decodedPropertyMapImages, Size size){

  return  decodedPropertyMapImages.isEmpty
                                ? Center(
                                    child: Image.asset(
                                      "assets/images/png/404.png",
                                      height: 250,
                                      width: 250,
                                    ),
                                  )
                                : SizedBox(
                                    height: 140,
                                    child: GridView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount:
                                          decodedPropertyMapImages.length,
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
                                                Image.network(
                                                    getProductDetailSliderMapCardApi +
                                                        decodedPropertyMapImages[
                                                            index]));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                getProductDetailSliderMapCardApi +
                                                    decodedPropertyMapImages[
                                                        index],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 140,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: themegreycolor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getProductDetailSliderMapCardApi +
                                                        decodedPropertyMapImages[
                                                            index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: themegreycolor,
                                              highlightColor:
                                                  themegreytextcolor,
                                              child: Container(
                                                width: size.width,
                                                height: 200.0,
                                                decoration: const BoxDecoration(
                                                  color: themegreycolor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                        
  
  
  
  }