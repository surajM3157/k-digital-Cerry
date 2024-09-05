import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';

class AppThemes{

  static TextStyle titleTextStyle()

  {

  return TextStyle(fontSize: 22,fontWeight: FontWeight.w400,fontFamily: appFontFamilyHeadings,color: AppColor.primaryColor);
}

  static TextStyle subtitleTextStyle()

  {

  return TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamilyHeadings,color: AppColor.black);
}

static TextStyle labelTextStyle(){
    return TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w700,fontFamily: appFontFamilyBody);
}

static TextStyle appBarTitleStyle(){
    return TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColor.primaryColor,fontFamily: appFontFamilyHeadings);
}
}