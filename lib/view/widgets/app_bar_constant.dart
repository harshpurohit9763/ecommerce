import 'package:ecommerce_app/constants/colour_constant.dart';
import 'package:ecommerce_app/constants/font_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarConstant extends StatelessWidget implements PreferredSizeWidget {
  AppBarConstant({
    super.key,
    this.onPressed,
    this.width,
    this.tralingIcon,
    required this.text,
  });
  final String text;
  double? width;
  Widget? tralingIcon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              onPressed != null
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.arrow_back,
                        size: 22.sp,
                        color: Colors.white,
                      ))
                  : Container(),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: 0.4.sw,
                child: Text(
                  text,
                  style: GoogleFontExtension.buttonTextLight(
                      fontWeight: FontWeight.w500, size: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          tralingIcon ?? Container()
        ],
      ),
      backgroundColor: ColourConstant.ternaryColour,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
