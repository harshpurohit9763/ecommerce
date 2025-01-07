import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontExtension extends TextStyle {
  static TextStyle bodyTextNormal(
          {double? size = 12, FontWeight? fontWeight = FontWeight.w500}) =>
      GoogleFonts.poppins(fontSize: size?.sp, fontWeight: fontWeight);

  static TextStyle buttonTextLight(
          {double? size = 12, FontWeight? fontWeight = FontWeight.bold}) =>
      GoogleFonts.poppins(
          fontSize: size?.sp, color: Colors.white, fontWeight: fontWeight);
}
