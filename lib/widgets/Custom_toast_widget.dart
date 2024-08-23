import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
showMyCustomSnackBar(
  String toastMessage,
  bool isError,
  context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      dismissDirection: DismissDirection.down,
      backgroundColor: themewhitecolor.withOpacity(0.9),
      elevation: 7,
      content: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              isError
                  ? "assets/images/png/toast_error.png" 
                  : "assets/images/png/shamuk-s-white.png",
              height: 60,
              // width: 40,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              toastMessage,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeblackcolor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
