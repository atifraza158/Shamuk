import 'package:flutter/material.dart';

class CustomSmallOutlinedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Size outlinebuttonsize;
  final Color outlinebuttoncolor;
  const CustomSmallOutlinedButton(
      {Key? key,
      required this.onTap,
      required this.child,
      required this.outlinebuttonsize,
      required this.outlinebuttoncolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: outlinebuttoncolor),
        minimumSize: outlinebuttonsize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
