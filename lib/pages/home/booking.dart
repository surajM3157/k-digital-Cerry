import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:piwotapp/widgets/my_seperator.dart';

import '../../constants/images.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width,
              child: Image.asset(Images.ticketBanner,fit: BoxFit.cover,)),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Event Name",style: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamilyHeadings,fontSize: 14),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Global Connect Conference Session 1",style: AppThemes.titleTextStyle().copyWith(color: AppColor.black),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Time",style: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamilyHeadings,fontSize: 14),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("10:00 AM",style: AppThemes.titleTextStyle().copyWith(color: AppColor.black),),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("Date",style: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamilyHeadings,fontSize: 14),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("20 August 2024 ",style: AppThemes.titleTextStyle().copyWith(color: AppColor.black),),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          MySeparator(color: AppColor.darkGrey,),
          SizedBox(height: 50,),
          Center(child: Image.asset(Images.qrCode))
        ],
      ),
    );
  }
}
