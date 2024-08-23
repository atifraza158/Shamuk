import 'package:flutter/material.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/checkout/choose_shipping.dart';
import 'package:multivendor/views/enter_pin/enter_pin.dart';
import 'package:multivendor/views/payment/payment_methods.dart';
import 'package:multivendor/widgets/custom_icon_button.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:multivendor/widgets/text_field_input.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final TextEditingController promocodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Checkout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: themewhitecolor,
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRoundedButton(
              buttonText: "Continue to Order",
              onTap: () {
                RouteNavigator.route(
                  context,
                  const EnterPinScreen(),
                );
              },
              buttoncolor: Palette.themecolor,
              buttontextcolor: themewhitecolor,
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.85,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shipping Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // RouteNavigator.route(context, ShippingAddressScreen());
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
                      const CircleAvatar(
                        backgroundColor: themegreycolor,
                        child: CircleAvatar(
                          backgroundColor: themeblackcolor,
                          radius: 15,
                          child: Icon(
                            Icons.room,
                            color: themewhitecolor,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Home",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Unit no 10, Latifabad, Hyderabad",
                            style: TextStyle(
                                color: themegreytextcolor, fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomIconButton(
                        onTap: () {},
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 50,
              ),
              const Text(
                "Order List",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
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
                                index == 0
                                    ? "https://www.cavani.co.uk/images/house-of-cavani-caridi-navy-three-piece-suit-p1244-25727_zoom.jpg"
                                    : index == 1
                                        ? "https://pepperland.pk/cdn/shop/files/PGTS-523-02_1_1024x1024.jpg?v=1686828166"
                                        : index == 2
                                            ? "https://www.hangree.com.pk/cdn/shop/products/2_238a743e-ea1b-4a5e-9fd0-276b1f0d5f2f_2000x.jpg?v=1594401393"
                                            : "https://static-01.daraz.pk/p/bc2bad088c7bc9eac8607526f14ac098.jpg",
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
                                  index == 0
                                      ? "3 Piece Suit"
                                      : index == 1
                                          ? "T-Shirt"
                                          : index == 2
                                              ? "Denim Jeans"
                                              : "Leather Jacket",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: const [
                                    CircleAvatar(
                                      radius: 6,
                                      backgroundColor: themeblackcolor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Color",
                                      style: TextStyle(
                                          color: themegreytextcolor,
                                          fontSize: 12),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      "Size = M",
                                      style: TextStyle(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0
                                        ? "Rs.7999/-"
                                        : index == 1
                                            ? "Rs.999/-"
                                            : index == 2
                                                ? "Rs.3499/-"
                                                : "Rs.4999/-",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: themegreycolor,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: themeblackcolor,
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
              const Divider(
                height: 50,
              ),
              const Text(
                "Choose Shipping",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  RouteNavigator.route(context, const ChooseShippingScreen());
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
                      const CircleAvatar(
                        backgroundColor: themegreycolor,
                        child: CircleAvatar(
                          backgroundColor: themeblackcolor,
                          radius: 15,
                          child: Icon(
                            Icons.fire_truck,
                            color: themewhitecolor,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Choose Shipping Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      CustomIconButton(
                        onTap: () {},
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 50,
              ),
              const Text(
                "Promo Code",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: TextFieldInput(
                      textEditingController: promocodeController,
                      hintText: "Enter Promo Code",
                      textInputType: TextInputType.text,
                      icon: const Icon(
                        Icons.code,
                        size: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // RouteNavigator.route(context, AddPromo());
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Palette.themecolor,
                      child: Icon(
                        Icons.add,
                        color: themewhitecolor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 15.0),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Amount"),
                        Text("Rs.17499/-"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Shipping"),
                        Text("-"),
                      ],
                    ),
                    const Divider(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Total"),
                        Text("-"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
