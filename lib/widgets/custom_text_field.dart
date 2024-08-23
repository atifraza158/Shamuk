import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Widget? label;
  final TextInputType textInputType;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? cursorTextStyle;
  final double? cursorHeight;
  final Color? cursorColor;
  final double? width;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final bool autoFocus;
  final Color? fillColor;
  final bool? isDense;
  final bool isCollapsed;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final double outlineBorderRadius;
  final TextStyle? hintTextStyle;
  final bool isOutlinedInputBorder;
  final bool isunderlinedInputBorder;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? alignLabelWithHint;
  const CustomTextField({
    super.key,
    this.textEditingController,
    this.maxLines,
    this.hintText,
    this.labelText,
    this.label,
    required this.textInputType,
    this.prefix,
    this.suffix,
    this.width,
    this.cursorTextStyle = const TextStyle(
      fontSize: 16,
    ),
    this.cursorHeight,
    this.cursorColor = Colors.grey,
    this.padding = const EdgeInsets.all(12),
    this.filled = false,
    this.fillColor,
    this.autoFocus = false,
    this.isDense = true,
    this.isCollapsed = false,
    this.hintTextStyle = const TextStyle(
      fontSize: 16,
    ),
    this.enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    this.focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    this.enabledBorderColor = Colors.transparent,
    this.focusedBorderColor = Colors.transparent,
    this.outlineBorderRadius = 8,
    this.isOutlinedInputBorder = false,
    this.isunderlinedInputBorder = false,
    this.validator,
    this.borderWidth = 1.0,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.alignLabelWithHint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        maxLines: maxLines,
        autofocus: autoFocus,
        cursorColor: cursorColor,
        style: cursorTextStyle,
        cursorHeight: cursorHeight,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: padding,
          filled: filled,
          fillColor: fillColor,
          enabledBorder: isOutlinedInputBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledBorderColor!,
                    width: borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(outlineBorderRadius),
                )
              : isunderlinedInputBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: enabledBorderColor!,
                        width: borderWidth,
                      ),
                    )
                  : enabledBorder,
          focusedBorder: isOutlinedInputBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedBorderColor!,
                    width: borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(outlineBorderRadius),
                )
              : isunderlinedInputBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: focusedBorderColor!,
                        width: borderWidth,
                      ),
                    )
                  : focusedBorder,
          isDense: isDense,
          isCollapsed: isCollapsed,
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hintText,
          hintStyle: hintTextStyle,
          labelText: labelText,
          label: label,
          floatingLabelAlignment: floatingLabelAlignment,
          floatingLabelBehavior: floatingLabelBehavior,
          alignLabelWithHint: alignLabelWithHint,
        ),
      ),
    );
  }
}
