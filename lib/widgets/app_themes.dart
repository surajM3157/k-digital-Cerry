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

static aboutCardTitleTextStyle(){
    return TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 15,color: AppColor.white);
}
static aboutCardSubtitleTextStyle(){
    return TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10,color: AppColor.white);
}

static  Widget buildBulletPoint(Widget text,) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("• ", style: TextStyle(fontSize: 20)),
      Expanded(child: text),
    ],
  );
}

 static String capitalizeFirst(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}

showLoader(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: Colors.black26,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:   Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor,),
            ),
          ),
        );
      });
}