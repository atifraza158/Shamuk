import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multivendor/provider/category_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/provider/properties_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class ShopFiltersBottomSheet extends StatefulWidget {
  const ShopFiltersBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopFiltersBottomSheet> createState() => _ShopFiltersBottomSheetState();
}

class _ShopFiltersBottomSheetState extends State<ShopFiltersBottomSheet> {
  //filters values
  final keywordsC = TextEditingController();
  String selectedCategoryValue = "0";
  String selectedSubCategoryValue = "0";
  bool mostViewed = false;
  bool topRated = false;
  final selectedMinValue = TextEditingController(text: "0");
  final selectedMaxValue = TextEditingController(text: "0");
  //

  // service
  List<String> serviceitems = [
    'Select Service',
    'Carpenter',
  ];
  String? selectedserviceitems = 'Select Service';

  // category
  List<String> categoryitems = [
    'Select Category',
    'Mobiles',
    'Dining',
  ];
  String selectedcategoryitems = 'Select Category';

  // subcategory
  List<String> subcategoryitems = [
    'Select Sub Category',
    'Used Mobile',
  ];
  String? selectedsubcategoryitems = 'Select Sub Category';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.transparent),
          backgroundColor: themewhitecolor,
          centerTitle: true,
          elevation: 1,
          title: const Text(
            "Shop Filters",
            style: TextStyle(
              color: themeblackcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themewhitecolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: themegreycolor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//clear all
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tell us what you want",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomSimpleRoundedButton(
                        onTap: () {
                          final productProvider =
                              Provider.of<products_pro>(context, listen: false);

                          productProvider.getProducts(
                              keywordsC.text, "", "", "", "", "", "", context);

                          Navigator.pop(context);
                        },
                        buttoncolor: themeorangecolor,
                        height: size.height / 100 * 4,
                        width: size.width / 100 * 20,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text(
                          "Clear All",
                          style: TextStyle(
                            color: themewhitecolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  //keywords
                  Row(
                    children: const [
                      Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Keywords",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: keywordsC,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: themegreytextcolor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Palette.themecolor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "Keywords",
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //category
                  Row(
                    children: const [
                      Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<category_pro>(
                      builder: ((context, modelValue, child) {
                    return modelValue.categoriesIsLoading
                        ? const CircularProgressIndicator()
                        : modelValue.categoryName.isEmpty
                            ? const Text("No Categories Available")
                            : DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: themegreytextcolor),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Palette.themecolor),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                // value: "Select Category",
                                items: modelValue.categoryName
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: themeblackcolor,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (item) {
                                  for (var i = 0;
                                      i < modelValue.categoryName.length;
                                      i++) {
                                    if (modelValue.categoryName[i] == item) {
                                      log("i: $i");

                                      setState(() {
                                        // selectedCategoryValue = i.toString();
                                        selectedCategoryValue = "${i + 1}";
                                      });

                                      log("selectedCategoryValue: $selectedCategoryValue");

                                      final subCategoryProvider =
                                          Provider.of<category_pro>(context,
                                              listen: false);
                                      subCategoryProvider
                                          .getShopSubCategoriesByIdFunc(
                                              modelValue.categoryId[i],
                                              context);
                                      break;
                                    }
                                  }
                                });
                  })),

                  const SizedBox(
                    height: 30,
                  ),
//sub category
                  (selectedCategoryValue != "0")
                      ? Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  color: Palette.themecolor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Text(
                                  "Sub Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<category_pro>(
                                builder: ((context, modelValue, child) {
                              return modelValue.subCategoriesIsLoading
                                  ? const CircularProgressIndicator()
                                  : modelValue.subCategoryName.isEmpty
                                      ? const Text("No Data")
                                      : DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: themegreytextcolor),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Palette.themecolor),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12),
                                          ),
                                          // value: selectedsubcategoryitems,
                                          items: modelValue.subCategoryName
                                              .map(
                                                (item) => DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: themeblackcolor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (item) {
                                            for (var i = 0;
                                                i <
                                                    modelValue
                                                        .subCategoryName.length;
                                                i++) {
                                              if (modelValue
                                                      .subCategoryName[i] ==
                                                  item) {
                                                log("i: $i");

                                                setState(() {
                                                  selectedSubCategoryValue =
                                                      "${i + 1}";
                                                });

                                                log("selectedSubCategoryValue: $selectedSubCategoryValue");
                                              }
                                            }
                                          });
                            })),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : Container(),

                  ExpansionTile(
                    title: const Text("Suggested Filters"),
                    tilePadding: EdgeInsets.zero,
                    children: [
                      CheckboxListTile(
                        value: topRated,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        activeColor: Palette.themecolor,
                        title: const Text(
                          "Top Rated",
                          style: TextStyle(
                            color: themeblackcolor,
                            fontSize: 14,
                          ),
                        ),
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: themegreytextcolor,
                          width: 2,
                        ),
                        onChanged: (bool? newValue) {
                          setState(() {
                            topRated = newValue!;
                            log("topRated: $topRated");
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: mostViewed,
                        contentPadding: EdgeInsets.zero,
                        activeColor: Palette.themecolor,
                        dense: true,
                        title: const Text(
                          "Most Viewed",
                          style: TextStyle(
                            color: themeblackcolor,
                            fontSize: 14,
                          ),
                        ),
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: themegreytextcolor,
                          width: 2,
                        ),
                        onChanged: (bool? newValue) {
                          setState(() {
                            mostViewed = newValue!;
                            log("mostViewed: $mostViewed");
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Palette.themecolor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: selectedMinValue,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "100",
                            hintStyle: const TextStyle(
                              color: themeblackcolor,
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "To",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: selectedMaxValue,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "200",
                            hintStyle: const TextStyle(
                              color: themeblackcolor,
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  CustomSimpleRoundedButton(
                    onTap: () {
                      final productProvider =
                          Provider.of<products_pro>(context, listen: false);

                      productProvider.getProducts(
                          keywordsC.text,
                          selectedCategoryValue,
                          selectedSubCategoryValue,
                          selectedMinValue.text,
                          selectedMaxValue.text,
                          (topRated ? "1" : "0"),
                          (mostViewed ? "1" : "0"),
                          context);
                      Navigator.pop(context);
                    },
                    buttoncolor: Palette.themecolor,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(12),
                    child: const Text(
                      "FIND",
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
