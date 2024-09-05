import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/app_themes.dart';

class SessionDetailsPage extends StatefulWidget {
   SessionDetailsPage({super.key,this.title,this.image});
  String? title;
  String? image;

  @override
  State<SessionDetailsPage> createState() => _SessionDetailsPageState();
}

class _SessionDetailsPageState extends State<SessionDetailsPage> {


  @override
  void initState() {
    // Get.arguments['sessionModel'] =
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      width: Get.width,
                      height: 390,

                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                          child: Image.asset(widget.image??"",fit: BoxFit.cover,))),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.arrow_back_ios,size: 24,color: AppColor.white,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.share,size: 24,color: AppColor.white,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(widget.title??"",style: AppThemes.titleTextStyle().copyWith(
                            fontWeight: FontWeight.w600,fontSize: 24
                        ),),
                        SizedBox(height: 20,),
                        Text("Bridging Innovation and Collaboration Worldwide. Connecting Minds, Shaping the Future.",style:AppThemes.subtitleTextStyle().copyWith(fontSize: 16)),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                            SizedBox(width: 5,),
                            Text("Date & Time",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w400),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("22 September 2024 , Tuesday",style: AppThemes.subtitleTextStyle(),),
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
                            Text("Location",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w400),),
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
                            Text("Ticket Price",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w400),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("3000/- per ticket",style: AppThemes.subtitleTextStyle(),),
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
            ],
          ),
        ),
      ),
    );
  }
}
