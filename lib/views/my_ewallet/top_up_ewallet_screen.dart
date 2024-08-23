import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/my_ewallet/top_up_enter_pin_screen.dart';
import 'package:multivendor/widgets/custom_credit_card.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';

class TopUpEwalletScreen extends StatefulWidget {
  const TopUpEwalletScreen({Key? key}) : super(key: key);

  @override
  State<TopUpEwalletScreen> createState() => _TopUpEwalletScreenState();
}

class _TopUpEwalletScreenState extends State<TopUpEwalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Top-Up E-Wallet",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomRoundedButton(
          buttonText: "Continue",
          onTap: () {
            RouteNavigator.route(context, const TopUpEnterPinScreen());
          },
          buttoncolor: Palette.themecolor,
          buttontextcolor: themewhitecolor,
          height: kMinInteractiveDimension,
          width: MediaQuery.of(context).size.width * 0.85,
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20.0),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20.0),
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
                    SvgPicture.asset(
                      "assets/images/svg/wallet-sp.svg",
                      height: 22,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      index == 0 ? "E-Wallet" : "Easy Paisa",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text(
                      "Connected",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
          CustomRoundedButton(
            buttonText: "Add New Card",
            onTap: () {
              RouteNavigator.route(context, CustomCreditCard());
            },
            buttoncolor: Palette.themecolor,
            buttontextcolor: themewhitecolor,
            height: kMinInteractiveDimension,
            width: MediaQuery.of(context).size.width * 0.85,
          ),
        ],
      ),
    );
  }
}
