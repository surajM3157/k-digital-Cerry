import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:piwotapp/widgets/gradient_text.dart';

import '../../constants/images.dart';

class About extends StatefulWidget {
   About({super.key,required this.tabController});

  TabController tabController;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: widget.tabController,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26,),
                GradientText(text: "About Event", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
                const SizedBox(height: 12,),
                AppThemes.buildBulletPoint(Text("Innovation drives prosperity, societal progress, and breakthroughs. Welcome to ‘PIWOT – World of Technology,’ led by PanIIT Alumni India and powered by global IIT alumni brilliance. Here, participants forge ideas, products, and services for global impact.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616),)),
                AppThemes.buildBulletPoint(Text("In an era of relentless evolution, we stand as torchbearers, fostering the invaluable art of innovation—a vital skill for businesses, governments, and individuals.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))),
                AppThemes.buildBulletPoint(Text("At PIWOT, we unite global leaders to advance tech innovation, promote sustainability, champion social progress, and foster cultural and ethical excellence.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))),
                const SizedBox(height: 26,),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(Images.conferenceIcon),
                          Text("2 Day"),
                          Text("Conference"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(Images.conferenceIcon),
                          Text("2 Day"),
                          Text("Conference"),
                        ],
                      ),
                    ),
                  ],),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 26,),
                GradientText(text: "About PANIIT", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
                const SizedBox(height: 11,),
                AppThemes.buildBulletPoint(Text("PanIIT is a body of alumni, formed to give back to society and the nation; it is a global community of over 400,000 alumni from all the IITs. It aims to empower the IIT alumni community to drive positive change and transformation in society through innovation.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))), AppThemes.buildBulletPoint(Text("Social impact initiatives by PanIIT paint a large canvas and have become strong movements. Each alumni body has an impact area and a role to play and complements others. Meet them at PIWOT 2025, and join our efforts to contribute to society.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))),
              ],
            ),
          ),
          Container(),
          Container(),
        ]);
  }

}
