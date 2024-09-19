import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import '../constants/font_family.dart';

class AppButton extends StatelessWidget {
   AppButton({super.key,required this.title,required this.onTap});
  String title;
   Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          // color: AppColor.primaryColor,
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(
          child: Text(
            title,style: TextStyle(color: AppColor.white,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: appFontFamily),
          ),
        ),
      ),
    );
  }
}
