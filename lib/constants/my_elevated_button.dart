import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Optional, for responsive design.

class CustomElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  String text;
  Color? color;
  double radius;
  TextStyle? textStyle;
  EdgeInsetsGeometry? padding;
  TextAlign? textAlign;
  CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.radius = 10.0,
    this.textStyle,
    this.padding,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          color ?? ColourConstant.secondaryColour,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
          ),
        ),
        padding: WidgetStateProperty.all(
          padding ??
              EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: textStyle ??
            GoogleFontExtension.buttonTextLight(), // Default text style
      ),
    );
  }
}
