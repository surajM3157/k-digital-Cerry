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
            height: Get.height/1.4,
            width: Get.width,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Get.height,
                  width: 288,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                          child: Image.asset(Images.eventDetailsBanner)),
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
                        height: 50,
                      ),
                      Center(child: Image.asset(Images.qrCode,height: 106,width: 106,))
                    ],
                  ),
                ),
                Positioned(
                    left: -7,
                    bottom: 80,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration:  BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle
                      ),
                    )),
                Positioned(
                    right: -7,
                    bottom: 80,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration:  BoxDecoration(
                          color: AppColor.red,
                          shape: BoxShape.circle
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
