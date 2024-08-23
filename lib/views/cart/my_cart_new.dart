import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/cart_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/cart/cart_product_details.dart';
import 'package:multivendor/widgets/Custom_toast_widget.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:provider/provider.dart';

class MyCartNew extends StatefulWidget {
  const MyCartNew({Key? key}) : super(key: key);

  @override
  State<MyCartNew> createState() => _MyCartNewState();
}

class _MyCartNewState extends State<MyCartNew> {
  @override
  void initState() {
    if (Provider.of<auth_pro>(context, listen: false).userId != null) {
      final cartProvider = Provider.of<cart_pro>(context, listen: false);
      cartProvider.getCartProducts(context, 0);
    }

    // cartProvider.getShipmentDetailsFunc(context);
    // final countryProvider = Provider.of<auth_pro>(context, listen: false);
    // countryProvider.getCountryFunc(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: themewhitecolor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "My Cart",
            style: TextStyle(
              color: Palette.themecolor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: Provider.of<auth_pro>(context, listen: false)
                    .userId ==
                null
            ? SizedBox()
            : Consumer<cart_pro>(builder: ((context, cartValue, child) {
                return cartValue.cProductName.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 75,
                        decoration: const BoxDecoration(
                          color: themewhitecolor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cartValue.totalIsloading
                                  ? const Center(
                                      child: CupertinoActivityIndicator())
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Total Price",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Rs. ${cartValue.overallAllCartProductTotal}/-",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                              CustomRoundedButton(
                                buttonText: "Next",
                                onTap: () {
                                  if (cartValue.cProductName.isNotEmpty) {
                                    RouteNavigator.route(
                                        context, CartProductDetails());
                                  } else {
                                    showMyCustomSnackBar(
                                        "Your cart is empty", false, context);
                                  }
                                },
                                buttoncolor: Palette.themecolor,
                                height: kMinInteractiveDimension,
                                width: MediaQuery.of(context).size.width * 0.60,
                                buttontextcolor: themewhitecolor,
                              )
                            ],
                          ),
                        ),
                      );
              })),
        body: Provider.of<auth_pro>(context, listen: false).userId == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 100 * 4,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/svg/add-to-cart.svg",
                      height: 250,
                      width: 250,
                    ),
                  ),
                ],
              )
            : Consumer<cart_pro>(builder: ((context, modelValue, child) {
                return modelValue.cartProductLoading
                    ? const Center(child: CircularProgressIndicator())
                    : modelValue.cProductName.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height / 100 * 4,
                              ),
                              Center(
                                child: SvgPicture.asset(
                                  "assets/images/svg/add-to-cart.svg",
                                  height: 250,
                                  width: 250,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            itemCount: modelValue.cProductName.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: InkWell(
                                  onLongPress: () {
                                    // String pName, String pColor,String pSize, String productCode
                                    removeProductFromCart(
                                        getProductCardApi +
                                            modelValue.cProductCard[index],
                                        modelValue.cProductName[index],
                                        "0xFF${(modelValue.cProductSelectedColors[index]).toString().substring(1)}",
                                        modelValue.cProductSelectedSizes[index],
                                        (((int.parse(modelValue.cProductPrice[
                                                                index]) /
                                                            100) *
                                                        int.parse(modelValue
                                                                .cProductDiscount[
                                                            index]) -
                                                    int.parse(modelValue
                                                        .cProductPrice[index]))
                                                .abs())
                                            .toString(),
                                        modelValue.cProductCode[index],
                                        context,
                                        index);
                                  },
                                  child: Container(
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
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                                color: themegreycolor),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getProductCardApi +
                                                    modelValue
                                                        .cProductCard[index],
                                              ),
                                              fit: BoxFit.cover,
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
                                                  modelValue
                                                      .cProductName[index],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    modelValue.cProductSelectedColors[
                                                                index] ==
                                                            ""
                                                        ? SizedBox()
                                                        : CircleAvatar(
                                                            radius: 6,
                                                            backgroundColor: (modelValue
                                                                            .cProductSelectedColors[
                                                                        index] ==
                                                                    "")
                                                                ? Colors.grey
                                                                : Color(int.parse(
                                                                    "0xFF${(modelValue.cProductSelectedColors[index]).toString().substring(1)}")),
                                                          ),
                                                    modelValue.cProductSelectedColors[
                                                                index] ==
                                                            ""
                                                        ? SizedBox()
                                                        : const SizedBox(
                                                            width: 10,
                                                          ),
                                                    modelValue.cProductSelectedColors[
                                                                index] ==
                                                            ""
                                                        ? SizedBox()
                                                        : const Text(
                                                            "Color",
                                                            style: TextStyle(
                                                                color:
                                                                    themegreytextcolor,
                                                                fontSize: 12),
                                                          ),
                                                    const VerticalDivider(),
                                                    modelValue.cProductSelectedSizes[
                                                                index] ==
                                                            ""
                                                        ? SizedBox()
                                                        : Text(
                                                            "Size = ${(modelValue.cProductSelectedSizes[index] == "") ? "" : modelValue.cProductSelectedSizes[index]}",
                                                            style: const TextStyle(
                                                                color:
                                                                    themegreytextcolor,
                                                                fontSize: 12),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Text(
                                              //       "Rs.${int.parse(modelValue.cProductPrice[index]) * int.parse(modelValue.cProductQuantity[index])}/-",
                                              //       // "Rs.${(((((int.parse(modelValue.cProductPrice[index]) / 100) * int.parse(modelValue.cProductDiscount[index]) - int.parse(modelValue.cProductPrice[index])).abs()))) * int.parse(modelValue.cProductQuantity[index])}/-",

                                              //       style: const TextStyle(
                                              //           fontWeight: FontWeight.bold),
                                              //     ),
                                              //     Container(
                                              //       padding:
                                              //           const EdgeInsets.symmetric(
                                              //               vertical: 8,
                                              //               horizontal: 20),
                                              //       decoration: BoxDecoration(
                                              //         color: Palette.themecolor,
                                              //         borderRadius:
                                              //             BorderRadius.circular(20.0),
                                              //       ),
                                              //       child: Row(
                                              //         children: [
                                              //           modelValue.ontapIncreamentDecrement ==
                                              //                   1
                                              //               ? const SizedBox(
                                              //                   height: 20,
                                              //                   width: 20,
                                              //                 )
                                              //               : CustomIconButton(
                                              //                   onTap: () {
                                              //                     if (int.parse(modelValue
                                              //                                 .cProductQuantity[
                                              //                             index]) !=
                                              //                         1) {
                                              //                       log("message: ${(int.parse(modelValue.cProductQuantity[index]) - 1)}");
                                              //                       final countProvider =
                                              //                           Provider.of<
                                              //                                   cart_pro>(
                                              //                               context,
                                              //                               listen:
                                              //                                   false);
                                              //                       countProvider.updateCartProductQuantity(
                                              //                           modelValue
                                              //                                   .cProductCode[
                                              //                               index],
                                              //                           (int.parse(modelValue
                                              //                                       .cProductQuantity[index]) -
                                              //                                   1)
                                              //                               .toString(),
                                              //                           context);
                                              //                     } else {
                                              //                       removeProductFromCart(
                                              //                           getProductCardApi +
                                              //                               modelValue
                                              //                                       .cProductCard[
                                              //                                   index],
                                              //                           modelValue
                                              //                                   .cProductName[
                                              //                               index],
                                              //                           "0xFF${(modelValue.cProductSelectedColors[index]).toString().substring(1)}",
                                              //                           modelValue
                                              //                                   .cProductSelectedSizes[
                                              //                               index],
                                              //                           (((int.parse(modelValue.cProductPrice[index]) / 100) * int.parse(modelValue.cProductDiscount[index]) -
                                              //                                       int.parse(modelValue.cProductPrice[
                                              //                                           index]))
                                              //                                   .abs())
                                              //                               .toString(),
                                              //                           modelValue
                                              //                                   .cProductCode[
                                              //                               index],
                                              //                           context,
                                              //                           index);
                                              //                     }
                                              //                   },
                                              //                   child: const Icon(
                                              //                     Icons.remove,
                                              //                     color:
                                              //                         themewhitecolor,
                                              //                     size: 25,
                                              //                   ),
                                              //                 ),
                                              //           const SizedBox(
                                              //             width: 10,
                                              //           ),
                                              //           Text(
                                              //             modelValue.cProductQuantity[
                                              //                 index],
                                              //             style: const TextStyle(
                                              //                 color: themewhitecolor,
                                              //                 fontSize: 15),
                                              //           ),
                                              //           const SizedBox(
                                              //             width: 10,
                                              //           ),
                                              //           modelValue.ontapIncreamentDecrement ==
                                              //                   1
                                              //               ? const SizedBox(
                                              //                   height: 20,
                                              //                   width: 20,
                                              //                 )
                                              //               : CustomIconButton(
                                              //                   onTap: () {
                                              //                     log("message: ${(int.parse(modelValue.cProductQuantity[index]) + 1)}");
                                              //                     log("modelValue.cProductStock: ${modelValue.cProductStock[index]}");
                                              //                     if (modelValue
                                              //                                 .cProductStock[
                                              //                             index] !=
                                              //                         0) {
                                              //                       final countProvider =
                                              //                           Provider.of<
                                              //                                   cart_pro>(
                                              //                               context,
                                              //                               listen:
                                              //                                   false);
                                              //                       countProvider.updateCartProductQuantity(
                                              //                           modelValue
                                              //                                   .cProductCode[
                                              //                               index],
                                              //                           (int.parse(modelValue
                                              //                                       .cProductQuantity[index]) +
                                              //                                   1)
                                              //                               .toString(),
                                              //                           context);
                                              //                     } else {
                                              //                       showMyCustomSnackBar(
                                              //                           "This Product does not have more stock.",
                                              //                           true,
                                              //                           context);
                                              //                     }
                                              //                   },
                                              //                   child: const Icon(
                                              //                     Icons.add,
                                              //                     color:
                                              //                         themewhitecolor,
                                              //                     size: 25,
                                              //                   ),
                                              //                 ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),

                                              QuantityButtonWidget(
                                                quantity: int.parse(modelValue
                                                    .cProductQuantity[index]
                                                    .toString()),
                                                price: int.parse(modelValue
                                                    .cProductPrice[index]
                                                    .toString()),
                                                productCode: modelValue
                                                    .cProductCode[index],
                                                index: index,
                                                stock: int.parse(modelValue
                                                    .cProductStock[index]
                                                    .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
              })));
  }
}

class QuantityButtonWidget extends StatefulWidget {
  final int quantity;
  final int price;
  final int stock;
  final int index;
  final String productCode;

  const QuantityButtonWidget({
    Key? key,
    required this.quantity,
    required this.price,
    required this.productCode,
    required this.index,
    required this.stock,
  }) : super(key: key);

  @override
  State<QuantityButtonWidget> createState() => _QuantityButtonWidgetState();
}

class _QuantityButtonWidgetState extends State<QuantityButtonWidget> {
  int price = 0;
  int quantity = 0;
  @override
  void initState() {
    price = widget.price;
    quantity = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Rs.${price * quantity}/-",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            final modelValue = Provider.of<cart_pro>(context, listen: false);
            removeProductFromCart(
                getProductCardApi + modelValue.cProductCard[widget.index],
                modelValue.cProductName[widget.index],
                "0xFF${(modelValue.cProductSelectedColors[widget.index]).toString().substring(1)}",
                modelValue.cProductSelectedSizes[widget.index],
                (((int.parse(modelValue.cProductPrice[widget.index]) / 100) *
                                int.parse(
                                    modelValue.cProductDiscount[widget.index]) -
                            int.parse(modelValue.cProductPrice[widget.index]))
                        .abs())
                    .toString(),
                modelValue.cProductCode[widget.index],
                context,
                widget.index);
          },
          icon: Icon(Icons.delete_forever),
          color: themeredcolor,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            color: Palette.themecolor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              CustomIconButton(
                onTap: () {
                  if (quantity != 1) {
                    setState(() {
                      quantity -= 1;
                    });
                    final countProvider =
                        Provider.of<cart_pro>(context, listen: false);
                    countProvider.updateCartProductQuantity(
                        widget.productCode, quantity.toString(), context);
                  } else {
                    final modelValue =
                        Provider.of<cart_pro>(context, listen: false);
                    removeProductFromCart(
                        getProductCardApi +
                            modelValue.cProductCard[widget.index],
                        modelValue.cProductName[widget.index],
                        "0xFF${(modelValue.cProductSelectedColors[widget.index]).toString().substring(1)}",
                        modelValue.cProductSelectedSizes[widget.index],
                        (((int.parse(modelValue.cProductPrice[widget.index]) /
                                            100) *
                                        int.parse(modelValue
                                            .cProductDiscount[widget.index]) -
                                    int.parse(
                                        modelValue.cProductPrice[widget.index]))
                                .abs())
                            .toString(),
                        modelValue.cProductCode[widget.index],
                        context,
                        widget.index);
                  }
                },
                child: const Icon(
                  Icons.remove,
                  color: themewhitecolor,
                  size: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(color: themewhitecolor, fontSize: 15),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomIconButton(
                onTap: () {
                  // if (widget.stock != 0) {
                  setState(() {
                    quantity += 1;
                  });
                  final countProvider =
                      Provider.of<cart_pro>(context, listen: false);
                  countProvider.updateCartProductQuantity(
                      widget.productCode, quantity.toString(), context);
                  // } else {
                  //   showMyCustomSnackBar(
                  //       "This Product does not have more stock.",
                  //       true,
                  //       context);
                  // }
                },
                child: const Icon(
                  Icons.add,
                  color: themewhitecolor,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
