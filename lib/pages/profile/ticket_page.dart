import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import 'package:get/get.dart';

import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';
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
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: GradientText(text: "Ticket", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,fontFamily: appFontFamily), gradient:LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),),
          ),
          Container(
            height: 423,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black.withOpacity(0.27)),
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width:Get.width,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(11) ),
                    gradient:LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text("Ticket Details",style: TextStyle(
                      fontFamily: appFontFamily,fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white
                    ),),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GradientText(text:"Event Name",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("NETWORKING DINNER",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: GradientText(text:"Time",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                           colors: [AppColor.primaryColor, AppColor.red],
                           begin: Alignment.centerLeft,
                           end: Alignment.centerRight,
                         ),),
                       ),
                       SizedBox(height: 5,),
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: Text("10:00 AM",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                       ),
                     ],
                   ),
                    SizedBox(width: 80,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText(text:"Date",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                          colors: [AppColor.primaryColor, AppColor.red],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),),
                        SizedBox(height: 5,),
                        Text("20 August 2024 ",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(child: Image.asset(Images.qrCode))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
