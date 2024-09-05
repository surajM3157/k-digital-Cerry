import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'package:get/get.dart';

import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/my_seperator.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text("Ticket",style:  AppThemes.appBarTitleStyle(),),
        )),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.fromLTRB(20, 50, 20, 60),
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
      ),
    );
  }
}
