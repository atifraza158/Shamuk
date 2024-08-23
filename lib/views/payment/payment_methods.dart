import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/enter_pin/enter_pin.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 0,
          title: const Text(
            "Payment Methods",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRoundedButton(
              buttonText: "Apply",
              onTap: () {
                RouteNavigator.route(context, const EnterPinScreen());
              },
              buttoncolor: Palette.themecolor,
              buttontextcolor: themewhitecolor,
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.85,
            )),
        body: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20.0),
              itemCount: 2,
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
                      SvgPicture.asset(
                        "assets/images/svg/wallet-sp.svg",
                        height: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                       Text(
                       index == 0 ? "My Wallet" : "Easy Paisa",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Radio(
                        activeColor: Palette.themecolor,
                        value: index,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(
                            () {
                              _value = index;
                            },
                          );
                        },
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
          ],
        ));
  }
}
