import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/categories/shop/shop_subcategory_screen.dart';
import 'package:multivendor/views/services/services_product_category.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';

class ProductCategoryScreen extends StatefulWidget {
  final String title;
  final int productCategory;
  final String categoryId;
  //services
  final int serviceId;

  const ProductCategoryScreen({
    Key? key,
    required this.title,
    required this.productCategory,
    required this.categoryId,
    required this.serviceId,
  }) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int activeIndex = 0;

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Index: ${widget.serviceId}");
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: themegreytextcolor,
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
                      color: themegreytextcolor,
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
      body: widget.productCategory == 0
          ? SubCategoryAndProductsScreen(
              catergoryId: widget.categoryId,
              categoryName: widget.title,
            )
          : ServicesProductCategoryScreen(
              serviceId: widget.serviceId,
              tilte: widget.title,
            ),
    );
  }
}
