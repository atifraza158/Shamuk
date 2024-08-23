import 'package:flutter/material.dart';

class OutlinedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderWidth;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? child;
  final VoidCallback? onTap;
  const OutlinedBox({
    super.key,
    this.height,
    this.width,
    this.borderWidth = 1.0,
    this.color = Colors.grey,
    this.padding,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: color, width: borderWidth),
        ),
        child: child,
      ),
    );
  }
}
