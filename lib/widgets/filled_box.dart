import 'package:flutter/material.dart';

class FilledBox extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxBorder? border;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final DecorationImage? image;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final Widget? child;
  final bool applyOpacity;
  final List<Color>? opacityColors;
  final VoidCallback? onTap;
  const FilledBox({
    super.key,
    this.height,
    this.width,
    this.border,
    this.color = const Color(0xffE0E0E0),
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    this.image,
    this.boxShadow,
    this.child,
    this.onTap,
    this.gradient,
    this.applyOpacity = false,
    this.opacityColors,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: border,
          image: image,
          boxShadow: boxShadow,
        ),
        foregroundDecoration: applyOpacity
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: opacityColors!,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: borderRadius,
              )
            : null,
        child: child,
      ),
    );
  }
}
