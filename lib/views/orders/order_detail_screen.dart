import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/apis/apis_list.dart';
import 'package:multivendor/provider/order_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  String orderCode;
  OrderDetailsScreen({super.key, required this.orderCode});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    log("OrderCode: ${widget.orderCode}");
    final orderProvider = Provider.of<order_pro>(context, listen: false);
    orderProvider.getOrderDetailSummaryFunc(widget.orderCode, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomIconButton(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: themewhitecolor.withOpacity(0.5),
              child: const Icon(
                CupertinoIcons.back,
                color: Palette.themecolor,
              ),
            ),
          ),
        ),
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Consumer<order_pro>(builder: ((context, orderValue, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Customer Info",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderValue.dorderName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderValue.dorderEmail,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Phone",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orderValue.dorderPhone,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Order info",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Order ID",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "#${orderValue.dorderOrderId}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (orderValue.dorderStatus.toString() == "0")
                          ? "Pending"
                          : (orderValue.dorderStatus.toString() == "1")
                              ? "Processing"
                              : (orderValue.dorderStatus.toString() == "2")
                                  ? "Completed"
                                  : "",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date & Time",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${orderValue.dorderTime}, ${orderValue.dorderDate}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Coupon",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (orderValue.dorderCoupon.toString() != "null")
                          ? "Applied"
                          : "Not Applied",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Delivery",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Country",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      orderValue.dorderCountry,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "State",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      orderValue.dorderState,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "City",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      orderValue.dorderCity,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Address",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      orderValue.dorderAddress,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Payments",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Rs. ${orderValue.dorderTotal}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Save",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Rs. ${orderValue.dorderSave}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Shipping cost",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Rs. ${orderValue.dorderShipment}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subtotal",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (orderValue.dorderShipment == "" &&
                              orderValue.dorderTotal == "")
                          ? ""
                          : "Rs. ${(int.parse(orderValue.dorderShipment.toString()) + int.parse(orderValue.dorderTotal.toString()))}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 30),
                const Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: orderValue.dCartName.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: themegreytextcolor),
                            color: themewhitecolor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff9D3CFF)
                                              .withOpacity(0.7),
                                          const Color(0xff9D3CFF)
                                              .withOpacity(0.5),
                                          const Color(0xff9D3CFF)
                                              .withOpacity(0.3),
                                          const Color(0xff9D3CFF)
                                              .withOpacity(0.1),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Image.network(
                                      getProductCardApi +
                                          orderValue.dCartCard[index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          orderValue.dCartName[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        IntrinsicHeight(
                                          child: Wrap(
                                            children: [
                                              // CircleAvatar(
                                              //   radius: 6,
                                              //   backgroundColor: orderValue
                                              //                   .dCartColor[
                                              //               index] ==
                                              //           null
                                              //       ? null
                                              //       : Color(0xff),
                                              // ),
                                              // const SizedBox(
                                              //   width: 10,
                                              // ),
                                              const Text(
                                                "Color",
                                                style: TextStyle(
                                                    color: themegreytextcolor,
                                                    fontSize: 12),
                                              ),
                                              const VerticalDivider(),
                                              Text(
                                                "Qty = ${orderValue.dCartQty[index]}",
                                                style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontSize: 12),
                                              ),
                                              const VerticalDivider(),
                                              Text(
                                                "Price = ${orderValue.dCartPrice[index]}",
                                                style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontSize: 12),
                                              ),
                                              const VerticalDivider(),
                                              Text(
                                                "Charges = ${double.parse(orderValue.dCartCharges[index].toString()) * double.parse(orderValue.dCartQty[index])}",
                                                style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontSize: 12),
                                              ),
                                              const VerticalDivider(),
                                              Text(
                                                "Total = ${(int.parse(orderValue.dCartPrice[index]) + int.parse(orderValue.dCartCharges[index])) * int.parse(orderValue.dCartQty[index])}",
                                                style: const TextStyle(
                                                    color: themegreytextcolor,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: themegreytextcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Text(
                                                  (orderValue.dCartStatus[index]
                                                              .toString() ==
                                                          "0")
                                                      ? "Pending"
                                                      : (orderValue.dCartStatus[
                                                                      index]
                                                                  .toString() ==
                                                              "1")
                                                          ? "Processing"
                                                          : (orderValue
                                                                      .dCartStatus[
                                                                          index]
                                                                      .toString() ==
                                                                  "2")
                                                              ? "Completed"
                                                              : "",
                                                  style: const TextStyle(
                                                      color: themewhitecolor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        }))),
      ),
    );
  }
}
