import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/product_pro.dart';
import 'package:multivendor/provider/services_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:multivendor/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class LeaveReviewScreen extends StatefulWidget {
  final String productUrl;
  final int reviveType;

  const LeaveReviewScreen({
    Key? key,
    required this.productUrl,
    required this.reviveType,
  }) : super(key: key);

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();
  double ratingv = 1;

  @override
  Widget build(BuildContext context) {
    final userPro = Provider.of<auth_pro>(context);
    log("userPro.getUserId: ${userPro.getUserId}");
    log("productUrl: ${widget.productUrl}");

    //0 products
    //1 professionals
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: SizedBox(
            height: 500,
            child: (widget.reviveType == 0)
                ? Consumer<products_pro>(
                    builder: ((context, modelValue, child) {
                    return modelValue.productReviewIsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Scaffold(
                            bottomNavigationBar: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomSimpleRoundedButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    buttoncolor: themegreytextcolor,
                                    height: kMinInteractiveDimension,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  CustomSimpleRoundedButton(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        final reviewProvider =
                                            Provider.of<products_pro>(context,
                                                listen: false);
                                        reviewProvider.giveProductRatingFunc(
                                            widget.productUrl,
                                            ratingv,
                                            messageController.text,
                                            context);
                                      }
                                    },
                                    buttoncolor: Palette.themecolor,
                                    height: kMinInteractiveDimension,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 5,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Leave a Review?",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Text(
                                    "Please give your rating & also your review..",
                                    style: TextStyle(
                                      color: themegreytextcolor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RatingBar.builder(
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    unratedColor: Colors.amber.withAlpha(50),
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratingv = rating;
                                      });
                                      log("RatingValue: $ratingv");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        filled: true,
                                        contentPadding: const EdgeInsets.all(8),
                                        prefixIcon: const Icon(
                                          Icons.photo_outlined,
                                          size: 20,
                                        ),
                                        hintText:
                                            "Very good product and fast delivery!",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please type something..";
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  }))
                : Consumer<services_pro>(
                    builder: ((context, modelValue, child) {
                    return modelValue.professionalReviewIsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Scaffold(
                            bottomNavigationBar: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomSimpleRoundedButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    buttoncolor: themegreytextcolor,
                                    height: kMinInteractiveDimension,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  CustomSimpleRoundedButton(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        final reviewProvider =
                                            Provider.of<services_pro>(context,
                                                listen: false);
                                        reviewProvider.giveProfessionalRatingFunc(
                                            widget.productUrl,
                                            ratingv,
                                            messageController.text,
                                            context);
                                      }
                                    },
                                    buttoncolor: Palette.themecolor,
                                    height: kMinInteractiveDimension,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 5,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Leave a Review?",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Text(
                                    "Please give your rating & also your review..",
                                    style: TextStyle(
                                      color: themegreytextcolor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RatingBar.builder(
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    unratedColor: Colors.amber.withAlpha(50),
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratingv = rating;
                                      });
                                      log("RatingValue: $ratingv");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                Divider.createBorderSide(
                                              context,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        filled: true,
                                        contentPadding: const EdgeInsets.all(8),
                                        prefixIcon: const Icon(
                                          Icons.photo_outlined,
                                          size: 20,
                                        ),
                                        hintText:
                                            "Very good professional and Good work!",
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please type something..";
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  }))));
  }
}
