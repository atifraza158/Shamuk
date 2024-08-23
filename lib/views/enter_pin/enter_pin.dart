import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Enter Your Pin",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomRoundedButton(
          buttonText: "Continue",
          onTap: () {
            showAnimatedDialog(
              barrierDismissible: true,
              animationType: DialogTransitionType.slideFromRight,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 700),
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  titlePadding: const EdgeInsets.all(24),
                  actionsPadding: const EdgeInsets.all(0),
                  buttonPadding: const EdgeInsets.all(0),
                  title: Column(
                    children: [
                      Column(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Palette.themecolor,
                            radius: 50,
                            child: Icon(
                              Icons.check,
                              color: themewhitecolor,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Order Successful!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "You have successfully made order",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomRoundedButton(
                        buttonText: "View Order",
                        onTap: () {
                          RouteNavigator.pushandremoveroute(
                            context,
                            NavBar(
                              selectedTab: 2,
                            ),
                          );
                        },
                        height: kMinInteractiveDimension,
                        width: MediaQuery.of(context).size.width * 0.60,
                        buttoncolor: Palette.themecolor,
                        buttontextcolor: themewhitecolor,
                      ),
                      CustomRoundedButton(
                        buttonText: "View E-receipt",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        height: kMinInteractiveDimension,
                        width: MediaQuery.of(context).size.width * 0.60,
                        buttoncolor: themegreytextcolor,
                        buttontextcolor: themewhitecolor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          buttoncolor: Palette.themecolor,
          buttontextcolor: themewhitecolor,
          height: kMinInteractiveDimension,
          width: MediaQuery.of(context).size.width * 0.85,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Text(
                "Enter your PIN to confirm order",
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textFieldOTP(first: true, last: false),
                textFieldOTP(first: false, last: false),
                textFieldOTP(first: false, last: false),
                textFieldOTP(first: false, last: true),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget textFieldOTP({required bool first, last}) {
    return SizedBox(
      width: 70,
      height: 70,
      child: TextField(
        obscureText: true,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: themegreycolor),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: themedarkgreycolor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
