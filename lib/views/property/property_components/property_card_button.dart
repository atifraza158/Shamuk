import 'package:flutter/material.dart';

import '../../../theme/colors.dart';


class PropertyCardButton extends StatelessWidget {
  const PropertyCardButton({
    super.key,
    required this.onTap,
    required this.child,
    this.isGreen,
  });
  final VoidCallback onTap;
  final Widget child;
  final bool? isGreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isGreen == true
              ? Colors.lightGreen.withOpacity(.7)
              : themeredcolor.withOpacity(.7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.6),
              offset: const Offset(0, 10),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
