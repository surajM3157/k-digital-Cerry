import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/images.dart';
import '../widgets/custom_tabbar_indicator.dart';
import '../widgets/gradient_text.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage>  with SingleTickerProviderStateMixin{

  TabController? _controller;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: Get.width,
                height: 350,
                child: Image.asset(Images.eventDetailsBanner,fit: BoxFit.cover,)),
            Container(
              margin: EdgeInsets.only(top: 310),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
                ),
                border: Border.all(color: AppColor.white)
              ),
              child: Column(
                children: [
                  Container(
                    height:55,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                      )
                    ),
                    child:  Stack(
                      alignment: Alignment.center,
                      children: [
                        TabBar(
                          controller: _controller,
                          labelStyle: AppThemes.subtitleTextStyle(),
                          indicatorColor: AppColor.primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator:CustomUnderlineTabIndicator(
                            borderSide: BorderSide(width: 2.0, color: AppColor.primaryColor),
                            insets:EdgeInsets.symmetric(vertical: -8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                          ),

                          // UnderlineTabIndicator(
                          //   insets: EdgeInsets.symmetric(vertical: -5),
                          //   borderSide: BorderSide(color: AppColor.white, width: 4.0),
                          //
                          // ),
                          tabs: [
                             Tab(
                              child: Text("Event Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 16,color: AppColor.primaryColor),),
                            ),
                             Tab(
                               child: Text("Agenda",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 16,color: AppColor.primaryColor),),
                            ),
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 1,
                          color: AppColor.white,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  GradientText(text: "Global Connect Conference Session 1",gradient: LinearGradient(
                                    colors: [AppColor.primaryColor, AppColor.red],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),style: AppThemes.titleTextStyle().copyWith(
                                    fontWeight: FontWeight.w600,fontSize: 24
                                  ),),
                                  SizedBox(height: 20,),
                                  Text("Bridging Innovation and Collaboration Worldwide. Connecting Minds, Shaping the Future.",style:AppThemes.subtitleTextStyle().copyWith(fontSize: 16)),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                                      SizedBox(width: 5,),
                                      GradientText(text: "Date & Time",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600), gradient: LinearGradient(
                                        colors: [AppColor.primaryColor, AppColor.red],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("20 August 2024 , Tuesday",style: AppThemes.subtitleTextStyle(),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("10:00 am to 12:00 am",style: AppThemes.subtitleTextStyle(),),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(width: Get.width,
                              height: 1,color: AppColor.darkGrey,
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,size: 17,color: AppColor.primaryColor,),
                                      SizedBox(width: 5,),
                                      GradientText(text:"Location",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient: LinearGradient(
                                        colors: [AppColor.primaryColor, AppColor.red],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("Indian Institute of Technology Delhi, Hauz Khas, Delhi 110016.",style: AppThemes.subtitleTextStyle(),),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(width: Get.width,
                              height: 1,color: AppColor.darkGrey,
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.currency_rupee,size: 17,color: AppColor.primaryColor,),
                                      SizedBox(width: 5,),
                                      GradientText(text:"Ticket Price",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                        colors: [AppColor.primaryColor, AppColor.red],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("4000/- per ticket",style: AppThemes.subtitleTextStyle(),),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(width: Get.width,
                              height: 1,color: AppColor.darkGrey,
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                        ListView(
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Innovation & Leadership",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("• 10:00 AM - 11:00 AM",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("  Opening Keynote: The Future of Global Innovation",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("  Speaker: Dr. Emily Carter, CEO, InnovateCorp",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),

                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Collaboration & Strategy",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("• 11:00 AM - 12:00 AM",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("  Panel Discussion: Leadership in the Age of Technology",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("  Panelists:",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40,right: 20),
                              child: Text("   • Michael Reynolds, CTO, GlobalTech Solutions",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40,right: 20),
                              child: Text("   • Raj Patel, Chief Innovation Officer, Synergy Partners",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBulletPoint(Widget text,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 20)),
        Expanded(child: text),
      ],
    );
  }

}
