import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/categories/shop/shops_category_screen.dart';
import 'package:multivendor/views/property/properties_list_screen.dart';
import 'package:multivendor/views/services/services_category_screen.dart';
import 'package:multivendor/views/wanted/wanted_screen.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  final int category;
  const CategoryScreen({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(
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
                  child: const CircleAvatar(
                    backgroundColor: themewhitecolor,
                    child: Icon(
                      Icons.arrow_back,
                      color: Palette.themecolor,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: widget.category == 0
          ? const ShopsCategoryScreen()
          : widget.category == 1
              ? const ServicesCategoryScreen()
              : widget.category == 2
                  ? const WantedScreen()
                  : widget.category == 3
                      ?  PropertiesListScreen(country: false,)
                      : Container(),
    );
  }
}

class ShopModel {
  final String title;
  final String image;
  ShopModel({
    required this.title,
    required this.image,
  });
}

List<ShopModel> shopmodel = [
  ShopModel(
    title: "Garments",
    image: "assets/images/png/garments.png",
  ),
  ShopModel(
    title: "Kitchen & Dining",
    image: "assets/images/png/kitchen.png",
  ),
  ShopModel(
    title: "Bath",
    image: "assets/images/png/bath.png",
  ),
  ShopModel(
    title: "Bedroom",
    image: "assets/images/png/bedroom.png",
  ),
  ShopModel(
    title: "Living",
    image: "assets/images/png/living.png",
  ),
  ShopModel(
    title: "Lighting",
    image: "assets/images/png/lighting.png",
  ),
  ShopModel(
    title: "Furniture",
    image: "assets/images/png/furniture.png",
  ),
  ShopModel(
    title: "Home Decor",
    image: "assets/images/png/home-decor.png",
  ),
  ShopModel(
    title: "Home Improvement",
    image: "assets/images/png/home-improvement.png",
  ),
  ShopModel(
    title: "Outdoor",
    image: "assets/images/png/outdoor.png",
  ),
  ShopModel(
    title: "Storage & Organization",
    image: "assets/images/png/storage-org.png",
  ),
  ShopModel(
    title: "Holiday Decor",
    image: "assets/images/png/holiday-decor.png",
  ),
  ShopModel(
    title: "Sale",
    image: "assets/images/png/sale.png",
  ),
];
