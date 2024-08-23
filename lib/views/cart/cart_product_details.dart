import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/cart_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_checkout_screen.dart';
import 'order_invoice_screen.dart';

class CartProductDetails extends StatefulWidget {
  CartProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CartProductDetails> createState() => _CartProductDetailsState();
}

class _CartProductDetailsState extends State<CartProductDetails> {
  @override
  void initState() {
    final cartProvider = Provider.of<cart_pro>(context, listen: false);
    cartProvider.getCartProducts(context, 0);
    cartProvider.getShipmentDetailsFunc(context);
    final countryProvider = Provider.of<auth_pro>(context, listen: false);
    countryProvider.getCountryFunc(context);
    super.initState();
  }

//coupon code variables
  final _key = GlobalKey<FormState>();
  final TextEditingController coupanCodeC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 0,
          title: const Text(
            "Cart Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar:
            Consumer<cart_pro>(builder: ((context, modelValue, child) {
          return modelValue.cartProductLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomSimpleRoundedButton(
                    onTap: () {
                      if (modelValue.cProductName.isNotEmpty) {
                        RouteNavigator.route(
                          context,
                          NewCheckoutScreen(
                              total: modelValue.overallAllCartProductTotal,
                              discount: modelValue.couponDiscountValue,
                              save: modelValue.couponSaveValue,
                              shipment:
                                  modelValue.overallAllCartProductShipment,
                              subTotal: ((modelValue
                                          .overallAllCartProductTotal -
                                      modelValue.couponSaveValue) +
                                  modelValue.overallAllCartProductShipment)),
                        );
                      } else {
                        showMyCustomSnackBar(
                            "Your cart is empty", false, context);
                      }
                    },
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    buttoncolor: Palette.themecolor,
                    borderRadius: BorderRadius.circular(8),
                    child: Text(
                      "PROCEED TO CHECKOUT",
                      style: const TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        })),
        body: Consumer<cart_pro>(builder: ((context, modelValue, child) {
          return modelValue.cartProductLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shipment",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomIconButton(
                            onTap: () {
                              shipment(modelValue, size);
                            },
                            child: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      Consumer<cart_pro>(
                          builder: ((context, shipmentValue, child) {
                        return shipmentValue.shipmentDetailsIsLoading
                            ? const CircularProgressIndicator()
                            : Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${shipmentValue.shipmentAddress}, ${shipmentValue.shipmentCity}, ${shipmentValue.shipmentState}, ${shipmentValue.shipmentCountry}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                      })),
                      const Divider(
                        height: 50,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rs.${modelValue.overallAllCartProductTotal}/-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Discount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${modelValue.couponDiscountValue}%",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rs.${modelValue.couponSaveValue}/-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shipment Charges",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rs.${modelValue.overallAllCartProductShipment}/-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs.${(modelValue.overallAllCartProductTotal - modelValue.couponSaveValue) + modelValue.overallAllCartProductShipment}/-",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (modelValue.couponDiscountValue != 0)
                          ? Container(
                              width: size.width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: themegreytextcolor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.check_box,
                                    color: themewhitecolor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Coupon Applied",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: themewhitecolor),
                                  ),
                                ],
                              ),
                            )
                          : Form(
                              key: _key,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // width: size.width / 100 * 70,
                                    flex: 2,
                                    child: TextFormField(
                                        controller: coupanCodeC,
                                        decoration: InputDecoration(
                                            hintText: "Enter Promo Code",
                                            hintStyle:
                                                const TextStyle(fontSize: 14),
                                            border: OutlineInputBorder(
                                                borderSide:
                                                    Divider.createBorderSide(
                                                  context,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    Divider.createBorderSide(
                                                  context,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    Divider.createBorderSide(
                                                  context,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            filled: true,
                                            fillColor: themewhitecolor,
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            prefixIcon: const Icon(
                                              Icons.code,
                                              size: 20,
                                            ),
                                            errorStyle:
                                                const TextStyle(fontSize: 0)),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ("Promo code is empty");
                                          }
                                          return null;
                                        }),
                                  ),
                                  Expanded(
                                    child: CustomRoundedButton(
                                      buttonText: "Check Coupon",
                                      onTap: () {
                                        if (_key.currentState!.validate()) {
                                          final cartProvider =
                                              Provider.of<cart_pro>(context,
                                                  listen: false);
                                          cartProvider.applyCouponFunc(
                                              int.parse(modelValue
                                                  .overallAllCartProductTotal
                                                  .toString()),
                                              coupanCodeC.text,
                                              context);
                                        }
                                      },
                                      buttoncolor: themewhitecolor,
                                      height: kMinInteractiveDimension,
                                      // width: size.width / 100 * 30,
                                      width: double.infinity,
                                    
                                      buttontextcolor: Palette.themecolor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
        })));
  }

  Future<Object?> shipment(cart_pro shipment, size) {
    String? selectedcountryitems = 'Select Country';
    String selectedCountryValue = "0";
    String selectedStateValue = "0";
    String selectedCityValue = "0";
    bool isCountrySelected = false;
    bool isStateSelected = false;

    final _key = GlobalKey<FormState>();
    final TextEditingController addressC =
        TextEditingController(text: shipment.shipmentAddress);

    return showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          titlePadding: const EdgeInsets.all(24),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: SizedBox(
            width: size.width / 100 * 95,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child:
                    Consumer<auth_pro>(builder: ((context, modelValue, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomIconButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_outlined),
                        ),
                      ),
                      const Text(
                        'Shipment',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Country",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),

                          // value: modelValue
                          //     .countryName[int.parse(selectedCountryValue)],
                          items: modelValue.countryName
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
                            setState(() {
                              for (var i = 0;
                                  i < modelValue.countryName.length;
                                  i++) {
                                if (modelValue.countryName[i] == item) {
                                  log("i: $i");
                                  modelValue.countryId[i];
                                  log("modelValue.countryId[i]: ${modelValue.countryId[i]}");
                                  setState(() {
                                    selectedCountryValue =
                                        modelValue.countryId[i];
                                    isCountrySelected = true;
                                    isStateSelected = false;
                                  });

                                  final authProvider = Provider.of<auth_pro>(
                                      context,
                                      listen: false);

                                  authProvider.getStateFunc(
                                      selectedCountryValue, context);

                                  log("selectedCountryValue: $selectedCountryValue");
                                }
                              }
                            });
                          }),

                      const SizedBox(
                        height: 15,
                      ),
                      //state
                      (isCountrySelected)
                          ? DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "State",
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
                              items: modelValue.stateName
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
                                setState(() {
                                  for (var i = 0;
                                      i < modelValue.stateName.length;
                                      i++) {
                                    if (modelValue.stateName[i] == item) {
                                      log("i: $i");
                                      modelValue.stateId[i];
                                      log("modelValue.stateId[i]: ${modelValue.stateId[i]}");
                                      setState(() {
                                        selectedStateValue =
                                            modelValue.stateId[i];
                                        isStateSelected = true;
                                      });
                                      //calling the city func

                                      final authProvider =
                                          Provider.of<auth_pro>(context,
                                              listen: false);

                                      authProvider.getCityFunc(
                                          selectedStateValue, context);
                                      log("selectedStateValue: $selectedStateValue");
                                    }
                                  }
                                });
                              })
                          : Container(
                              width: size.width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: const Text(
                                "State",
                                style: TextStyle(
                                    fontSize: 16, color: themegreytextcolor),
                              ),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      (isStateSelected)
                          ? DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "City",
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
                              items: modelValue.cityName
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
                                setState(() {
                                  for (var i = 0;
                                      i < modelValue.cityName.length;
                                      i++) {
                                    if (modelValue.cityName[i] == item) {
                                      log("i: $i");
                                      modelValue.cityId[i];
                                      log("modelValue.cityId[i]: ${modelValue.cityId[i]}");
                                      setState(() {
                                        selectedCityValue =
                                            modelValue.cityId[i];
                                        // isCountrySelected = true;
                                      });
                                      log("selectedCityValue: $selectedCityValue");
                                    }
                                  }
                                });
                              })
                          : Container(
                              width: size.width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: themegreytextcolor,
                                ),
                              ),
                              child: const Text(
                                "City",
                                style: TextStyle(
                                    fontSize: 16, color: themegreytextcolor),
                              ),
                            ),

                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _key,
                        child: TextFormField(
                            controller: addressC,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: themegreytextcolor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Palette.themecolor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Address",
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address is empty";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomSimpleRoundedButton(
                        onTap: () {
                          log("selectedCountryValue: $selectedCountryValue");
                          log("selectedStateValue: $selectedStateValue");
                          log("selectedCityValue: $selectedCityValue");
                          if (_key.currentState!.validate()) {
                            if (isCountrySelected) {
                              if (isStateSelected) {
                                 final changeProvider =
                                Provider.of<cart_pro>(context, listen: false);
                            changeProvider.updateShipmentDetails(
                                selectedCountryValue,
                                selectedStateValue,
                                selectedCityValue,
                                addressC.text,
                                context);
                              }else{
                                showMyCustomSnackBar(
                                    "Please Select State.", false, context);

                              }
                            } else {
                              showMyCustomSnackBar(
                                  "Please Select Country.", false, context);
                            }

                           
                          }
                        },
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        buttoncolor: Palette.themecolor,
                        borderRadius: BorderRadius.circular(8),
                        child: Text(
                          "Change".toUpperCase(),
                          style: const TextStyle(
                            color: themewhitecolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }))),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> removeProductFromCart(
    String pCard,
    String pName,
    String pColor,
    String pSize,
    String pPrice,
    String productCode,
    BuildContext context,
    int index) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    context: context,
    builder: (context) => RemoveFromCart(
      card: pCard,
      title: pName,
      color: pColor,
      size: pSize,
      price: "Rs.$pPrice/-",
      code: productCode,
    ),
  );
}

class RemoveFromCart extends StatefulWidget {
  final String card;
  final String title;
  final String color;
  final String size;

  final String price;

  final String code;
  const RemoveFromCart({
    Key? key,
    required this.card,
    required this.title,
    required this.color,
    required this.size,
    required this.price,
    required this.code,
  }) : super(key: key);

  @override
  State<RemoveFromCart> createState() => _RemoveFromCartState();
}

class _RemoveFromCartState extends State<RemoveFromCart> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: SizedBox(
        height: 300,
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSimpleRoundedButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttoncolor: themegreycolor,
                  height: kMinInteractiveDimension,
                  width: MediaQuery.of(context).size.width * 0.45,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text("Cancel"),
                ),
                CustomSimpleRoundedButton(
                  onTap: () {
                    final cartProvider =
                        Provider.of<cart_pro>(context, listen: false);
                    // cartProvider.getCartProducts(context);

                    cartProvider.removeProductFromCart(widget.code, context);
                    // Navigator.pop(context);
                  },
                  buttoncolor: Palette.themecolor,
                  height: kMinInteractiveDimension,
                  width: MediaQuery.of(context).size.width * 0.45,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text(
                    "Yes, Remove",
                    style: TextStyle(
                      color: themewhitecolor,
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
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Remove From Cart?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: themegreycolor,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: themewhitecolor,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: themegreycolor),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.card,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor:
                                        Color(int.parse(widget.color)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Color",
                                    // widget.color,
                                    style: TextStyle(
                                        color: themegreytextcolor,
                                        fontSize: 12),
                                  ),
                                  const VerticalDivider(),
                                  Text(
                                    "Size = ${widget.size}",
                                    style: const TextStyle(
                                        color: themegreytextcolor,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
