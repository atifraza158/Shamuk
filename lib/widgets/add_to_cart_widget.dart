import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:multivendor/navigation/nav_bar.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_simple_rounded_button.dart';

addToCartDialogWidget(context) {
  return showAnimatedDialog(
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottom,
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
                  'Item Added!',
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
            CustomSimpleRoundedButton(
              onTap: () {
                Navigator.pop(context);
              },
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.60,
              buttoncolor: themegreycolor,
              borderRadius: BorderRadius.circular(25),
              child: const Text("Done"),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSimpleRoundedButton(
              onTap: () {
                // RouteNavigator.pushandremoveroute(
                //     context,
                //     NavBar(
                //       selectedTab: 1,
                //     ));
                Navigator.pop(context);
                context.replaceNamed('bottomNavBar', queryParams: {
                  'selectedTab': '1',
                });
              },
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.60,
              buttoncolor: Palette.themecolor,
              borderRadius: BorderRadius.circular(25),
              child: const Text(
                "View Cart",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
