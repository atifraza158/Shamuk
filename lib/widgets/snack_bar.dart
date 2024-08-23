import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

void snackBar(
  context,
  String message, {
  Color color = Palette.themecolor,
  Color textColor = themewhitecolor,
}) {
  final snackBar = SnackBar(
    backgroundColor: color,
    duration: const Duration(milliseconds: 1500),
    content: Text(
      message,
      style: const TextStyle(
        color: themewhitecolor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
