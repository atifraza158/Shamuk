import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multivendor/theme/colors.dart';

show_loading_dialog(context) {
  return showAnimatedDialog(
      barrierDismissible: false,
      animationType: DialogTransitionType.fade,
      curve: Curves.bounceIn,
      duration: const Duration(milliseconds: 300),
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: Palette.themecolor.withOpacity(0.5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                titlePadding: const EdgeInsets.all(24),
                actionsPadding: const EdgeInsets.all(0),
                buttonPadding: const EdgeInsets.all(0),
                title: Container(
                  padding: const EdgeInsets.all(15),
                  // color: Palette.themecolor.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "Please Wait..",
                          style: TextStyle(
                            fontSize: 16,
                            color: themewhitecolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        const SpinKitSquareCircle(
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
}
