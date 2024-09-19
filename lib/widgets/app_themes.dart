import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';

class AppThemes{

  static TextStyle titleTextStyle()

  {

  return TextStyle(fontSize: 22,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.primaryColor);
}

  static TextStyle subtitleTextStyle()

  {

  return TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black);
}

static TextStyle labelTextStyle(){
    return TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w700,fontFamily: appFontFamily);
}

static TextStyle appBarTitleStyle(){
    return TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColor.primaryColor,fontFamily: appFontFamily);
}

static subtitle1TextStyle(){
    return TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 16,color: AppColor.black);
}

static  Widget buildBulletPoint(Widget text,) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("• ", style: TextStyle(fontSize: 20)),
      text,
    ],
  );
}
}