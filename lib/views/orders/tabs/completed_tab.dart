import 'package:flutter/material.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/provider/order_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/orders/order_detail_screen.dart';
import 'package:multivendor/views/orders/review/leave_reaview_screen.dart';
import 'package:provider/provider.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({Key? key}) : super(key: key);

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<order_pro>(builder: ((context, orderValue, child) {
      return orderValue.ordersListIsLoading
          ? const Center(child: CircularProgressIndicator())
          : orderValue.orderName.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/png/empty_box.png",
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "No Orders Available",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  itemCount: orderValue.orderName.length,
                  itemBuilder: (context, index) {
                    return orderValue.orderStatus[index].toString() == "2"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InkWell(
                              onTap: () { RouteNavigator.route(
                                                context,
                                                OrderDetailsScreen(
                                                  orderCode: orderValue
                                                      .orderCode[index],
                                                ));},
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
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderValue.orderName[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email,
                                                size: 15,
                                                color: themegreytextcolor,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                orderValue.orderEmail[index],
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          //phone
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                size: 15,
                                                color: themegreytextcolor,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                orderValue.orderPhone[index],
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: themegreycolor,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              (orderValue.orderStatus[index]
                                                          .toString() ==
                                                      "0")
                                                  ? "Pending"
                                                  : (orderValue.orderStatus[
                                                                  index]
                                                              .toString() ==
                                                          "1")
                                                      ? "Processing"
                                                      : (orderValue.orderStatus[
                                                                      index]
                                                                  .toString() ==
                                                              "2")
                                                          ? "Completed"
                                                          : "",
                                              style: const TextStyle(
                                                  color: themeblackcolor,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${orderValue.orderTime[index]}, ${orderValue.orderDate[index]}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                               
                            
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  });
    }));
  }
}
